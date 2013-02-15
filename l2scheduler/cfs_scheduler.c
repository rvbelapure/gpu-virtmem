#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <string.h>
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
#include <unistd.h>
#include "cfs_scheduler.h"


scheduler_data Scheduler_Data;
int semid;

void sem_cleanup_and_exit(int signo)
{
	printf("CFSCHED Removing semaphore and exiting\n");
	unlink(LISTEN_PATH);
	system("rm -f /tmp/GPU_CWRITE*");
	system("rm -f /tmp/GPU_CREAD*");
	semctl(semid, 0, IPC_RMID);
	exit(0);
}
/*
int cpu_bind(const unsigned short cpu) 
{ 
	cpu_set_t mask; 
	int ret; 

	CPU_ZERO(&mask); 
	CPU_SET((int)cpu, &mask); 
	ret = sched_setaffinity(0, sizeof mask, &mask); 

	return ret; 
} 
*/

int already_added(process_credit_data pcd)
{
	int i;
	for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
	{
		if(Scheduler_Data.process_list[i] == pcd.pid)
			return 1;
	}
	return 0;
}

void* listen_thread(void *thid)
{
	int err, listen_fifo, client_resp_fifo, client_req_fifo, signum;
	process_credit_data pcd;
	
	printf("CFSCHED starting listener\n");

	err = mkfifo(LISTEN_PATH, 0666);
	if(err != 0 && errno == EEXIST) 
	{
		printf("CFSCHED named pipe 0 exists\n") ;
	}
	int i;
	for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
		Scheduler_Data.valid[i] = 0;

	listen_fifo = open(LISTEN_PATH, O_RDWR); 
	int status;
	char target[100],src[50];
	while(1)
	{
		status = read(listen_fifo, &pcd, sizeof(process_credit_data));
		printf("CFSCHED read status : %d\n",status);
		if((status > 0) && (pcd.action == ADD_Q) && !already_added(pcd))
		{
			printf("CFSCHED ADD_Q pid: %d, share_unit: %lu\n", pcd.pid, pcd.share_unit) ;

			signum = SIGRTMIN + Scheduler_Data.RT_signal_indx++;

			strcpy(target,CLIENT_READ_PATH);
			sprintf(src,"%ld",pcd.pid);
			strcat(target,src);

			mkfifo(target,0666);
			client_resp_fifo = open(target, O_WRONLY);
			write(client_resp_fifo, &signum, sizeof(int)) ;

			strcpy(target,CLIENT_WRITE_PATH);
			strcat(target,src);

			mkfifo(target,0666);
			client_req_fifo = open(target, O_RDONLY);
			read(client_req_fifo, &err, sizeof(int));

			printf("CFSCHED err:%d\n", err);
		//	sleep(5);
			close(client_resp_fifo);
			close(client_req_fifo);
			if(!err)
			{
				union sigval data;
				//sleep the thread before adding it
				data.sival_int = signum;
				sigqueue(pcd.pid, signum, data);
				register_process(pcd.pid, signum, pcd.share_unit);
			}
		}
		else if(pcd.action == REM_Q)
		{
			printf("CFSCHED REM_Q pid: %d\n", pcd.pid);
			int i;
			for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
			{
				if(pcd.pid == Scheduler_Data.process_list[i])
				{
					Scheduler_Data.process_list[i] = INVALID_PROCEESS;
					Scheduler_Data.valid[i] = 0;
					break;
				}
			} 
			char write_target[100], read_target[100]; 
			strcpy(write_target, CLIENT_WRITE_PATH);
			strcpy(read_target, CLIENT_READ_PATH);
			sprintf(src, "%ld", pcd.pid);
			strcat(write_target,src);
			strcat(read_target,src);
			unlink(write_target);
			unlink(read_target);
		}
		else
		{
			printf("CFSCHED Illegal pcd read from pipe\n");
		}
	}
	return NULL;
}

