#ifndef __PAGER
#define __PAGER 1

#include "sched_commons.h"
#include "../virtmem/cuda_vmem.h"
#include <sys/types.h>
#include <unistd.h>

struct pager_data
{
	int *reqarr;
	int len;
	pid_t pid;
};


void start_pager();
void * pager_listener(void *arg);
void * pager_worker(void *arg);
int choose_victim();


#endif
