#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <cuda.h>
#include <cuda_runtime_api.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>
#include "cuda_vmem.h"
#include "method_id.h"
#include "../l2scheduler/sched_commons.h"
#include "../l2scheduler/pager.h"
#include "semaphore_ops.h"

/* Initialize memory map. */
void mem_map_init(struct mem_map ** table, int size)
{
	fprintf(stderr,"VMEM vmem system initialized\n");
	for(int i = 0 ; i < size ; i++)
	{
		*table[i]->valid = 0;
		*table[i]->devptr = NULL;
		*table[i]->actual_devptr = NULL;
		*table[i]->swap = NULL;
		*table[i]->handle = i;
		*table[i]->size = 0;
		*table[i]->status = D_NOALLOC;
		*table[i]->pid = getpid();
	}
}

/* This creates an entry in the memory map for each device pointer at given index in the table. */
int mem_map_creat(struct mem_map ** table, void ** devptr, size_t size, int index)
{
	struct mem_map *new_node = table[index];
	if(cudaMalloc(&new_node->actual_devptr, size) == cudaSuccess)
		new_node->status = D_INIT;
	else
	{
		new_node->status = D_NOALLOC;
		new_node->actual_devptr = NULL;
	}
	new_node->swap = (void *) malloc(size);
	new_node->size = size;
	devptr = (void **) malloc(sizeof(int *));
	*devptr = &new_node->handle;
	new_node->valid = 1;

	fprintf(stderr,"VMEM new vmem entry, devptr = %p\n",*devptr);
}

/* Delete a row in the memory map */
void mem_map_delete(struct mem_map ** table, int index)
{
	struct mem_map *node = table[i];

	if(node->actual_devptr)
		cudaFree(node->actual_devptr);

	if(node->swap)
		free(node->swap);

	node->actual_devptr = NULL;
	node->swap = NULL;
	node->size = 0;
	node->status = D_NOALLOC;
	node->valid = 0;
}

/* Searches the entries at all given indexes and returns the index if the entry matches */
int mem_map_find_entry(struct mem_map ** table, int *indexes, int len, void * devptr)
{
	struct mem_map *node;
	for(int i = 0 ; i < len ; i++)
	{
		if((indexes[i] >= 0) && (devptr != NULL) && (devptr == &table[(indexes[i])]->handle))
			return i;
	}
	return -1;
}

/* memcpy : H2D, D2H */
void mem_map_memcpy(struct mem_map ** table, int index, void * dest, void * src, int size, int type)
{
	struct mem_map *node = table[index];
	switch(type)
	{
		case CUDA_MEMCPY_H2D:
			/* dest is actually ptr to handle, src has data */
			memcpy(node->swap, src, size);
			switch(node->status)
			{
				case D_INIT:
				case D_READY:
				case D_MODIFIED:
					cudaMemcpy(node->actual_devptr, node->swap, size, cudaMemcpyHostToDevice);
					node->status = D_READY;
					break;
				case D_NOALLOC:
				case D_MEMWAIT:
					node->status = D_MEMWAIT;
					break;
				case D_DEFERRED:
					node->status = D_DEFERRED;
					break;
				default:
			}
			break;
		case CUDA_MEMCPY_D2H:
			/* dest is a host ptr. actual_devptr or swap has data depending on state */
			switch(node->status)
			{
				case D_NOALLOC:
				case D_INIT:
					break;
				case D_READY:
				case D_MODIFIED:
					cudaMemcpy(node->swap, node->actual_devptr, size, cudaMemcpyDeviceToHost);
					memcpy(dest, node->swap, size);
					node->status = D_READY;
					break;
				case D_MEMWAIT:
					memcpy(dest, node->swap, size);
					node->status = D_MEMWAIT;
					break;
				case D_DEFERRED:
					memcpy(dest, node->swap, size);
					node->status = D_DEFERRED;
					break;
				default:

			}
			break;
		default:
	}
}

/* ===================================================================================*/

/* Consider a kernel launch --->   kernel<<<gdim,bdim>>>(arg1,arg2);
 * Following functions are invoked when a kernel is lauched in cuda program:
 * 
 * 1. cudaConfigureCall(gdim,bdim,sharedmem __dv(0), stream __dv(0))
 * 2. cudaSetupArgument
 * 	Few quirks in this method.
 * 	a. This is called as many times as there are arguments in the kernel launch.
 * 	   Each call sets up one argument at a time.
 * 	b. It is called with address of the argument passed to the kernel function
 * 	cudaSetupArgument(&arg1,...)
 * 	cudaSetupArgument(&arg2,...)
 * 	   So, in case of pointers, this is really a double pointer cast to (void *).
 * 3. cudaLaunch(entry_for_kernel_function_in_cuda_fat_binary))
*/

