#include <stdio.h>
#include  <stdlib.h>
#include  <sys/types.h>
#include  <sys/ipc.h>
#include  <sys/shm.h>

#include "fair_share_sched.h"
#include "las_scheduler.h"


pthread_t thIDs[10];	/* for schedulers */
pthread_t pager_tid[2]; /* for pager */

void register_handlers()
{
	;
}

int main()
{
	key_t shmkey;
	int shmid;

	int sched_thread_count;

	register_handlers();

	#ifdef SCHED_FAIR_SHARE
	sched_thread_count = fs_start_scheduler();
	#endif

	#ifdef SCHED_LAS
	sched_thread_count = las_start_scheduler();
	#endif

	/* Pager must start after schedulers. A signal handler is being registered in fs_start_scheduler()
	 * which must be done before we create any pthreads */
	#ifdef PAGER
	start_pager();
	#endif

	#ifdef PAGER
	pthread_join(pager_tid,NULL);
	#endif

	int i;
	for(i = 0 ; i < sched_thread_count ; i++)
		pthread_join(thIDs[i],NULL);

	pthread_join(pager_tid[0],NULL);
	pthread_join(pager_tid[1],NULL);

	return 0;
}
