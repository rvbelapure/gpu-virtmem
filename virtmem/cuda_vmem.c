#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <cuda.h>
#include <cuda_runtime_api.h>
#include "cuda_vmem.h"
#include "method_id.h"

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

/* Returns the status of the device memory pointed by devptr
 * according to enum vmem_status */
 // TODO : Fix
int mem_map_get_status(struct mem_map ** table, void ** devptr)
{
	fprintf(stderr,"VMEM in get status, devptr = %p\n",*devptr);
	if(*table == NULL)
		return -1;
	struct mem_map * iter = *table;
	while(iter)
	{
		if(*(iter->devptr) == *devptr)
		{
			fprintf(stderr,"VMEM status is %d, devptr = %p\n",iter->status,*devptr);
			return iter->status;
		}
		iter = iter->next;
	}
	return -1;
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
void kmap_add_arg(struct kmap *table,void **arg, size_t size, size_t offset, struct mem_map ** vmem_table)
{
	struct kernel_arg_node * node = (struct kernel_arg_node *) malloc(sizeof(struct kernel_arg_node));
	node->arg = (void **) malloc(sizeof(void *));
	*(node->arg) = *((char **)arg);
	node->size = size;
	node->offset = offset;
	node->vmem_ptr = mem_map_get_entry(vmem_table,(char **)arg);
	node->next = NULL;
	if((table->kobjects[table->index].arg_list.head == NULL) && (table->kobjects[table->index].arg_list.tail == NULL))
		table->kobjects[table->index].arg_list.head = node;
	else
		(table->kobjects[table->index].arg_list.tail)->next = node;
	table->kobjects[table->index].arg_list.tail = node;
}

/* Registers kernel entry with kernel object */
void kmap_add_kernel(struct kmap *table, char * kfun)
{
	table->kobjects[table->index].func = (char *) malloc(sizeof(*kfun));
	memcpy(table->kobjects[table->index].func,kfun,sizeof(*kfun));
	table->kobjects[table->index].valid = 1;
	table->kobjects[table->index].launch_pending = 1;
	table->index++;
}

/* ========================================================================================= */

/* Page in using a row ptr in memory map */
int gvirt_page_in(struct mem_map ** table, struct mem_map * rowptr)
{
	if((rowptr == NULL))
		return SUCCESS;

	struct mem_map * iter = rowptr;
	enum vmem_status st = iter->status;
	if((st == D_MEMWAIT) || (st == D_DEFERRED))
	{
		cudaMalloc(iter->actual_devptr,iter->size);
		cudaMemcpy(*(iter->actual_devptr), iter->swap, iter->size, cudaMemcpyHostToDevice);
		iter->status = D_READY;
		fprintf(stderr,"VMEM paged in %p, new ptr %p,size %ld\n", *devptr, *(iter->actual_devptr), iter->size);
		return SUCCESS;
	}
}

/* Page out using a row ptr in memory map */
int gvirt_page_out(struct mem_map ** table, struct mem_map * rowptr)
{
	if((rowptr == NULL))
		return SUCCESS;

	struct mem_map * iter = rowptr;
	enum vmem_status st = iter->status;
	if((st == D_READY) || (st == D_MODIFIED))
	{
		fprintf(stderr,"VMEM paging out %p, actual ptr %p,size %ld\n", *devptr, *(iter->actual_devptr), iter->size);
		cudaMemcpy(iter->swap, *(iter->actual_devptr), iter->size, cudaMemcpyDeviceToHost);
		cudaFree(*(iter->actual_devptr));
		(*(iter->actual_devptr)) = NULL;
		iter->status = D_MEMWAIT;
		return SUCCESS;
	}
}


/* Page in using a device ptr */
int gvirt_page_in_devptr(struct mem_map ** table, void ** devptr)
{
	if((devptr == NULL) || (*devptr == NULL))
		return SUCCESS;

	struct mem_map * iter = *table;
	while(iter)
	{
		if(*iter->devptr == *devptr)
		{
			enum vmem_status st = iter->status;
			if((st == D_MEMWAIT) || (st == D_DEFERRED))
			{
				cudaMalloc(iter->actual_devptr,iter->size);
				cudaMemcpy(*(iter->actual_devptr), iter->swap, iter->size, cudaMemcpyHostToDevice);
				iter->status = D_READY;
				fprintf(stderr,"VMEM paged in %p, new ptr %p,size %ld\n", *devptr, *(iter->actual_devptr), iter->size);
				return SUCCESS;
			}
		}
		iter = iter->next;
	}
	return FAILURE;
}

/* Page out using a device ptr */
int gvirt_page_out_devptr(struct mem_map ** table, void ** devptr)
{
	if((devptr == NULL) || (*devptr == NULL))
		return SUCCESS;

	struct mem_map * iter = *table;
	while(iter)
	{
		if(*iter->devptr == *devptr)
		{
			enum vmem_status st = iter->status;
			if((st == D_READY) || (st == D_MODIFIED))
			{
				fprintf(stderr,"VMEM paging out %p, actual ptr %p,size %ld\n", *devptr, *(iter->actual_devptr), iter->size);
				cudaMemcpy(iter->swap, *(iter->actual_devptr), iter->size, cudaMemcpyDeviceToHost);
				cudaFree(*(iter->actual_devptr));
				(*(iter->actual_devptr)) = NULL;
				iter->status = D_MEMWAIT;
				return SUCCESS;
			}
		}
		iter = iter->next;
	}
	return FAILURE;
}

void gvirt_pageout_all(struct mem_map ** table)	/* sample test method */
{
	fprintf(stderr,"VMEM Paging out all the devptrs\n");
	struct mem_map * iter = *table;
	cudaDeviceSynchronize();
	while(iter)
	{
		enum vmem_status st = iter->status;
		if((st == D_READY) || (st == D_MODIFIED))
		{
			fprintf(stderr,"VMEM paging out %p, size %ld\n", *(iter->actual_devptr), iter->size);
			cudaMemcpy(iter->swap, *(iter->actual_devptr), iter->size, cudaMemcpyDeviceToHost);
			cudaFree(*(iter->actual_devptr));
			(*(iter->actual_devptr)) = NULL;
			iter->status = D_MEMWAIT;
		}
		iter = iter->next;
	}
}

void gvirt_pagein_all(struct mem_map ** table) /* sample test method */
{
	fprintf(stderr,"VMEM Paging in all the devptrs\n");
	struct mem_map * iter = *table;
	cudaDeviceSynchronize();
	while(iter)
	{
		enum vmem_status st = iter->status;
		if((st == D_MEMWAIT) || (st == D_DEFERRED))
		{
			cudaMalloc(iter->actual_devptr,iter->size);
			cudaMemcpy(*(iter->actual_devptr), iter->swap, iter->size, cudaMemcpyHostToDevice);
			iter->status = D_READY;
			fprintf(stderr,"VMEM paged in %p, size %ld\n", *(iter->actual_devptr), iter->size);
		}
		iter = iter->next;
	}
}

/* Launch the kernel object specified by the given index */
int gvirt_cuda_launch_index(struct kmap * ktab, struct mem_map ** mtab, int index)
{
	if(index >= ktab->index)
		return FAILURE;
	struct kmap_node * launch_node = ktab->kobjects[index];
	if(!launch_node->launch_pending)
		return KLAUNCH_NOT_PENDING;

	/* Page in all the arguments */
	struct kernel_arg_node * iter = launch_node->arg_list.head;
	while(iter)
	{
		gvirt_page_in(mtab, iter->vmem_ptr);
		iter = iter->next;
	}

	/* Make ConfigureCall */
	cudaConfigureCall(launch_node->gridDim, launch_node->blockDim, launch_node->sharedMem, launch_node->stream);
	iter = launch_node->arg_list.head;
	void *arg;
	while(iter)
	{
		if(iter->vmem_ptr)
			arg = *iter->vmem_ptr->actual_devptr;
		else
			arg = *iter->arg
		cudaSetupArgument(&arg,iter->size,iter->offset);
	}
	cudaLaunch(launch_node->func);
	return 0;
}
