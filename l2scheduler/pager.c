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
	pthread_create(pager_tid, NULL, pager_thread, NULL);
}

void * pager_thread(void *arg)
{
	mkfifo(PAGER_LISTEN_PATH, 0666);
	int listen_fifo = open(PAGER_LISTEN_PATH, O_RDWR);

        struct timespec sl;
        sl.tv_nsec = 1000;
        sl.tv_sec = 0;

	int status;
	while(1)
	{
		nanosleep(&sl, NULL);		// Just to make sure it doesn't hog cpu
	}
}
