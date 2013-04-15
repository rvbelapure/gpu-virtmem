#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "cuda_vmem.h"

/* Initialize memory map. */
void mem_map_init(struct mem_map ** table)
{
	fprintf(stderr,"VMEM vmem system initialized\n");
	*table = NULL;
}

/* This creates an entry in the memory map for each device pointer. */
void mem_map_creat(struct mem_map ** table, void ** devptr, size_t size)
{
	struct mem_map *new_node = (struct mem_map *) malloc(sizeof(struct mem_map));
	new_node->devptr = (void **) malloc(sizeof(void *));
	new_node->actual_devptr = (void **) malloc(sizeof(void *));
	*(new_node->devptr) = *devptr;
	*(new_node->actual_devptr) = *devptr;
	new_node->swap = (void *) malloc(size);
	new_node->status = D_INIT;
	new_node->size = size;
	new_node->next = NULL;

	fprintf(stderr,"VMEM new vmem entry, devptr = %p\n",*devptr);

	if(*table == NULL)
		*table = new_node;
	else
	{
		struct mem_map * iter = *table;
		while(iter->next)
			iter = iter->next;
		iter->next = new_node;
	}
}

/* Returns the status of the device memory pointed by devptr
 * according to enum vmem_status */
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

/* Update the status of memory pointed by devptr */
void mem_map_update_status(struct mem_map ** table, void ** devptr, enum vmem_status status)
{
	if(*table == NULL)
		return;
	struct mem_map * iter = *table;
	while(iter)
	{
		if(*(iter->devptr) == *devptr)
		{
			iter->status = status;
			break;
		}
		iter = iter->next;
	}
}

/* Should be called when host to device memcpy is initialized by the program.
 * Stores the data being sent to the device in the swap area of virtual memory system */
void mem_map_update_data(struct mem_map ** table, void **devptr, void *src, size_t size)
{

	fprintf(stderr,"VMEM update data called, devptr = %p\n",*devptr);
	if(*table == NULL)
		return;
	struct mem_map * iter = *table;
	while(iter)
	{
		if(*(iter->devptr) == *devptr)
		{
			memcpy(iter->swap, src, size);
			fprintf(stderr,"VMEM updated data, devptr = %p\n",*devptr);
			break;
		}
		iter = iter->next;
	}

}

/* Get translation from devptr to actual_devptr.
 * The program knows devptr. But the actual device pointer might be different due
 * to the extra virtual memory abstaction layer */
void ** mem_map_get_actual_devptr(struct mem_map ** table, void ** devptr)
{
	fprintf(stderr, "VMEM Searching actual device ptrs...\n");
	if(*table == NULL)
		return NULL;
	struct mem_map * iter = *table;
	while(iter)
	{
		fprintf(stderr,"VMEM %p == %p ?\n",*(iter->devptr), *devptr);
		if(*(iter->devptr) == *devptr)
			return iter->actual_devptr;
		iter = iter->next;
	}
	return NULL;
}

/* Delete a row in the memory map */
void mem_map_delete(struct mem_map ** table, void **devptr)
{
	if(*table == NULL)
		return;
	
	struct mem_map * iter = *table, *prev;

	while(iter)
	{
		if(*(iter->devptr) == *devptr)
		{
			if(iter == *table)
				*table = iter->next;
			else
				prev->next = iter->next;

			free(iter->devptr);
			free(iter->actual_devptr);
			free(iter->swap);
			free(iter);
			break;
		}
		prev = iter;
		iter = iter->next;
	}
}

/* Returns pointer to the row of memory map, identified by devptr */
struct mem_map * mem_map_get_entry(struct mem_map ** table, void **devptr)
{
	if(*table == NULL)
		return NULL;
	
	struct mem_map * iter = *table;

	while(iter)
	{
		if(*(iter->devptr) == *devptr)
			return iter;
		iter = iter->next;
	}
	return NULL;
}

/* Print complete memory map */
void mem_map_print(struct mem_map ** table) /* sample test method */
{
	struct mem_map * iter = *table;
	while(iter)
	{
		fprintf(stderr,"VMEM devptr = %p, actual devptr = %p, status = %d, size = %d, swap = %p\n",
				*(iter->devptr),*iter->actual_devptr,iter->status,iter->size,iter->swap);
		iter = iter->next;
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
