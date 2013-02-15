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
		Scheduler_Data.valid[i] = 0;

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
				fs_register_process(pcd.pid, signum, pcd.app_type, pcd.gpuid);
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
					pthread_mutex_lock(&mut);
					tmp.tv_sec = Scheduler_Data.execution_time[i].tv_sec;
					tmp.tv_usec = Scheduler_Data.execution_time[i].tv_usec;
					timeradd(&tmp,&pcd.execution_time,&Scheduler_Data.execution_time[i]);
					pthread_mutex_unlock(&mut);
					// XXX - TFS cmnt start
/*					unsigned long actual_ms = (pcd.execution_time.tv_sec) * 1000 + 
									((pcd.execution_time.tv_usec + 500) / 1000);
					unsigned long devoted_ms = Scheduler_Data.share_unit[i];
					pthread_mutex_lock(&mut);
					if(devoted_ms == 0)
						Scheduler_Data.penalty_epochs[i] = 0;
					else
						Scheduler_Data.penalty_epochs[i] =  actual_ms / devoted_ms;
					pthread_mutex_unlock(&mut);*/
					// XXX - TFS cmnt end
					break;
				}
			}
		}
/*		else if(pcd.action == GET_SIGNUM)
		{
			int signo = -1;
			strcpy(target,CLIENT_READ_PATH);
			sprintf(src,"%ld",pcd.pid);
			strcat(target,src);
			fprintf(stderr,"Writing signal at %s\n",target);

			int i;
			for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
			{
				if(Scheduler_Data.process_list[i] == pcd.pid)
				{
					signo = Scheduler_Data.signal_num[i];
					break;
				}
			}

			mkfifo(target,0666);
			client_resp_fifo = open(target, O_WRONLY);
			write(client_resp_fifo, &signo, sizeof(int)) ;
			close(client_resp_fifo);
		}*/
		else
		{
			printf("CFSCHED Illegal pcd read from pipe\n");
		}
	}
	return NULL;
}

void fs_calculate_timeslice(int gpuid)
{
	unsigned long actual_ms, devoted_ms;
	int i, app_a_count = 0, app_b_count = 0;
	for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
	{
		if(Scheduler_Data.gpu_binding[i] == gpuid)
		{
			devoted_ms = Scheduler_Data.share_unit[i];
			pthread_mutex_lock(&mut);
			actual_ms = (Scheduler_Data.execution_time[i].tv_sec) * 1000 + 
					((Scheduler_Data.execution_time[i].tv_usec + 500) / 1000);
			timerclear(&Scheduler_Data.execution_time[i]);
			pthread_mutex_unlock(&mut);
			// XXX - TFS cmnt start
/*			if(devoted_ms != 0 && Scheduler_Data.penalty_epochs[i] == 0)
				Scheduler_Data.penalty_epochs[i] = actual_ms / devoted_ms;*/
			// XXX - TFS cmnt end
			break;
		}
	}

	for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
	{
		// XXX - TFS cmnt toggle start
/*		int condition = (Scheduler_Data.valid[i]) && (Scheduler_Data.gpu_binding[i] == gpuid) 
					&& (Scheduler_Data.penalty_epochs[i] == 0);*/
		// XXX - TFS cmnt toggle end
		int condition = Scheduler_Data.valid[i];
		if(condition && Scheduler_Data.app_type[i] == APP_TYPE_A)
			app_a_count++;
		else if(condition && Scheduler_Data.app_type[i] == APP_TYPE_B)
			app_b_count++;
	}
	float base_share = (float) EPOCH_LENGTH / (APP_TYPE_A_SHARE + APP_TYPE_B_SHARE);
	unsigned long app_a_share, app_b_share;

	if(app_a_count == 0  && app_b_count == 0)
	{
		app_a_share = 0;
		app_b_share = 0;
	}
	else if(app_a_count == 0 && app_b_count != 0)
	{
		base_share = (float) EPOCH_LENGTH / (APP_TYPE_B_SHARE);
		app_a_share = 0;
		app_b_share = (float) EPOCH_LENGTH / (float) app_b_count;
	}
	else if(app_a_count != 0 && app_b_count == 0)
	{	
		base_share = (float) EPOCH_LENGTH / (APP_TYPE_A_SHARE);
		app_b_share = 0;
		app_a_share = (float) EPOCH_LENGTH / (float) app_a_count;
	}
	else
	{
		app_a_share = (base_share * APP_TYPE_A_SHARE) / (float) app_a_count;
		app_b_share = (base_share * APP_TYPE_B_SHARE) / (float) app_b_count;
	}
	
	fprintf(stderr,"CFSCHED GPU %d : a_count: %d, b_count: %d, a_share: %llu, b_share: %llu\n",
			gpuid,app_a_count,app_b_count,app_a_share,app_b_share);

	for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
	{
		if(Scheduler_Data.app_type[i] == APP_TYPE_A && (Scheduler_Data.gpu_binding[i] == gpuid))
			Scheduler_Data.share_unit[i] = app_a_share;
		else if(Scheduler_Data.app_type[i] == APP_TYPE_B && (Scheduler_Data.gpu_binding[i] == gpuid))
			Scheduler_Data.share_unit[i] = app_b_share;
	}
}

