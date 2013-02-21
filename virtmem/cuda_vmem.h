#ifndef __CUDA_VMEM_H
#define __CUDA_VMEM_H

#include <stdlib.h>
#include <cuda.h>
#include <cuda_runtime_api.h>

enum vmem_status
{
	D_INIT,		// device mem is malloc'ed, but no data available on either device or with vmem system
	D_READY,	// device mem allocated and data copied on device, in sync with vmem system - cudaLaunch allowed
	D_MODIFIED,	// device mem allocated, data present on device, but may be out of sync with vmem system - cudaLaunch allowed
	D_MEMWAIT,	// device mem is not allocated. But data exists with vmem system. - must call host2device copy before cudaLaunch
	D_DEFERRED	// device mem not allocated & can not allocate, data with vmem system, cudaLaunch request received
};

struct mem_map
{
	void ** devptr;
	void ** actual_devptr;
	void * swap;
	enum vmem_status status;
	size_t size;
	struct mem_map *next;
};


struct kernel_args
{
	void *arg;
	size_t size;
	size_t offset;
	struct mem_map * vmem_ptr;
	struct kernel_args *next;
}

struct kernel_map
{
	/* Arguments for cudaConfigureCall */
	dim3 gridDim;
	dim3 blockDim;
	size_t sharedMem;
	cudaStream_t stream;

	/* Kernel Arg List */
	struct kernel_args * arg_list;

	/* Launch Function */
	char * func;
};

void mem_map_init(struct mem_map ** table);
void mem_map_creat(struct mem_map ** table, void ** devptr, size_t size);
void mem_map_get_status(struct mem_map ** table, void ** devptr);
void mem_map_update_status(struct mem_map ** table, void ** devptr, enum vmem_status status);
void mem_map_delete(struct mem_map ** table, void **devptr);
void mem_map_update_data(struct mem_map ** table, void **devptr, void *src, size_t size);
void mem_map_get_actual_devptr(struct mem_map ** table, void **devptr);
struct mem_map * mem_map_get_entry(struct mem_map ** table, void **devptr);


/* 
 * new kmap
 * add arg
 * update kernel fun
 * delete kmap */

#endif
