#ifndef __PAGER
#define __PAGER 1

#include "sched_commons.h"
#include "../virtmem/cuda_vmem.h"
#include <sys/types.h>
#include <unistd.h>

void start_pager();

struct pager_data
{
	int *reqarr;
	int len;
	pid_t pid;
};

#endif
