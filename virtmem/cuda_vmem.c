#include <stdio.h>
#include <stdlib.h>
#include "cuda_vmem.h"

void mem_map_init(struct mem_map ** table)
{
	*table = NULL;
}

void mem_map_creat(struct mem_map ** table, void ** devptr, size_t size)
{
	struct mem_map *new_node = (struct mem_map *) malloc(sizeof(struct mem_map));
	new_node->devptr = devptr;
	new_node->hostptr = NULL;
	new_node->status = VMEM_READY;
	new_node->size = size;
	new_node->handle = 0;
	new_node->next = NULL;

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

void mem_map_update_hostptr(struct mem_map ** table, void ** devptr, void **hostptr)
{
	if(*table == NULL)
		return;
	struct mem_map * iter = *table;
	while(iter)
	{
		if(iter->devptr == devptr)
		{
			iter->hostptr = hostptr;
			break;
		}
		iter = iter->next;
	}
}

void mem_map_update_status(struct mem_map ** table, void ** devptr, enum vmem_status status)
{
	if(*table == NULL)
		return;
	struct mem_map * iter = *table;
	while(iter)
	{
		if(iter->devptr == devptr)
		{
			iter->status = status;
			break;
		}
		iter = iter->next;
	}
}

unsigned int mem_map_gethandle(struct mem_map ** table, void ** devptr)
{
	if(*table == NULL)
		return 0;
	struct mem_map * iter = *table;
	while(iter)
	{
		if(iter->devptr == devptr)
			return iter->handle;
		iter = iter->next;
	}
	return 0;
}

void mem_map_sethandle(struct mem_map ** table, void ** devptr, unsigned int handle)
{
	if(*table == NULL)
		return;
	struct mem_map * iter = *table;
	while(iter)
	{
		if(iter->devptr == devptr)
		{
			iter->handle = handle;
			break;
		}
		iter = iter->next;
	}
}

void mem_map_delete(struct mem_map ** table, void **devptr)
{
	if(*table == NULL)
		return;
	
	struct mem_map * iter = *table, *prev;

	while(iter)
	{
		if(iter->devptr == devptr)
		{
			if(iter == *table)
				*table = iter->next;
			else
				prev->next = iter->next;
			free(iter);
			break;
		}
		prev = iter;
		iter = iter->next;
	}
}
