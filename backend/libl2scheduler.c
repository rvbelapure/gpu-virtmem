#include <stdio.h>
#include<sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <time.h>
#include <sched.h>
#include "../l2scheduler/fair_share_sched.h"
#include "../l2scheduler/las_scheduler.h"
#include <unistd.h>
#include <fcntl.h>
#include <wait.h>
#include <string.h>

int semid;

static int P(int semID) { 
  struct sembuf buff ;
  buff.sem_num = 0 ;
  buff.sem_op = -1 ;
  buff.sem_flg = 0 ;
  printf("CFSCHED In P operation\n");
  if(semop(semID, &buff, 1) == -1) 
    { 
      perror("CFSCHED semop P operation error") ; 
      return 0 ;
    }
  return -1 ; 
}

static int V(int semID) { 
  struct sembuf buff ;
  buff.sem_num = 0 ;
  buff.sem_op = 1 ;
  buff.sem_flg = 0 ;
  if(semop(semID, &buff, 1) == -1) 
    { 
      perror("CFSCHED semop V operation error") ; 
      return 0 ;
    }
  return -1 ; 
}

void mysignalhandler1(int n, siginfo_t* info, void* k)
{
  sigset_t set;
  int signalid;
  union sigval data = info->si_value;
  struct timeval tp;
  //set = (sigset_t *)data.sival_ptr;
  signalid = data.sival_int;
  sigemptyset(&set);
  sigaddset(&set, signalid);
 
  gettimeofday(&tp, NULL); 
  fprintf(stderr, "CFSCHED Signal to sleep to process id: %d with signal id:%d time:%d sec %d usec\n", (int)getpid(), signalid, tp.tv_sec, tp.tv_usec);
  signalid = sigwaitinfo(&set, NULL);
  gettimeofday(&tp, NULL); 
  fprintf(stderr, "CFSCHED Signal to wake up process id: %d with signal id:%d time:%d sec %d usec\n", (int)getpid(), signalid, tp.tv_sec, tp.tv_usec);

}


int fs_register_handler(int signum)
{
  sigset_t set;
  sigemptyset(&set);
  sigaddset(&set, signum);
  
  sigprocmask(SIG_UNBLOCK, &set, NULL);

  struct sigaction act;
  act.sa_sigaction = &mysignalhandler1;
  act.sa_flags = SA_SIGINFO | SA_RESTART;

  fprintf(stderr, "CFSCHED Registering handler for process id: %d, thread id: %d on signum: %d\n", getpid(), (int)pthread_self(), signum);
  if(sigaction(signum, &act, NULL) < 0)
    {
      fprintf(stderr, "CFSCHED handler registration failed\n");
      return -1;
    }
  return 0;
}

void fs_notify_scheduler(struct timeval *before, struct timeval *after, int gpuid)
{  
  if(gpuid == -1)
	  return;

  int server_fifo;
  int semid;

  process_credit_data pcd;
  pcd.pid = getpid();
  pcd.share_unit = 0;	/* deprecated : define app_type instead */
  pcd.action = NOTIFY_SCHED;
  pcd.app_type = 0;
  timersub(after,before,&pcd.execution_time);
 
  if((semid = semget(ftok(SEMKEYPATH, SEMKEYID), 1, 0666)) == -1){
    perror("semget failed");
    return;
  }
  char sched_listen_path[100];
  FILE *fp = fopen(SCHED_DEF_FILE_PATH,"r");
  int gpu; char tid[25];

  //fflush(stdout); 
  strcpy(sched_listen_path,LISTEN_PATH);
  while(!feof(fp))
  {
	  fscanf(fp,"%d\t%s\n",&gpu,tid);
	  if(gpu == gpuid)
	  {
		  strcat(sched_listen_path,tid);
		  P(semid);
		  server_fifo = open(sched_listen_path, O_WRONLY);
		  write(server_fifo, &pcd, sizeof(process_credit_data));
		  close(server_fifo);
		  V(semid);
		  break;
	  }
  }
  fclose(fp);

  return;
}