void* control_thread(void *thid_arr)
{
	unsigned thid = 0, i;
	union sigval data;
	sigset_t set, set1, set2;
	struct timeval tp;

	sigemptyset(&set);
	for(i = SIGRTMIN; i <= SIGRTMAX; i++)
		sigaddset(&set, SIGRTMIN);

	pthread_sigmask(SIG_BLOCK, &set, NULL);
	printf("CFSCHED Inside control thread\n");
	sleep(10);
	//cpu_bind(0);	

	while(1)
	{
		if(!Scheduler_Data.polling_thread_count)
			continue;

		if(Scheduler_Data.valid[thid] == 0)
		{
			thid++;
			if(thid > Scheduler_Data.polling_thread_count-1)
				thid = 0;
			continue;
		}

		pid_t process_id = Scheduler_Data.process_list[thid];
		unsigned long share_unit;
		share_unit = Scheduler_Data.share_unit[thid];
		int signum = Scheduler_Data.signal_num[thid];

		sigset_t polling_thread_set;
		sigemptyset(&polling_thread_set);
		sigaddset(&polling_thread_set, signum);

		if(process_id != INVALID_PROCEESS)
		{
			gettimeofday(&tp, NULL); 
			fprintf(stderr, "CFSCHED control thread starting process id: %d, signum: %d, share_unit:%lu time:%d sec %d usec\n", process_id, signum, share_unit, tp.tv_sec, tp.tv_usec);
	 
			//data.sival_ptr = (void *)(&polling_thread_set);
			data.sival_int = signum;
			sigqueue(process_id, signum, data);
		}
		thid++;
		if(thid > Scheduler_Data.polling_thread_count-1)
			thid = 0;

		if(process_id != INVALID_PROCEESS)
		{
			struct timespec ts;
			ts.tv_sec = 0;
			ts.tv_nsec = 1000000 * share_unit; // sleep for share_unit milliseconds
			nanosleep(&ts,NULL);
			//data.sival_ptr = (void *)(&polling_thread_set);
			gettimeofday(&tp, NULL); 
			fprintf(stderr, "CFSCHED control thread sleeping process id: %d, signum: %d, share_unit:%lu time:%d sec %d usec\n", process_id, signum, share_unit, tp.tv_sec, tp.tv_usec);
	 
			data.sival_int = signum;
			sigqueue(process_id, signum, data);   
		}
	}
	return NULL;
}

void register_process(pid_t process_id, int signum, unsigned long share_unit)
{
	printf("CFSCHED process %d registered with scheduler, signum : %d, share unit %ld\n",process_id, signum, share_unit);
	Scheduler_Data.process_list[Scheduler_Data.polling_thread_count] = process_id;
	Scheduler_Data.share_unit[Scheduler_Data.polling_thread_count] = share_unit;
	Scheduler_Data.signal_num[Scheduler_Data.polling_thread_count] = signum;
	Scheduler_Data.valid[Scheduler_Data.polling_thread_count] = 1;
	Scheduler_Data.polling_thread_count++;
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


int start_scheduler()
{
	pthread_t thID1, thID2;
	int n = 0, i;
	sigset_t set, set1, set2;
	union sigval data;

	if((semid = semget(ftok(SEMKEYPATH, SEMKEYID), 1, 0666 | IPC_CREAT | IPC_EXCL )) == -1){
		perror("semget failed");
		return -1;
	}

	semctl(semid, 0, SETVAL, 1) ;

	struct sigaction act;
	act.sa_handler = &sem_cleanup_and_exit;
	sigemptyset(&act.sa_mask);
	for(i = SIGRTMIN; i <= SIGRTMAX; i++)
		sigaddset(&act.sa_mask, SIGRTMIN);
	act.sa_flags = 0;

	if(sigaction(SIGINT, &act, NULL) < 0)
	{
		printf("SIGINT handler registration failed. semaphores may not be cleared.\n");
		return -1;
	}

	pthread_create(&thID1, NULL, listen_thread, NULL);
	pthread_create(&thID2, NULL, control_thread, NULL);

	printf("In main thID1:%d\n", (int)thID1);
	printf("In main thID2:%d\n", (int)thID2);

	pthread_join(thID2, NULL);
	pthread_join(thID1, NULL);

	return 0;
}

int main()
{
	signal_block_all();
	start_scheduler();
}
