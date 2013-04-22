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
#include "fair_share_sched.h"
#include <unistd.h>


//scheduler_data Scheduler_Data;
int semid;
FILE *map_file;

void sem_cleanup_and_exit(int signo)
{
	printf("CFSCHED Removing semaphore and exiting\n");

	char cmd[150];
	strcpy(cmd,"rm -f ");
	strcat(cmd,LISTEN_PATH);
	strcat(cmd,"*");

	system(cmd);
	system("rm -f /tmp/gpu-dipanjan/GPU_CWRITE*");
	system("rm -f /tmp/gpu-dipanjan/GPU_CREAD*");
	unlink(SCHED_DEF_FILE_PATH);
	semctl(semid, 0, IPC_RMID);
	exit(0);
}

void redirection_handler(int n, siginfo_t* info, void* k)
{
	int gpuid;
	union sigval data = info->si_value;
	gpuid = data.sival_int;
	int idx = (2 * gpuid) + 1;
	pthread_sigqueue(&thIDs[idx],SIGRTMIN,data);
}

void redirection_handler2(int n, siginfo_t* info, void* k)
{
	int gpuid;
	union sigval data = info->si_value;
	gpuid = data.sival_int;
	int idx = (2 * gpuid) + 1;
	pthread_sigqueue(&thIDs[idx],(SIGRTMAX - 2),data);
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

void fs_write_mappings(int gpuid, pthread_t tid)
{
	char threadid[20],buffer[100];
	sprintf(threadid,"%llu",tid);
	sprintf(buffer,"%d\t%s\n",gpuid,threadid);
	pthread_mutex_lock(&map_mut);
	map_file = fopen(SCHED_DEF_FILE_PATH,"a");
	fwrite(buffer,strlen(buffer),1,map_file);
	fclose(map_file);
	pthread_mutex_unlock(&map_mut);
}

void* fs_listen_thread(void *thid)
{
	int err, listen_fifo, client_resp_fifo, client_req_fifo, signum;
	process_credit_data pcd;
	pthread_t selfid = pthread_self();
	
	/* open the FIFO to listen */
	printf("CFSCHED starting listener\n");
	char listen_at[100],myid[50];
	sprintf(myid,"%llu",selfid);
	strcpy(listen_at,LISTEN_PATH);
	strcat(listen_at,myid);
	

	err = mkfifo(listen_at, 0666);
	if(err != 0 && errno == EEXIST) 
	{
		printf("CFSCHED named pipe 0 exists\n") ;
	}	

	/* write the mappings in the file */
	int *gpuid = (int *)thid;
	fs_write_mappings(*gpuid, selfid);
	int i;
	for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
		Scheduler_Data.state[i] = PROC_INACTIVE;;

	listen_fifo = open(listen_at, O_RDWR); 
	int status;
	char target[100],src[50];
	struct timespec sl;
	sl.tv_nsec = 1000;
	sl.tv_sec = 0;
	while(1)
	{
		nanosleep(&sl, NULL);
		status = read(listen_fifo, &pcd, sizeof(process_credit_data));
		printf("CFSCHED read status : %d, tid = %lld \n",status,pthread_self());
		if((status > 0) && (pcd.action == ADD_Q) && !already_added(pcd))
		{
			printf("CFSCHED ADD_Q pid: %d, share_unit: %lu\n", pcd.pid, pcd.share_unit) ;

//			signum = SIGRTMIN + Scheduler_Data.RT_signal_indx++;
			signum = SIGSCHED;

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
				// Sleep the backend process before registering
				union sigval data;
				data.sival_int = signum;
				sigqueue(pcd.pid, SIGALRM, data);
				fs_register_process(pcd.pid, signum, pcd.app_type, pcd.gpuid, pcd.share_unit);
			}
		}
		else if((status > 0) && (pcd.action == REM_Q))
		{
			printf("CFSCHED REM_Q pid: %d\n", pcd.pid);
			int i;
			for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
			{
				if((pcd.pid == Scheduler_Data.process_list[i]) && (*gpuid == Scheduler_Data.gpu_binding[i]))
				{
					Scheduler_Data.process_list[i] = INVALID_PROCEESS;
					Scheduler_Data.state[i] = PROC_INACTIVE;
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

void fs_register_process(pid_t process_id, int signum, int app_type, int gpuid, int share_unit)
{
	printf("CFSCHED process %d registered with scheduler, signum : %d, app_type %d\n",process_id, signum, app_type);
	Scheduler_Data.process_list[Scheduler_Data.polling_thread_count] = process_id;
	Scheduler_Data.share_unit[Scheduler_Data.polling_thread_count] = share_unit;	
	Scheduler_Data.signal_num[Scheduler_Data.polling_thread_count] = signum;
	Scheduler_Data.state[Scheduler_Data.polling_thread_count] = PROC_ACTIVE;
	Scheduler_Data.app_type[Scheduler_Data.polling_thread_count] = app_type;	/* deprecated: ratio is present in share_unit */
	Scheduler_Data.penalty_epochs[Scheduler_Data.polling_thread_count] = 0;
	Scheduler_Data.gpu_binding[Scheduler_Data.polling_thread_count] = gpuid;
	Scheduler_Data.polling_thread_count = (Scheduler_Data.polling_thread_count + 1) % MAX_CONTROLLER_COUNT;
}


void* fs_control_thread(void *attr)
{
	unsigned thid = 0, prev, i;
	union sigval data;
	sigset_t set, set1, set2;
	struct timeval tp, tp1, tv_alloc;
	unsigned long share_unit;
	int * bound_to_gpu = (int *)attr;
	sigemptyset(&set);
	sigaddset(&set, SIGRTMIN);
	sigaddset(&set, (SIGRTMAX - 2));
	sigprocmask(SIG_BLOCK, &set);

	printf("CFSCHED Inside control thread\n");
	sleep(5);
	struct timespec sl;
	sl.tv_sec = 0;
	sl.tv_nsec = 100;
	//cpu_bind(0);
	
	while(1)
	{
	//	nanosleep(&sl,NULL);
		if(!Scheduler_Data.polling_thread_count)
			continue;

		if((Scheduler_Data.state[thid] != PROC_ACTIVE) || Scheduler_Data.gpu_binding[thid] != (*bound_to_gpu))
		{
			prev = thid;
			thid = (thid + 1) % MAX_CONTROLLER_COUNT;
			if(thid < prev)
				fs_calculate_timeslice(*bound_to_gpu);
			continue;
		}
		
		int penalty = Scheduler_Data.penalty_epochs[thid];
		if(penalty > 0)
		{
			fprintf(stderr,"CFSCHED GPU %d : penalty of %d epochs for pid %lld\n",
				*bound_to_gpu,Scheduler_Data.penalty_epochs[thid],Scheduler_Data.process_list[thid]);
			Scheduler_Data.penalty_epochs[thid]--;
			prev = thid;
			thid = (thid + 1) % MAX_CONTROLLER_COUNT;
			if(thid < prev)
				fs_calculate_timeslice(*bound_to_gpu);
			continue;
		}

		pid_t process_id = Scheduler_Data.process_list[thid];
		tv_alloc = Scheduler_Data.allocated_time[thid];
		int signum = SIGSCHED;

		if(share_unit == 0)
		{
			prev = thid;
			thid = (thid + 1) % MAX_CONTROLLER_COUNT;
			if(thid < prev)
				fs_calculate_timeslice(*bound_to_gpu);
			continue;
		}


		sigset_t polling_thread_set;
		sigemptyset(&polling_thread_set);
		sigaddset(&polling_thread_set, signum);

		
 
		//data.sival_ptr = (void *)(&polling_thread_set);
		data.sival_ptr = (void *) &tv_alloc;

		gettimeofday(&tp, NULL);
		fprintf(stderr, "CFSCHED control thread starting process id: %d, signum: %d, share_unit:%lu time:%d sec %d usec\n", process_id, signum, share_unit, tp.tv_sec, tp.tv_usec);

		pthread_mutex_lock(&sched_index_mut);
		if(Scheduler_Data[thid].state == PROC_ACTIVE)
		{
			sigqueue(process_id, signum, data);
			// TODO : Should process mask of SIGRTMIN be removed before waiting for it ?
			int sig = sigwaitinfo(&set, NULL);
			if(sig == (SIGRTMAX - 2))
			{
				/* The process has now initiated paging mechanism, we should no longer schedule it */
				Scheduler_Data.state[i] = PROC_PAGING;
			}
		}
		pthread_mutex_lock(&sched_index_mut);

		gettimeofday(&tp1, NULL); 
		fprintf(stderr, "CFSCHED control thread rcvd end of interval process id: %d, signum: %d, share_unit:%lu time:%d sec %d usec\n", process_id, signum, share_unit, tp1.tv_sec, tp1.tv_usec);
		timersub(&tp1, &tp, &Scheduler_Data.execution_time[thid]);

		prev = thid;
		thid = (thid + 1) % MAX_CONTROLLER_COUNT;
		if(thid < prev)
			fs_calculate_timeslice(*bound_to_gpu);
		
	}
	return NULL;
}

void fs_calculate_timeslice(int gpuid)
{
	int i, active_count = 0, total_shares = 0;
	unsigned long actual_ms, devoted_ms;

	pthread_mutex_lock(&sched_index_mut);

	for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
	{	

		if((Scheduler_Data.gpu_binding[i] == gpuid) && (Scheduler_Data.state[i] == PROC_ACTIVE) 
			&& (Scheduler_Data.penalty_epochs[i] == -1))
		{
			devoted_ms = (Scheduler_Data.allocated_time[i].tv_sec) * 1000 + 
					((Scheduler_Data.allocated_time[i].tv_usec + 500) / 1000);

			actual_ms = (Scheduler_Data.execution_time[i].tv_sec) * 1000 + 
					((Scheduler_Data.execution_time[i].tv_usec + 500) / 1000);

			if(devoted_ms != 0)
				Scheduler_Data.penalty_epochs[i] = actual_ms / devoted_ms;
		}

		if((Scheduler_Data.gpu_binding[i] == gpuid) && (Scheduler_Data.state[i] == PROC_WAITING) 
			&& (Scheduler_Data.penalty_epochs[i] == -1))
		{
			Scheduler_Data.state[i] = PROC_ACTIVE;
		}

		if((Scheduler_Data.gpu_binding[i] == gpuid) && (Scheduler_Data.state[i] == PROC_ACTIVE) 
			&& (Scheduler_Data.penalty_epochs[i] == 0))
		{
			Scheduler_Data.penalty_epochs[i] = -1;
		}

		if((Scheduler_Data.gpu_binding[i] == gpuid) && (Scheduler_Data.state[i] == PROC_ACTIVE)) 
		{
			active_count++;
			total_shares += Scheduler_Data.share_unit[i];
		}
	}

	if(active_count == 0 || total_shares == 0)
	{
		pthread_mutex_unlock(&sched_index_mut);
		return;
	}

	float base_share = (float) EPOCH_LENGTH / (float) active_count;
	for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
	{
		if((Scheduler_Data.gpu_binding[i] == gpuid) && (Scheduler_Data.state[i] == PROC_ACTIVE)) 
		{
			unsigned float base_share = (float) EPOCH_LENGTH / (float) total_shares;
			Scheduler_Data.allocated_time[i].tv_sec = 0;
			Scheduler_Data.allocated_time[i].tv_usec = base_share * 1000;
		}
	}

	pthread_mutex_unlock(&sched_index_mut);
}


void signal_block_all()
{
  int i;
  sigset_t set;
  union sigval data;
  
  sigemptyset(&set);
  for(i = SIGRTMIN + 1; i <= SIGRTMAX - 1; i++)
    sigaddset(&set, i);
 
  sigprocmask(SIG_BLOCK, &set, NULL);
}


int fs_start_scheduler()
{
	signal_block_all();
	int num_gpus = 2;
	int thread_count = 2 * num_gpus;
	int n = 0, i;
	sigset_t set, set1, set2;
	union sigval data;

	FILE *fp = fopen(SCHED_PID_FILE_PATH,"w");
	fprintf(fp, "%ld", getpid());
	fclose(fp);

	if((semid = semget(ftok(SEMKEYPATH, SEMKEYID), 1, 0666 | IPC_CREAT | IPC_EXCL )) == -1){
		perror("semget failed");
		return -1;
	}

	semctl(semid, 0, SETVAL, 1) ;

	struct sigaction act;
	act.sa_handler = &sem_cleanup_and_exit;
	sigemptyset(&act.sa_mask);
	act.sa_flags = 0;

	if(sigaction(SIGINT, &act, NULL) < 0)
	{
		printf("SIGINT handler registration failed. semaphores may not be cleared.\n");
		return -1;
	}

	act.sa_handler = &redirection_handler;
	sigaddset(&act.sa_mask,SIGRTMIN);
	act.sa_flags = SA_SIGINFO;
	sigaction(SIGRTMAX, &act, NULL);

	act.sa_handler = &redirection_handler2;
	sigaction(SIGPAGE, &act, NULL);

	 for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
		 Scheduler_Data.state[i] = PROC_INACTIVE;

	int * gpuid = NULL,j = 0;
	
	for(i = 0 ; i < thread_count; i += 2)
	{
		gpuid = (int *) malloc(sizeof(int));
		*gpuid = j++;
		pthread_create(&thIDs[i], NULL, fs_listen_thread, gpuid);
		pthread_create(&thIDs[i+1], NULL, fs_control_thread, gpuid);
		fprintf(stderr,"In main :: listener ID : %llu, controller ID : %llu\n",thIDs[i],thIDs[i+1]);
	}
	
/*	for(i = 0 ; i < thread_count ; i++)
		pthread_join(thIDs[i], NULL);*/

	return thread_count;
}