int fs_add_queue(pid_t process_id, unsigned int gpuid, unsigned long app_type)
{
  int server_fifo, client_read_fifo, client_write_fifo, signum, err;
  int semid;
  char write_target[100], read_target[100], src[50];
  char sched_listen_path[100];
  strcpy(sched_listen_path,LISTEN_PATH);
  FILE *fp = fopen(SCHED_DEF_FILE_PATH,"r");
  unsigned int gpu; char tid[25];
  while(!feof(fp))
  {
	  fscanf(fp,"%d\t%s\n",&gpu,tid);
	  if(gpu == gpuid)
	  {
		  strcat(sched_listen_path,tid);
		  break;
	  }
  }
  fclose(fp);

  process_credit_data pcd;
  pcd.pid = process_id;
  pcd.share_unit = 0;	/* deprecated : define app_type instead */
  pcd.action = ADD_Q;
  pcd.app_type = app_type;
  pcd.gpuid = gpuid;

  fprintf(stderr, "CFSCHED Inside add_queue pid : %d\n",getpid());

  strcpy(write_target, CLIENT_WRITE_PATH);
  strcpy(read_target, CLIENT_READ_PATH);
  sprintf(src, "%ld", pcd.pid);
  strcat(write_target,src);
  strcat(read_target,src);
  mkfifo(write_target,0666);
  mkfifo(read_target,0666);
 
  if((semid = semget(ftok(SEMKEYPATH, SEMKEYID), 1, 0666)) == -1){
    perror("semget failed");
    return -1;
  }
 //fflush(stdout); 
  P(semid);
  /*****Enter CS*******/
  fprintf(stderr, "CFSCHED Enter CS\n");
  server_fifo = open(sched_listen_path, O_WRONLY);
  write(server_fifo, &pcd, sizeof(process_credit_data));
  close(server_fifo);

  client_read_fifo = open(read_target, O_RDONLY);
  read(client_read_fifo, &signum, sizeof(int));
  fprintf(stderr, "CFSCHED signum: %d\n", signum);

  err = fs_register_handler(signum);

  client_write_fifo = open(write_target, O_WRONLY);
  write(client_write_fifo, &err, sizeof(int));
  fprintf(stderr, "CFSCHED Exit CS\n");
  close(client_read_fifo);
  close(client_write_fifo);
  /****Exit CS*****/
  V(semid);

  return signum;
}

int fs_rem_queue(pid_t process_id, int gpuid)
{
  if(gpuid == -1)
	  return 0;

  process_credit_data pcd;
  int semid, fifo_d_0;
  char write_target[100], read_target[100], src[50];
  pcd.pid = getpid();
  pcd.action = REM_Q;
  if((semid = semget(ftok(SEMKEYPATH, SEMKEYID), 1, 0666)) == -1){
    perror("semget failed");
    return -1;
  }
  char sched_listen_path[100];
  FILE *fp = fopen(SCHED_DEF_FILE_PATH,"r");
  int gpu; char tid[25];

  //fflush(stdout); 
  strcpy(sched_listen_path,LISTEN_PATH);
  while(!feof(fp))
  {
	  fscanf(fp,"%d\t%s\n",&gpu,tid);
	  if(gpu == gpuid)
	  {
		  strcat(sched_listen_path,tid);

		  P(semid);
		  fifo_d_0 = open(sched_listen_path, O_WRONLY);
		  write(fifo_d_0, &pcd, sizeof(process_credit_data));
		  close(fifo_d_0);
		  V(semid);
		  break;
	  }
  }
  fclose(fp);


  return 0;
}

int fs_get_RTsignal(pid_t process_id)
{  
  process_credit_data pcd;
  int semid, fifo_d_0, signum, client_read_fifo;
  char write_target[100], read_target[100], src[50];
  pcd.pid = process_id;
  pcd.action = GET_SIGNUM;
  if((semid = semget(ftok(SEMKEYPATH, SEMKEYID), 1, 0666)) == -1){
    perror("semget failed");
    return -1;
  }
  char sched_listen_path[100];
  FILE *fp = fopen(SCHED_DEF_FILE_PATH,"r");
  int gpu; char tid[25];

  strcpy(read_target, CLIENT_SIGGET_PATH);
  sprintf(src, "%ld", pcd.pid);
  strcat(read_target,src);
  mkfifo(read_target,0666);

  //fflush(stdout); 
  signum = -1;
  while(!feof(fp))
  {
  	  strcpy(sched_listen_path,LISTEN_PATH);
	  fscanf(fp,"%d\t%s\n",&gpu,tid);
	  fprintf(stderr,"CFSCHED %d\t%s\n",gpu,tid);
	  strcat(sched_listen_path,tid);
	  fprintf(stderr,"CFSCHED writing to %s, reading from %s\n",sched_listen_path,read_target);

	  P(semid);
	  fifo_d_0 = open(sched_listen_path, O_WRONLY);
	  write(fifo_d_0, &pcd, sizeof(process_credit_data));
	  close(fifo_d_0);
	  client_read_fifo = open(read_target, O_RDONLY);
	  read(client_read_fifo, &signum, sizeof(int));
	  close(client_read_fifo);
	  V(semid);
	  if(signum != -1)
		  break;
  }
  fclose(fp);
  return signum;
}

