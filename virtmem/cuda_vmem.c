#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "cuda_vmem.h"

void mem_map_init(struct mem_map ** table)
{
	fprintf(stderr,"VMEM vmem system initialized\n");
	*table = NULL;
}

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

void vmem_pageout_all(struct mem_map ** table)	/* sample test method */
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

void vmem_pagein_all(struct mem_map ** table) /* sample test method */
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

void mem_map_print(struct mem_map ** table) /* sample test method */
{
	struct mem_map * iter = *table;
	while(iter)
	{
		fprintf(stderr,"VMEM devptr = %p, actual devptr = %p, status = %d, size = %d, swap = %p\n",*(iter->devptr),*iter->actual_devptr,
		iter->status,iter->size,iter->swap);
		iter = iter->next;
	}
}


/* ===================================================================================*/

int kindex, top, bottom;

struct kmap * kmap_creat()
{
	struct kmap * table = (struct kmap *) malloc(MAX_KERNELS * sizeof(struct kmap));
	int i;
	for(i = 0 ; i < MAX_KERNELS ; i++)
	{
		table[i].valid = 0;
		table[i].launch_pending = 0;	
		table[i].arg_list.head = NULL;
		table[i].arg_list.tail = NULL;
	}
	kindex = 0;
	top = 0;
	bottom = 0;
	return table;
}

void kmap_add_config(struct kmap *table, dim3 gridDim, dim3 blockDim, size_t sharedMem, cudaStream_t stream)
{
	table[kindex].gridDim = gridDim;
	table[kindex].blockDim = blockDim;
	table[kindex].sharedMem = sharedMem;
	table[kindex].stream = stream;
}

void kmap_add_arg(struct kmap *table,void *arg, size_t size, size_t offset, struct mem_map ** vmem_table)
{
	struct kernel_arg_node * node = (struct kernel_arg_node *) malloc(sizeof(struct kernel_arg_node));
	node->arg = arg;
	node->size = size;
	node->offset = offset;
	node->vmem_ptr = mem_map_get_entry(vmem_table,&arg);
	node->next = NULL;
	if((table[kindex].arg_list.head == NULL) && (table[kindex].arg_list.tail == NULL))
		table[kindex].arg_list.head = node;
	else
		(table[kindex].arg_list.tail)->next = node;
	table[kindex].arg_list.tail = node;
}

void kmap_add_kernel(struct kmap *table, char * kfun)
{
	table[kindex].func = kfun;
	table[kindex].valid = 1;
	table[kindex].launch_pending = 1;
	kindex++;
	top++;
}

void kmap_launch(struct kmap * table, int idx)
{
	if(idx < 0)
	{
		table[bottom].launch_pending = 0;
		bottom++;
	}
	else
		table[idx].launch_pending = 1;
}

void kmap_clear(struct kmap *table)
{
	int i;
	for(i = 0 ; i < MAX_KERNELS ; i++)
	{
		while(table[i].arg_list.head)
		{
			struct kernel_arg_node * temp = table[i].arg_list.head;
			table[i].arg_list.head = temp->next;
			free(temp);
		}
		table[i].arg_list.head = NULL;
		table[i].arg_list.tail = NULL;
		table[i].valid = 0;
		table[i].launch_pending = 0;
	}
}

void kmap_delete(struct kmap *table)
{
	int i;
	for(i = 0 ; i < MAX_KERNELS ; i++)
	{
		while(table[i].arg_list.head)
		{
			struct kernel_arg_node * temp = table[i].arg_list.head;
			table[i].arg_list.head = temp->next;
			free(temp);
		}
	}
	free(table);
}
