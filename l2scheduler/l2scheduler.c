#include <stdio.h>
#include  <stdlib.h>
#include  <sys/types.h>
#include  <sys/ipc.h>
#include  <sys/shm.h>

#include "fair_share_sched.h"
#include "las_scheduler.h"

int main()
{
	key_t shmkey;
	int shmid;

	#ifdef SCHED_FAIR_SHARE
	fs_start_scheduler();
	#endif

	#ifdef SCHED_LAS
	las_start_scheduler();
	#endif
	return 0;
}
