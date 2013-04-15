#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <string.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <time.h>
#include <sched.h>
#include "las_scheduler.h"
#include <unistd.h>


//scheduler_data Scheduler_Data;

void las_sem_cleanup_and_exit(int signo)
{
	printf("LASSCHED Removing semaphore and exiting\n");

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

int las_already_added(process_credit_data pcd)
{
	int i;
	for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
	{
		if(Scheduler_Data.process_list[i] == pcd.pid)
			return 1;
	}
	return 0;
}

void las_write_mappings(int gpuid, pthread_t tid)
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

void* las_listen_thread(void *thid)
{
	int k;
	#ifdef L2_FEEDBACK_ENABLED
	int app_a_marked = 0, app_b_marked = 0;
	#endif
	int err, listen_fifo, client_resp_fifo, client_req_fifo, signum;
	process_credit_data pcd;
	pthread_t selfid = pthread_self();
	
	/* open the FIFO to listen */
	printf("LASSCHED starting listener\n");
	char listen_at[100],myid[50];
	sprintf(myid,"%llu",selfid);
	strcpy(listen_at,LISTEN_PATH);
	strcat(listen_at,myid);
	

	err = mkfifo(listen_at, 0666);
	if(err != 0 && errno == EEXIST) 
	{
		printf("LASSCHED named pipe 0 exists\n") ;
	}	

	/* write the mappings in the file */
	int *gpuid = (int *)thid;
	las_write_mappings(*gpuid, selfid);
	int i;
	for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
		Scheduler_Data.valid[i] = 0;

	listen_fifo = open(listen_at, O_RDWR); 
	int status, to_mark;
	char target[100],src[50];
	struct timespec sl;
	sl.tv_nsec = 1000;
	sl.tv_sec = 0;
	int index;
	while(1)
	{
		nanosleep(&sl, NULL);
		status = read(listen_fifo, &pcd, sizeof(process_credit_data));
//		printf("LASCHED read status : %d, tid = %lld \n",status,pthread_self());
		if((status > 0) && (pcd.action == ADD_Q) && !las_already_added(pcd))
		{
			printf("LASSCHED ADD_Q pid: %d, gpu: %d\n", pcd.pid, pcd.gpuid) ;
			
			to_mark = 0;
			#ifdef L2_FEEDBACK_ENABLED
			if(app_a_marked == 0 && pcd.app_type == APP_TYPE_A)
			{
				app_a_marked = 1;
				to_mark = 1;
			}
			if(app_b_marked == 0 && pcd.app_type == APP_TYPE_B)
			{
				app_b_marked = 1;
				to_mark = 1;
			}
			#endif

			index = las_register_process(pcd.pid, pcd.gpuid, pcd.app_type, to_mark );
			printf("L2FB process registered. pid = %d, gpuid = %d, app_id = %d, sends_feedback = %d, index = %d\n", pcd.pid, pcd.gpuid, pcd.app_type, to_mark,index);

			strcpy(target,CLIENT_READ_PATH);
			sprintf(src,"%ld",pcd.pid);
			strcat(target,src);

			mkfifo(target,0666);
			client_resp_fifo = open(target, O_WRONLY);
			write(client_resp_fifo, &index, sizeof(int)) ;
			close(client_resp_fifo);
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
		else if((status > 0) && (pcd.action == NOTIFY_SCHED))
		{
			/* find the record for particular pid */
			int i;
			for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
			{
				if((Scheduler_Data.process_list[i] == pcd.pid) && (*gpuid == Scheduler_Data.gpu_binding[i]))
				{
					struct timeval tmp;
					pthread_rwlock_wrlock(&las_lock);
					tmp.tv_sec = Scheduler_Data.execution_time[i].tv_sec;
					tmp.tv_usec = Scheduler_Data.execution_time[i].tv_usec;
					timeradd(&tmp,&pcd.execution_time,&Scheduler_Data.execution_time[i]);
					pthread_rwlock_unlock(&las_lock);
					break;
				}
			}
		}
		else if((status > 0) && (pcd.action == GET_PRIORITY))
		{
			int idx = pcd.gpuid;
			strcpy(target,CLIENT_READ_PATH);
			sprintf(src,"%ld",pcd.pid);
			strcat(target,src);

			mkfifo(target,0666);
			client_resp_fifo = open(target, O_WRONLY);
			int p = Scheduler_Data.priority[idx];
			write(client_resp_fifo, &p, sizeof(int)) ;
			close(client_resp_fifo);

		}
		else if((status > 0) && (pcd.action == GET_L2_DATA))
		{
			int idx = pcd.gpuid;
			pcd.app_type = Scheduler_Data.app_type[idx];
			pcd.execution_time = Scheduler_Data.execution_time[idx];
			pcd.action = Scheduler_Data.sends_l2_feedback[idx];
			strcpy(target,CLIENT_READ_PATH);
			sprintf(src,"%ld",pcd.pid);
			strcat(target,src);

			mkfifo(target,0666);
			client_resp_fifo = open(target, O_WRONLY);
			write(client_resp_fifo, &pcd, sizeof(process_credit_data)) ;
			close(client_resp_fifo);

		}
		else
		{
			printf("CFSCHED Illegal pcd read from pipe\n");
		}
	}
	return NULL;
}

void* las_control_thread(void *attr)
{
	unsigned thid = 0, prev, i;
	sigset_t set;
	int * bound_to_gpu = (int *)attr;

	sigemptyset(&set);
	for(i = SIGRTMIN; i <= SIGRTMAX; i++)
		sigaddset(&set, SIGRTMIN);

	pthread_sigmask(SIG_BLOCK, &set, NULL);
	printf("LASSCHED Inside control thread\n");
	struct timespec sl;
	sl.tv_sec = 0;
	sl.tv_nsec = EPOCH_LENGTH * 1000;
	//cpu_bind(0);
	struct timeval minval;

	int normal_prio = PRIORITY_NORMAL;
	int high_prio = PRIORITY_HIGH;

	while(1)
	{
		nanosleep(&sl,NULL);
		if(!Scheduler_Data.polling_thread_count)
			continue;

		minval = Scheduler_Data.execution_time[0];
		pthread_rwlock_wrlock(&las_lock);
		for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
		{
			if((Scheduler_Data.gpu_binding[i] == *bound_to_gpu) && (Scheduler_Data.valid[i]))
			{
				if(timercmp(&Scheduler_Data.execution_time[i],&minval,<))
				{
					minval.tv_sec = Scheduler_Data.execution_time[i].tv_sec;
					minval.tv_usec = Scheduler_Data.execution_time[i].tv_usec;
				}
			}
		}
		for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
		{
			if((Scheduler_Data.gpu_binding[i] == *bound_to_gpu) && Scheduler_Data.valid[i])
			{
				if(timercmp(&Scheduler_Data.execution_time[i],&minval,!=))
					Scheduler_Data.priority[i] = normal_prio;
				else
					Scheduler_Data.priority[i] = high_prio;
			}
		}
		pthread_rwlock_unlock(&las_lock);
	}
	return NULL;
}

int las_register_process(pid_t process_id, int gpuid, int app_type, int to_mark)
{
	printf("LASSCHED process %ld registered with scheduler, gpuid : %d\n",process_id,gpuid);
	Scheduler_Data.process_list[Scheduler_Data.polling_thread_count] = process_id;
	Scheduler_Data.valid[Scheduler_Data.polling_thread_count] = 1;
	Scheduler_Data.gpu_binding[Scheduler_Data.polling_thread_count] = gpuid;
	Scheduler_Data.priority[Scheduler_Data.polling_thread_count] = 0;
	if(to_mark)
		Scheduler_Data.sends_l2_feedback[Scheduler_Data.polling_thread_count] = 1;
	else
		Scheduler_Data.sends_l2_feedback[Scheduler_Data.polling_thread_count] = 0;
	int idx = Scheduler_Data.polling_thread_count;
	Scheduler_Data.polling_thread_count = (Scheduler_Data.polling_thread_count + 1) % MAX_CONTROLLER_COUNT;
	return idx;
}

int las_start_scheduler()
{
	int num_gpus = 2;
	int thread_count = 2 * num_gpus;
	int n = 0, i;
	sigset_t set, set1, set2;
	union sigval data;

	if((semid = semget(ftok(SEMKEYPATH, SEMKEYID), 1, 0666 | IPC_CREAT | IPC_EXCL )) == -1){
		perror("semget failed");
		return -1;
	}

	semctl(semid, 0, SETVAL, 1) ;

	struct sigaction act;
	act.sa_handler = &las_sem_cleanup_and_exit;
	sigemptyset(&act.sa_mask);
	for(i = SIGRTMIN; i <= SIGRTMAX; i++)
		sigaddset(&act.sa_mask, SIGRTMIN);
	act.sa_flags = 0;

	if(sigaction(SIGINT, &act, NULL) < 0)
	{
		printf("SIGINT handler registration failed. semaphores may not be cleared.\n");
		return -1;
	}

	int * gpuid = NULL,j = 0;
	
	for(i = 0 ; i < thread_count; i += 2)
	{
		gpuid = (int *) malloc(sizeof(int));
		*gpuid = j++;
		pthread_create(&thIDs[i], NULL, las_listen_thread, gpuid);
		pthread_create(&thIDs[i+1], NULL, las_control_thread, gpuid);
		fprintf(stderr,"In main :: listener ID : %llu, controller ID : %llu\n",thIDs[i],thIDs[i+1]);
	}
	
/*	for(i = 0 ; i < thread_count ; i++)
		pthread_join(thIDs[i], NULL);*/

	return thread_count;
}