/* Initializw the kernel map */
void kmap_init(struct kmap * table)
{
	table->kobjects = (struct kmap_node *) malloc(MAX_KERNELS * sizeof(struct kmap));
	int i;
	for(i = 0 ; i < MAX_KERNELS ; i++)
	{
		table->kobjects[i].valid = 0;
		table->kobjects[i].launch_pending = 0;	
		table->kobjects[i].arg_list.head = NULL;
		table->kobjects[i].arg_list.tail = NULL;
	}
	table->index = 0;
}

/* To be called when cudaConfigureCall is called. Stores the parameters of cudaConfigureCall in current kernel object */
void kmap_add_config(struct kmap *table, dim3 gridDim, dim3 blockDim, size_t sharedMem, cudaStream_t stream)
{
	table->kobjects[table->index].gridDim = gridDim;
	table->kobjects[table->index].blockDim = blockDim;
	table->kobjects[table->index].sharedMem = sharedMem;
	table->kobjects[table->index].stream = stream;
}

/* To be called on invocation of cudaSetupArgument. Will be called multiple times, 
 * viz. equal to the number of arguments to the kernel, for each kernel objects.
 * All arguments may not be device pointers. */
void kmap_add_arg(struct kmap *table,void **arg, size_t size, size_t offset, int vindex)
{
	struct kernel_arg_node * node = (struct kernel_arg_node *) malloc(sizeof(struct kernel_arg_node));
	node->arg = (void **) malloc(sizeof(void *));
	*(node->arg) = *((char **)arg);
	node->size = size;
	node->offset = offset;
	node->mem_map_index = vindex;
	node->next = NULL;
	if((table->kobjects[table->index].arg_list.head == NULL) && (table->kobjects[table->index].arg_list.tail == NULL))
		table->kobjects[table->index].arg_list.head = node;
	else
		(table->kobjects[table->index].arg_list.tail)->next = node;
	table->kobjects[table->index].arg_list.tail = node;
}

/* Registers kernel entry with kernel object */
int kmap_add_kernel(struct kmap *table, char * kfun)
{
	table->kobjects[table->index].func = (char *) malloc(sizeof(*kfun));
	memcpy(table->kobjects[table->index].func,kfun,sizeof(*kfun));
	table->kobjects[table->index].valid = 1;
	table->kobjects[table->index].launch_pending = 1;
	return table->index++;
}

/* ========================================================================================= */

/* Returns if paging is required or not. Fills pagein_request array with the mem_map indices
   that require page in. reqsize will have length of this array. Remember to free them as
   they are malloc'ed here. */
int gvirt_is_paging_required(struct kmap *ktable, int kindex, struct mem_map ** mtable, int * pagein_request, int * reqsize)
{
	int pagein_required = 0;
	int reqarr[50], len;		// hoping that cuda kernel will not have more than 50 arguments
	struct kernel_arg_node * iter = ktable->kobjects[kindex].arg_list.head;
	len = 0;
	while(iter)
	{
		if(iter->mem_map_index >= 0)
		{
			struct mem_map * mnode = mtable[iter->mem_map_index];
			if((mnode->valid) && ((mnode->status == D_MEMWAIT) || (mnode->status == D_DEFERRED)))
			{
				pagein_required = 1;
				reqarr[len++] = iter->mem_map_index;
			}
		}
		iter = iter->next;
	}

	if(pagein_required)
	{
		pagein_request = (int *) malloc(len * sizeof(int));
		reqsize = (int *) malloc(sizeof(int));
	}

	for(int i = 0 ; i < len ; i++)
		pagein_request[i] = reqarr[i];
	*reqsize = len;

	return pagein_required;
}

