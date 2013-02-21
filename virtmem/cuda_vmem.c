#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "cuda_vmem.h"

void mem_map_init(struct mem_map ** table)
{
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
	if(*table == NULL)
		return -1;
	struct mem_map * iter = *table;
	while(iter)
	{
		if(*(iter->devptr) == *devptr)
		{
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
	if(*table == NULL)
		return;
	struct mem_map * iter = *table;
	while(iter)
	{
		if(*(iter->devptr) == *devptr)
		{
			memcpy(iter->swap, src, size);
			break;
		}
		iter = iter->next;
	}

}

void ** mem_map_get_actual_devptr(struct mem_map ** table, void ** devptr)
{
	if(*table == NULL)
		return;
	struct mem_map * iter = *table;
	while(iter)
	{
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


/* ===================================================================================*/


