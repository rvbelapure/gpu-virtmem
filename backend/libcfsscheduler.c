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
#include "../l2scheduler/cfs_scheduler.h"
#include <unistd.h>
#include <fcntl.h>
#include <wait.h>

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


int register_handler(int signum)
{
  sigset_t set;
  sigemptyset(&set);
  sigaddset(&set, signum);
  
  sigprocmask(SIG_UNBLOCK, &set, NULL);

  struct sigaction act;
  act.sa_sigaction = &mysignalhandler1;
  act.sa_flags = SA_SIGINFO;

  fprintf(stderr, "CFSCHED Registering handler for process id: %d, thread id: %d on signum: %d\n", getpid(), (int)pthread_self(), signum);
  if(sigaction(signum, &act, NULL) < 0)
    {
      fprintf(stderr, "CFSCHED handler registration failed\n");
      return -1;
    }
  return 0;
}


int add_queue(pid_t process_id, /*int unsigned GPU_id,*/ unsigned long share_unit)
{
  int server_fifo, client_read_fifo, client_write_fifo, signum, err;
  int semid;
  char write_target[100], read_target[100], src[50];

  process_credit_data pcd;
  pcd.pid = getpid();
  pcd.share_unit = share_unit;
  pcd.action = ADD_Q;

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
  server_fifo = open(LISTEN_PATH, O_WRONLY);
  write(server_fifo, &pcd, sizeof(process_credit_data));
  close(server_fifo);

  client_read_fifo = open(read_target, O_RDONLY);
  read(client_read_fifo, &signum, sizeof(int));
  fprintf(stderr, "CFSCHED signum: %d\n", signum);

  err = register_handler(signum);

  client_write_fifo = open(write_target, O_WRONLY);
  write(client_write_fifo, &err, sizeof(int));
  fprintf(stderr, "CFSCHED Exit CS\n");
  close(client_read_fifo);
  close(client_write_fifo);
  /****Exit CS*****/
  V(semid);

  return signum;
}

int rem_queue(pid_t process_id)
{
  process_credit_data pcd;
  int semid, fifo_d_0;
  char write_target[100], read_target[100], src[50];
  pcd.pid = getpid();
  pcd.action = REM_Q;
  if((semid = semget(ftok(SEMKEYPATH, SEMKEYID), 1, 0666)) == -1){
    perror("semget failed");
    return -1;
  }
 //fflush(stdout); 
  P(semid);
  fifo_d_0 = open(LISTEN_PATH, O_WRONLY);
  write(fifo_d_0, &pcd, sizeof(process_credit_data)) ;
  close(fifo_d_0);
  V(semid);

  return 0;
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