/* Page in all the pages needed by the launch. Indexes of the pages are specified in reqarr.
   This function is to be called from nvbackcudaLaunch_srv()
*/
void gvirt_page_in(struct mem_map ** table, int * reqarr, int len)
{
	/* 1. Stop the current scheduling timer */
	struct itimerval it;
	it.it_interval.tv_sec = 0;
	it.it_interval.tv_usec = 0;
	it.it_value.tv_sec = 0;
	it.it_value.tv_usec = 0;
	setitimer(ITIMER_REAL, &it, NULL);

	/* 2. Notify Scheduler about the end of timer intervali, and not to schedule it anymore */
	pid_t sched_pid;
	union sigval 
	FILE *fp = fopen(SCHED_PID_FILE_PATH, "r");
	fscanf(fp,"%ld",&sched_pid);
	fclose(fp);
	union sigval data;
	data.sival_int = gpu_binding;
	sigqueue(sched_pid, SIGPAGE, data);

	/* 3. Notify pager about the page in requests */
	char target[100];
	sprintf(target, "%s%ld", PCLIENT_FIFO, getpid());
	mkfifo(PAGER_LISTEN_PATH, 0666);
	mkfifo(target, 0666);

	struct pager_data pd;
	pd.reqarr = reqarr;
	pd.len = len;
	pd.pid = getpid();
	int semid;
	if((semid = semget(ftok(SEMKEYPATH, SEMKEYID), 1, 0666)) == -1){
		perror("semget failed");
		return;
	}
	int server_fifo, client_fifo;
	pthread_t pager_tid;
	server_fifo = open(PAGER_LISTEN_PATH, O_WRONLY);
	client_fifo = open(target, O_RDWR);
	P(semid);
	write(server_fifo, &pd, sizeof(pd));
	V(semid);
//	close(server_fifo);
	/* 4. Wait for pager response */
	read(client_fifo, &pager_tid, sizeof(pthread_t));

	/* 5. Page in everything */
	for(int i = 0 ; i < len ; i++)
	{
		struct mem_map * node = table[reqarr[i]];
		if((node->status == D_MEMWAIT) || (node->status == D_DEFERRED))
		{
			cudaMalloc(node->actual_devptr,node->size);
			cudaMemcpy(*(node->actual_devptr), node->swap, node->size, cudaMemcpyHostToDevice);
			node->status = D_READY;
		}
	}

	/* 6. Notify pager that page in is complete */
	int st = 1;
	write(client_fifo, st, sizeof(st));
//	close(client_fifo);

	/* 7. Pager will send a SIGALRM to this process now so that it sleeps */
}

/* This function only performs page out. Taking care of signaling with scheduler is part of handler's job
   To be called from SIGPAGE handler (when executing) or from SIGSCHED handler (when sleeping)
*/
void gvirt_page_out(struct mem_map ** table)
{
	/* 1. Get pageout request data from the pager */
	char target[100];
	sprintf(target, "%s%ld", PCLIENT_FIFO, getpid());
	mkfifo(target, 0666);

	struct pager_data pd;

	int client_fifo = open(target, O_RDWR);
	read(client_fifo, &pd, sizeof(struct pager_data));

	/* 2. Page out the requested pages */
	for(int i = 0 ; i < pd.len ; i++)
	{
		struct mem_map * node = table[pd.reqarr[i]];
		if((node->status == D_READY) || (node->status == D_MODIFIED))
		{
			cudaMemcpy(node->swap, node->actual_devptr, node->size, cudaMemcpyDeviceToHost);
			cudaFree(node->actual_devptr);
			node->actual_devptr = NULL;
			node->status = D_MEMWAIT;
		}
	}

	/* 3. Notify pager about page out completion */
	int st = 1;
	write(client_fifo, &st, sizeof(st));

//	close(client_fifo);  /* XXX : we choose not to close this end so that pager doesn't get SIGPIPE */
	/* 4. Pager will send a SIGVTALRM to sleep this process now */
}

/* Launch the kernel object specified by the given index */
void gvirt_cuda_launch_index(struct kmap * ktab, int index, struct mem_map ** mtab)
{
	struct kmap_node * launch_node = ktab->kobjects[index];
	struct kernel_arg_node * iter;

	/* Make ConfigureCall */
	cudaConfigureCall(launch_node->gridDim, launch_node->blockDim, launch_node->sharedMem, launch_node->stream);
	iter = launch_node->arg_list.head;
	void *arg;
	while(iter)
	{
		if(iter->mem_map_index >= 0)
			arg = mtab[iter->mem_map_index]->actual_devptr;
		else
			arg = *iter->arg
		cudaSetupArgument(&arg,iter->size,iter->offset);
	}
	cudaLaunch(launch_node->func);
}
