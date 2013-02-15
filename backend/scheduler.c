#define _GNU_SOURCE

#include<stdio.h>
#include <stdlib.h>
#include<unistd.h>
#include<pthread.h>
#include<signal.h>
#include<sys/time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ipc.h>
#include <sys/sem.h>

#include <sched.h>

#define MAX_CONTROLLER_COUNT 100
#define FIFO_PATH_0 "/tmp/GPU_A0"
#define FIFO_PATH_1 "/tmp/GPU_A1"

#define SEMKEYPATH "/dev/null"  /* Path used on ftok for semget key  */
#define SEMKEYID 1              /* Id used on ftok for semget key    */

#define ADD_Q 10
#define REM_Q 11

#define INVALID_PROCEESS 999

typedef struct _process_credit_data{
	pid_t pid;
	unsigned long share_unit;
	int action;
}process_credit_data;

typedef struct _scheduler_datastructure{
	pid_t process_list[MAX_CONTROLLER_COUNT];
	unsigned long share_unit[MAX_CONTROLLER_COUNT];
	int signal_num[MAX_CONTROLLER_COUNT];
	unsigned polling_thread_count;
	unsigned RT_signal_indx;
}scheduler_data;

scheduler_data Scheduler_Data;
int semid;

void register_process(pid_t process_id, int signum, unsigned long share_unit);
int add_queue(pid_t process_id, /*int unsigned GPU_id,*/ unsigned long share_unit);
void* control_thread(void *thid_arr);
int cpu_bind(const unsigned short cpu); 
void sem_cleanup_and_exit(int signo);

void sem_cleanup_and_exit(int signo)
{
	semctl(semid, 0, IPC_RMID);
	exit(0);
}

int cpu_bind(const unsigned short cpu) 
{ 
	cpu_set_t mask; 
	int ret; 

	CPU_ZERO(&mask); 
	CPU_SET((int)cpu, &mask); 
	ret = sched_setaffinity(0, sizeof mask, &mask); 

	return ret; 
} 

void mysignalhandler1(int n, siginfo_t* info, void* k)
{
	sigset_t *set;
	int signalid;
	union sigval data = info->si_value;
	set = (sigset_t *)data.sival_ptr;

	//pthread_sigmask(sig_block, null, &set); 

	signalid = sigwaitinfo(set, NULL);
	printf("signal recieved in handler1:%d\n", signalid);

}
void* listen_thread(void *thid)
{
	int err, fifo_d_0, fifo_d_1, fifo_d_2, signum;
	process_credit_data pcd;

	err = mkfifo(FIFO_PATH_0, 0666);
	if(err != 0 && errno == EEXIST) 
	{
		printf("File exists\n") ;
	}
	while(1)
	{
		fifo_d_0 = open(FIFO_PATH_0, O_RDONLY) ; 
		read(fifo_d_0, &pcd, sizeof(process_credit_data)); 
		if(pcd.action == ADD_Q)
		{
			printf("ADD_Q pid: %d, share_unit: %lu\n", pcd.pid, pcd.share_unit) ;

			signum = SIGRTMIN + Scheduler_Data.RT_signal_indx++;
			fifo_d_1 = open(FIFO_PATH_1, O_WRONLY) ;
			write(fifo_d_1, &signum, sizeof(int)) ;

			read(fifo_d_0, &err, sizeof(int));
			printf("err:%d\n", err);
			sleep(5);
			if(!err)
			{
				union sigval data;
				//sleep the thread before adding it
				data.sival_int = signum;
				sigqueue(pcd.pid, signum, data);
				register_process(pcd.pid, signum, pcd.share_unit);
			}
		}
		else
		{
			printf("REM_Q pid: %d\n", pcd.pid);
			int i;
			for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
			{
				if(pcd.pid == Scheduler_Data.process_list[i])
				{
					Scheduler_Data.process_list[i] = INVALID_PROCEESS;
					break;
				}
			}
		}
	}
	return NULL;
}

void* control_thread(void *thid_arr)
{
	int thid = 0, i;
	union sigval data;
	sigset_t set, set1, set2;
	struct timeval tp;

	sigemptyset(&set);
	for(i = SIGRTMIN; i <= SIGRTMAX; i++)
		sigaddset(&set, SIGRTMIN);

	pthread_sigmask(SIG_BLOCK, &set, NULL);
	printf("Inside control thread\n");
	sleep(10);
	//cpu_bind(0);	

	while(1)
	{
		if(!Scheduler_Data.polling_thread_count)
			continue;

		pid_t process_id = Scheduler_Data.process_list[thid];
		unsigned long share_unit = Scheduler_Data.share_unit[thid];
		int signum = Scheduler_Data.signal_num[thid];

		sigset_t polling_thread_set;
		sigemptyset(&polling_thread_set);
		sigaddset(&polling_thread_set, signum);

		if(process_id != INVALID_PROCEESS)
		{
			gettimeofday(&tp, NULL); 
			fprintf(stderr, "control thread starting process id: %d, signum: %d, share_unit:%lu time:%d sec %d usec\n", process_id, signum, share_unit, tp.tv_sec, tp.tv_usec);
	 
			//data.sival_ptr = (void *)(&polling_thread_set);
			data.sival_int = signum;
			sigqueue(process_id, signum, data);
		}
		thid++;
		if(thid > Scheduler_Data.polling_thread_count-1)
			thid = 0;

		if(process_id != INVALID_PROCEESS)
		{
			sleep(share_unit/10);
			//data.sival_ptr = (void *)(&polling_thread_set);
			gettimeofday(&tp, NULL); 
			fprintf(stderr, "control thread sleeping process id: %d, signum: %d, share_unit:%lu time:%d sec %d usec\n", process_id, signum, share_unit, tp.tv_sec, tp.tv_usec);
	 
			data.sival_int = signum;
			sigqueue(process_id, signum, data);   
		}
	}
	return NULL;
}

void register_process(pid_t process_id, int signum, unsigned long share_unit)
{
	Scheduler_Data.process_list[Scheduler_Data.polling_thread_count] = process_id;
	Scheduler_Data.share_unit[Scheduler_Data.polling_thread_count] = share_unit;
	Scheduler_Data.signal_num[Scheduler_Data.polling_thread_count] = signum;
	Scheduler_Data.polling_thread_count++;
}

int add_queue(pid_t process_id, /*int unsigned GPU_id,*/ unsigned long share_unit)
{
	sigset_t set;

	sigemptyset(&set);
	sigaddset(&set, SIGRTMIN + Scheduler_Data.polling_thread_count);

	//pthread_sigmask(sig_unblock, &set, null); 
	sigprocmask(SIG_UNBLOCK, &set, NULL);

	struct sigaction act;
	act.sa_sigaction = &mysignalhandler1;
	act.sa_flags = SA_SIGINFO;

	if(sigaction(SIGRTMIN + Scheduler_Data.polling_thread_count, &act, NULL) < 0)
	{
		printf("handler registration failed\n");
		return -1;
	}
	register_process(process_id, SIGRTMIN + Scheduler_Data.polling_thread_count, share_unit);
}

int main()
{
	pthread_t thID1, thID2;
	int n = 0, i;
	sigset_t set, set1, set2;
	union sigval data;

	sigemptyset(&set);
	for(i = SIGRTMIN; i <= SIGRTMAX; i++)
		sigaddset(&set, SIGRTMIN);

	sigprocmask(SIG_BLOCK, &set, NULL);

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