void signal_block_all()
{
  int i;
  sigset_t set;
  union sigval data;
  
  sigemptyset(&set);
  for(i = SIGRTMIN; i <= SIGRTMAX; i++)
    sigaddset(&set, i);
 
  sigprocmask(SIG_BLOCK, &set, NULL);
}

////////////////////////////////////////////////////////////////////////////////

int las_add_queue(pid_t process_id, unsigned int gpuid, int app_type)
{
  int server_fifo, client_read_fifo, client_write_fifo, signum, err;
  int semid;
  char write_target[100], read_target[100], src[50];
  char sched_listen_path[100];
  strcpy(sched_listen_path,LISTEN_PATH);
  FILE *fp = fopen(SCHED_DEF_FILE_PATH,"r");
  int gpu; char tid[25];
  while(!feof(fp))
  {
	  fscanf(fp,"%d\t%s\n",&gpu,tid);
	  if(gpu == gpuid)
	  {
		  strcat(sched_listen_path,tid);
		  break;
	  }
  }
  fclose(fp);

  process_credit_data pcd;
  pcd.pid = process_id;
  pcd.action = ADD_Q;
  pcd.app_type = app_type;
  pcd.gpuid = gpuid;

  fprintf(stderr, "LASSCHED Inside add_queue pid : %d\n",getpid());

  strcpy(read_target, CLIENT_READ_PATH);
  sprintf(src, "%ld", pcd.pid);
  strcat(read_target,src);
  mkfifo(read_target,0666);
 
  if((semid = semget(ftok(SEMKEYPATH, SEMKEYID), 1, 0666)) == -1){
    perror("semget failed");
    return -1;
  }
 //fflush(stdout); 
  client_read_fifo = open(read_target, O_RDWR);
  server_fifo = open(sched_listen_path, O_WRONLY);
  fprintf(stderr, "LASSCHED Enter CS\n");
  P(semid);
  /*****Enter CS*******/
  write(server_fifo, &pcd, sizeof(process_credit_data));
  V(semid);
  close(server_fifo);
  read(client_read_fifo, &signum, sizeof(int));
  fprintf(stderr, "LASSCHED index: %d\n", signum);
  close(client_read_fifo);
  /****Exit CS*****/

  return signum;
}


int las_rem_queue(pid_t process_id, int gpuid)
{
  if(gpuid == -1)
	  return 0;

  process_credit_data pcd;
  int semid, fifo_d_0;
  char write_target[100], read_target[100], src[50];
  pcd.pid = getpid();
  pcd.action = REM_Q;
  if((semid = semget(ftok(SEMKEYPATH, SEMKEYID), 1, 0666)) == -1){
    perror("semget failed");
    return -1;
  }
  char sched_listen_path[100];
  FILE *fp = fopen(SCHED_DEF_FILE_PATH,"r");
  int gpu; char tid[25];

  //fflush(stdout); 
  strcpy(sched_listen_path,LISTEN_PATH);
  while(!feof(fp))
  {
	  fscanf(fp,"%d\t%s\n",&gpu,tid);
	  if(gpu == gpuid)
	  {
		  strcat(sched_listen_path,tid);

		  fifo_d_0 = open(sched_listen_path, O_WRONLY);
		  P(semid);
		  write(fifo_d_0, &pcd, sizeof(process_credit_data));
		  V(semid);
		  close(fifo_d_0);
		  break;
	  }
  }
  fclose(fp);


  return 0;
}


