#ifndef __CUDA_VMEM_H
#define __CUDA_VMEM_H

#include <stdlib.h>

enum vmem_status
{
	VMEM_READY,
	VMEM_MEMWAIT,
	VMEM_BUSY
};

struct mem_map
{
	void ** devptr;
	void ** hostptr;
	enum vmem_status status;
	size_t size;
	unsigned int handle;
	struct mem_map *next;
};

void mem_map_init(struct mem_map ** table);
void mem_map_creat(struct mem_map ** table, void ** devptr, size_t size);
void mem_map_update_hostptr(struct mem_map ** table, void ** devptr, void **hostptr);
void mem_map_update_status(struct mem_map ** table, void ** devptr, enum vmem_status status);
unsigned int mem_map_gethandle(struct mem_map ** table, void ** devptr);
void mem_map_sethandle(struct mem_map ** table, void ** devptr, unsigned int handle);
void mem_map_delete(struct mem_map ** table, void **devptr);

#endif