void* fs_control_thread(void *attr)
{
	unsigned thid = 0, prev, i;
	union sigval data;
	sigset_t set, set1, set2;
	struct timeval tp;
	unsigned long share_unit;
	int * bound_to_gpu = (int *)attr;

	sigemptyset(&set);
	for(i = SIGRTMIN; i <= SIGRTMAX; i++)
		sigaddset(&set, SIGRTMIN);

	pthread_sigmask(SIG_BLOCK, &set, NULL);
	printf("CFSCHED Inside control thread\n");
	sleep(10);
	struct timespec sl;
	sl.tv_sec = 0;
	sl.tv_nsec = 100;
	//cpu_bind(0);

	while(1)
	{
	//	nanosleep(&sl,NULL);
		if(!Scheduler_Data.polling_thread_count)
			continue;

		if((Scheduler_Data.valid[thid] == 0) || Scheduler_Data.gpu_binding[thid] != (*bound_to_gpu))
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
		share_unit = Scheduler_Data.share_unit[thid];
		int signum = Scheduler_Data.signal_num[thid];

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

		
		gettimeofday(&tp, NULL); 
		fprintf(stderr, "CFSCHED control thread starting process id: %d, signum: %d, share_unit:%lu time:%d sec %d usec\n", process_id, signum, share_unit, tp.tv_sec, tp.tv_usec);
 
		//data.sival_ptr = (void *)(&polling_thread_set);
		data.sival_int = signum;
		sigqueue(process_id, signum, data);
	

	
		struct timespec ts;
		ts.tv_sec = 0;
		ts.tv_nsec = share_unit * 1000000; // sleep for share_unit milliseconds
		nanosleep(&ts,NULL);
		//data.sival_ptr = (void *)(&polling_thread_set);
		gettimeofday(&tp, NULL); 
		fprintf(stderr, "CFSCHED control thread sleeping process id: %d, signum: %d, share_unit:%lu time:%d sec %d usec\n", process_id, signum, share_unit, tp.tv_sec, tp.tv_usec);
 
		data.sival_int = signum;
		sigqueue(process_id, signum, data);   

		prev = thid;
		thid = (thid + 1) % MAX_CONTROLLER_COUNT;
		if(thid < prev)
			fs_calculate_timeslice(*bound_to_gpu);
		
	}
	return NULL;
}

void fs_register_process(pid_t process_id, int signum, int app_type, int gpuid)
{
	printf("CFSCHED process %d registered with scheduler, signum : %d, app_type %d\n",process_id, signum, app_type);
	Scheduler_Data.process_list[Scheduler_Data.polling_thread_count] = process_id;
	//Scheduler_Data.share_unit[Scheduler_Data.polling_thread_count] = share_unit;	/* deprecated : we need to calculate this */
	/* initially, set the share unit as zero. At the end of each epoch, recalculate everything */
	Scheduler_Data.share_unit[Scheduler_Data.polling_thread_count] = 0;
	Scheduler_Data.signal_num[Scheduler_Data.polling_thread_count] = signum;
	Scheduler_Data.valid[Scheduler_Data.polling_thread_count] = 1;
	Scheduler_Data.app_type[Scheduler_Data.polling_thread_count] = app_type;
	Scheduler_Data.penalty_epochs[Scheduler_Data.polling_thread_count] = 0;
	Scheduler_Data.gpu_binding[Scheduler_Data.polling_thread_count] = gpuid;
	Scheduler_Data.polling_thread_count = (Scheduler_Data.polling_thread_count + 1) % MAX_CONTROLLER_COUNT;
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


int fs_start_scheduler()
{
	signal_block_all();
	pthread_t thIDs[10];		/* This array size must be >= 2 * num_gpus */
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

	int * gpuid = NULL,j = 0;
	
	for(i = 0 ; i < thread_count; i += 2)
	{
		gpuid = (int *) malloc(sizeof(int));
		*gpuid = j++;
		pthread_create(&thIDs[i], NULL, fs_listen_thread, gpuid);
		pthread_create(&thIDs[i+1], NULL, fs_control_thread, gpuid);
		fprintf(stderr,"In main :: listener ID : %llu, controller ID : %llu\n",thIDs[i],thIDs[i+1]);
	}
	
	for(i = 0 ; i < thread_count ; i++)
		pthread_join(thIDs[i], NULL);

	return 0;
}


