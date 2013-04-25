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
void choose_victims_least_frequetly_used(struct pager_data *pd, int * len, unsigned long mem_requirement);

extern struct mem_map * vmap_table;
extern int * vmap_index;

extern int vmapped_local_arr[MAX_MEMORY];
extern int localindex;


#endif
