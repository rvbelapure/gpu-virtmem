#ifndef __CUDA_VMEM_H
#define __CUDA_VMEM_H

#include <stdlib.h>
#include <cuda.h>
#include <cuda_runtime_api.h>

#define MAX_KERNELS 10000

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


struct kernel_arg_node
{
	void *arg;
	size_t size;
	size_t offset;
	struct mem_map * vmem_ptr;
	struct kernel_arg_node *next;
};

struct kernel_args
{
	struct kernel_arg_node *head;
	struct kernel_arg_node *tail;
};

struct kmap	/* kernel map */
{
	int valid;
	int launch_pending;
	/* Arguments for cudaConfigureCall */
	dim3 gridDim;
	dim3 blockDim;
	size_t sharedMem;
	cudaStream_t stream;

	/* Kernel Arg List */
	struct kernel_args arg_list;

	/* Launch Function */
	char * func;
};

void mem_map_init(struct mem_map ** table);
void mem_map_creat(struct mem_map ** table, void ** devptr, size_t size);
int mem_map_get_status(struct mem_map ** table, void ** devptr);
void mem_map_update_status(struct mem_map ** table, void ** devptr, enum vmem_status status);
void mem_map_delete(struct mem_map ** table, void **devptr);
void mem_map_update_data(struct mem_map ** table, void **devptr, void *src, size_t size);
void ** mem_map_get_actual_devptr(struct mem_map ** table, void **devptr);
struct mem_map * mem_map_get_entry(struct mem_map ** table, void **devptr);


struct kmap * kmap_creat();
void kmap_add_config(struct kmap *table, dim3 gridDim, dim3 blockDim, size_t sharedMem, cudaStream_t stream);
void kmap_add_arg(struct kmap *table,void *arg, size_t size, size_t offset, struct mem_map ** vmem_table);
void kmap_add_kernel(struct kmap *table, char * kfun);
void kmap_launch(struct kmap * table, int index);
void kmap_clear(struct kmap *table);
void kmap_delete(struct kmap *table);


void vmem_pageout_all(struct mem_map ** table);
void vmem_pagein_all(struct mem_map ** table);

#endif
