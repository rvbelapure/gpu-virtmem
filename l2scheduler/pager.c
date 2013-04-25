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
#include <unistd.h>
#include "pager.h"
#include <sys/shm.h>

struct mem_map * gmt_table;
int * gmt_index;

struct pager_data PagerData[MAX_MEMORY];
int pindex;

void start_pager()
{
	sigset_t set, set1, set2;
	union sigval data;

	if((gmt_semid = semget(ftok(SEMKEYPATH, GMT_KEYID), 1, 0666 | IPC_CREAT | IPC_EXCL )) == -1){
		perror("semget failed");
		return;
	}

	semctl(gmt_semid, 0, SETVAL, 1) ;

	int shmid = shmget(ftok(SEMKEYPATH, GMT_SHM_KEY), MAX_MEMORY * sizeof(struct mem_map), 0666 | IPC_CREAT | IPC_EXCL);
	if(shmid == -1)
	{
		perror("shemget failed\n");
		return;

	}
	int shmindex = shmget(ftok(SEMKEYPATH, GMT_SHM_INDEX_KEY), sizeof(int), 0666 | IPC_CREAT | IPC_EXCL);
	if(shmindex == -1)
	{
		perror("shemget failed\n");
		return;
	}


	gmt_table = (struct mem_map *) shmat(shmid, NULL, SHM_R | SHM_W);
	gmt_index = (int *) shmat(shmindex, NULL, SHM_R | SHM_W);

	mem_map_init(&gmt_table);
	*gmt_index = 0;
	pindex = 0;
	
	// TODO : Add cleanup later
/*	struct sigaction act;
	act.sa_handler = &pager_sem_cleanup_and_exit;
	sigemptyset(&act.sa_mask);
	for(i = SIGRTMIN; i <= SIGRTMAX; i++)
		sigaddset(&act.sa_mask, SIGRTMIN);
	act.sa_flags = 0;

	if(sigaction(SIGINT, &act, NULL) < 0)
	{
		printf("SIGINT handler registration failed. semaphores may not be cleared.\n");
		return -1;
	}
*/
	int i;
	pthread_create(pager_tid[0], NULL, pager_listener, NULL);
	pthread_create(pager_tid[1], NULL, pager_worker, NULL);
}

void * pager_listener(void *arg)
{
	mkfifo(PAGER_LISTEN_PATH, 0666);
	int listen_fifo = open(PAGER_LISTEN_PATH, O_RDWR);

        struct timespec sl;
        sl.tv_nsec = 1000;
        sl.tv_sec = 0;

	struct pager_data pd;

	int status;
	while(1)
	{
		nanosleep(&sl, NULL);		// Just to make sure it doesn't hog cpu
		status = read(listen_fifo, &pd, sizeof(struct pager_data));
		if(status > 0)
		{
			PagerData[pindex].reqarr = (int *) malloc(sizeof(pd.len * sizeof(int)));
			memcpy(PagerData[pindex].reqarr, pd.reqarr, pd.len);
			PagerData[pindex].len = pd.len;
			PagerData[pindex].pid = pd.pid;
			pindex++;
		}
	}
}