void las_notify_scheduler(struct timeval *before, struct timeval *after, int gpuid)
{  
  if(gpuid == -1)
	  return;

  int server_fifo;
  int semid;

  process_credit_data pcd;
  pcd.pid = getpid();
  pcd.share_unit = 0;	/* deprecated : define app_type instead */
  pcd.action = NOTIFY_SCHED;
  pcd.app_type = 0;
  timersub(after,before,&pcd.execution_time);
 
  if((semid = semget(ftok(SEMKEYPATH, SEMKEYID), 1, 0666)) == -1){
    perror("semget failed");
    return;
  }
  char sched_listen_path[100];
  FILE *fp = fopen(SCHED_DEF_FILE_PATH,"r");
  int gpu; char tid[25];

  //fflush(stdout); 
  strcpy(sched_listen_path,LISTEN_PATH);
  while(!feof(fp))
  {
	  fscanf(fp,"%d\t%s\n",&gpu,tid);
	  if(gpu == gpuid)
	  {
		  strcat(sched_listen_path,tid);
		  server_fifo = open(sched_listen_path, O_WRONLY);
		  P(semid);
		  write(server_fifo, &pcd, sizeof(process_credit_data));
		  V(semid);
		  close(server_fifo);
		  break;
	  }
  }
  fclose(fp);

  return;
}

int las_get_priority(int index, int gpuid)
{
  if(gpuid == -1)
	  return -1;

  process_credit_data pcd;
  int semid, fifo_d_0, read_fifo;
  char write_target[100], read_target[100], src[50];
  pcd.pid = getpid();
  pcd.action = GET_PRIORITY;
  pcd.gpuid = index;			// gpuid field used to send index

  if((semid = semget(ftok(SEMKEYPATH, SEMKEYID), 1, 0666)) == -1){
    perror("semget failed");
    return -1;
  }
  char sched_listen_path[100];
  FILE *fp = fopen(SCHED_DEF_FILE_PATH,"r");
  int gpu; char tid[25];  
  
  strcpy(read_target, CLIENT_READ_PATH);
  sprintf(src, "%ld", pcd.pid);
  strcat(read_target,src);
  mkfifo(read_target,0666);

  int priority;

  //fflush(stdout); 
  strcpy(sched_listen_path,LISTEN_PATH);
  while(!feof(fp))
  {
	  fscanf(fp,"%d\t%s\n",&gpu,tid);
	  if(gpu == gpuid)
	  {
		  strcat(sched_listen_path,tid);

		  read_fifo = open(read_target, O_RDWR);
		  P(semid);
		  fifo_d_0 = open(sched_listen_path, O_WRONLY);
		  write(fifo_d_0, &pcd, sizeof(process_credit_data));
		  close(fifo_d_0);

  		  read(read_fifo, &priority, sizeof(int));
		  close(read_fifo);
		  V(semid);
		  break;
	  }
  }
  fclose(fp);

  return priority;
}

int las_get_l2_data(int gpuid, int index, int * application, struct timeval * total_ex_time)
{
	if(gpuid == -1)
	  return 0;

	process_credit_data pcd;
	int semid, fifo_d_0, read_fifo;
	char write_target[100], read_target[100], src[50];
	pcd.pid = getpid();
	pcd.action = GET_L2_DATA;
	pcd.gpuid = index;			// gpuid field used to send index

	if((semid = semget(ftok(SEMKEYPATH, SEMKEYID), 1, 0666)) == -1){
	perror("semget failed");
	return -1;
	}
	char sched_listen_path[100];
	FILE *fp = fopen(SCHED_DEF_FILE_PATH,"r");
	int gpu; char tid[25];  

	strcpy(read_target, CLIENT_READ_PATH);
	sprintf(src, "%ld", pcd.pid);
	strcat(read_target,src);
	mkfifo(read_target,0666);

	int priority;

	//fflush(stdout); 
	strcpy(sched_listen_path,LISTEN_PATH);
	while(!feof(fp))
	{
	  fscanf(fp,"%d\t%s\n",&gpu,tid);
	  if(gpu == gpuid)
	  {
		  strcat(sched_listen_path,tid);

		  printf("GETL2DATA writing pcd to %s, pid %ld\n",sched_listen_path,getpid());
		  read_fifo = open(read_target, O_RDWR);
		  P(semid);
		  fifo_d_0 = open(sched_listen_path, O_WRONLY);
		  write(fifo_d_0, &pcd, sizeof(process_credit_data));
		  close(fifo_d_0);
		  V(semid);
		  printf("GETL2DATA written pcd to %s, pid %ld\n",sched_listen_path,getpid());
		  read(read_fifo, &pcd, sizeof(process_credit_data));
		  close(read_fifo);
		  printf("GETL2DATA reading pcd from %s, pid %ld\n",read_target,getpid());
		  *application = pcd.app_type;
		  *total_ex_time = pcd.execution_time;
		  break;
	  }
	}
	fclose(fp);
	if(pcd.action == 1)
		return 1;
	else
		return 0;
}