void * pager_worker(void * arg)
{
        struct timespec sl;
        sl.tv_nsec = 1000;
        sl.tv_sec = 0;
	int status;

	struct pager_data * pd;
	int len;

	int localindex = 0;
	int i,j;
	while(1)
	{
		if(localindex < pindex)
		{
			/* 1. calculate total memory requirements of the selected process */
			unsigned long mem_req = 0, mem_satisfied = 0;
			for(i = 0 ; i < PagerData[localindex].len ; i++)
			mem_req += gmt_table[(PagerData[localindex].reqarr[i])].size;
			/* 2. Select victimes sorted by pid */
			choose_victims_least_frequetly_used(pd, &len, mem_req);
			/* 3. Now, iterate over each victim process in the list */
			for(j = 0 ; j < len ; j++)
			{
				pid_t victim_pid = pd[j].pid;
				/* 4. Find index of victim in Scheduler Data Structure */
				int sched_index = 0;
				for(i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
				{
					if((Scheduler_Data.state[i] == PROC_ACTIVE) && (Scheduler_Data.process_list[i] == victim_pid))
					{
						sched_index = i;
						break;
					}
				}
				/* 5. Mark it as non-schedulable */
				pthread_mutex_lock(&sched_index_mut);
				Scheduler_Data.state[sched_index] = PROC_PAGING;
				pthread_mutex_unlock(&sched_index_mut);
				union sigval sv;
				/* 6. Setup everything to send info after sending PAGING signal */
				char target[100];
				sprintf(target,"%s%ld", PCLIENT_FIFO, victim_pid);
				mkfifo(target, 0666);
				int client_fifo = open(target, O_RDWR);

				/* 7. Send the paging signal to victim */
				sigqueue(victim_pid, SIGPAGE, sv);

				/* 8. Victim will now try to read the pager_data structure */
				write(client_fifo, &pd[j], sizeof(struct pager_data));

				/* 9. Now, victim is paging out his pages. We'll get a notification after
				       the page out process is complete */
				read(client_fifo, &status, sizeof(int));
				close(client_fifo);

				/* 10. We now have to send SIGVTALRM to sleep the victim. Do not send SIGALRM.
				       Must use different than the regular sleep signal so that process goes into
				       different handler and does not send wakeup signal to scheduler. */
				sigqueue(victim, SIGVTALRM, sv);

				/* 11. Mark the victim process as schedulable now */
				pthread_mutex_lock(&sched_index_mut);
				Scheduler_Data.state[sched_index] = PROC_ACTIVE;
				pthread_mutex_unlock(&sched_index_mut);
			}

			/* 12. Send PageInOk notification to the original process */
			char fifoname[100];
			sprintf(fifoname, "%s%ld", PCLIENT_FIFO, PagerData[localindex].pid);
			mkfifo(fifoname, 0666);
			int client_fifo = open(fifoname, O_RDWR);
			pthread_t selfid = pthread_self();
			write(client_fifo, selfid, sizeof(pthread_t));

			/* 13. Wait for client to page in the necessary pages and send back a response */
			int res;
			read(client_fifo, &res, sizeof(int));
			close(client_fifo);
			/* 14. Send a SIGVTALRM to the process to sleep it */
			union sigval v;
			sigqueue(PagerData[localindex].pid, SIGVTALRM, v);

			/* 15. Mark it as schedulable */
			int sched_data_idx = 0;
			for(int i = 0 ; i < MAX_CONTROLLER_COUNT ; i++)
			{
				if((Scheduler_Data.state[i] == PROC_ACTIVE) && (Scheduler_Data.process_list[i] == PagerData[localindex].pid))
				{
					sched_data_idx = i;
					break;
				}
			}

			pthread_mutex_lock(&sched_index_mut);
			Scheduler_Data.state[sched_data_idx] = PROC_ACTIVE;
			pthread_mutex_unlock(&sched_index_mut);

			/* 15. Free up some memory */
			for(j = 0 ; j < MAX_CONTROLLER_COUNT ; j++)
				free(pd[i].reqarr);
			free(pd);

			/* 16. Go to processing next request */
			localindex++;
		}
		else
			nanosleep(&sl, NULL);
	}
}

void choose_victims_least_frequetly_used(struct pager_data *pd, int * len, unsigned long mem_requirement)
{
	unsigned int last_smallest = 0, satisfied = 0;
	pd = (struct pager_data *) malloc(MAX_CONTROLLER_COUNT * sizeof(struct pager_data));
	int pd_len = 0;

	int i,j;
	for(j = 0 ; j < MAX_CONTROLLER_COUNT ; j++)
	{
		pd[i].reqarr = (int *) malloc(MAX_MEMORY * sizeof(int));
		pd[i].len = 0;
	}

	while(satisfied < mem_requirement)
	{
		/* Find smallest, greater than last smallest */
		int max = *gmt_index, minindex = 0, min = -1;
		for(i = 0 ; i < max ; i++)
		{
			if((gmt_table[i].valid) && (min == -1))
			{
				min = gmt_table[i].size;
				minindex = i;
				continue;
			}

			if((gmt_table[i].valid) && (gmt_table[i].size <= min) && (gmt_table[i].size >= last_smallest) 
				&& ((gmt_table[i].status == D_INIT) || (gmt_table[i].status == D_READY) 
					|| (gmt_table[i].status == D_MODIFIED)))
			{
				min = gmt_table[i].size;
				minindex = i;
			}
		}
		/* we got smallest element. Search if the process already exists, otherwise go for next index */
		int chosen_id = -1;
		for(i = 0 ; i < pd_len ; i++)
		{
			if(pd[i].pid == gmt_table[minindex].pid)
				chosen_id = i;
		}

		if(chosen_id == -1)
		{
			chosen_id = pd_len++;
		}

		pd[chosen_id].pid = gmt_table[minindex].pid;
		pd[chosen_id].reqarr[(pd[chosen_id].len++)] = minindex;
		satisfied += min;
	}
	*len = pd_len;
}
