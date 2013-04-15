#ifndef __CUDA_VMEM_H
#define __CUDA_VMEM_H

#include <stdlib.h>
#include <cuda.h>
#include <cuda_runtime_api.h>

#define MAX_KERNELS 10000
#define MAX_MEMORY  10000

#define SUCCESS 0
#define FAILURE 1
#define KLAUNCH_NOT_PENDING 2

enum vmem_status
{
	D_INIT,		// device mem is malloc'ed, but no data available on either device or with vmem system
	D_READY,	// device mem allocated and data copied on device, in sync with vmem system - cudaLaunch allowed
	D_MODIFIED,	// device mem allocated, data present on device, but may be out of sync with vmem system - cudaLaunch allowed
	D_IDLE,		// device mem allowed, data on device and host, may be out of sync, kernel execution complete
	D_MEMWAIT,	// device mem is not allocated. But data exists with vmem system. - must call host2device copy before cudaLaunch
	D_DEFERRED	// device mem not allocated & can not allocate, data with vmem system, cudaLaunch request received

};

struct mem_map
{
	int valid;
	int handle;
	void ** devptr;
	void ** actual_devptr;
	void * swap;
	enum vmem_status status;
	size_t size;
	struct mem_map *next;
};


struct kernel_arg_node
{
	void **arg;
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

struct kmap_node	/* kernel map */
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

struct kmap
{
	struct kmap_node * kobjects;
	int index;
};

void mem_map_init(struct mem_map ** table);
void mem_map_get_next_index(struct mem_map **table, struct *global_index);
void mem_map_creat(struct mem_map ** table, void ** devptr, size_t size);
int mem_map_get_status(struct mem_map ** table, void ** devptr);
void mem_map_update_status(struct mem_map ** table, void ** devptr, enum vmem_status status);
void mem_map_delete(struct mem_map ** table, void **devptr);
void mem_map_update_data(struct mem_map ** table, void **devptr, void *src, size_t size);
void ** mem_map_get_actual_devptr(struct mem_map ** table, void **devptr);
struct mem_map * mem_map_get_entry(struct mem_map ** table, void **devptr);
void mem_map_print(struct mem_map **table);


void kmap_init(struct kmap * table);
void kmap_add_config(struct kmap *table, dim3 gridDim, dim3 blockDim, size_t sharedMem, cudaStream_t stream);
void kmap_add_arg(struct kmap *table,void *arg, size_t size, size_t offset, struct mem_map ** vmem_table);
void kmap_add_kernel(struct kmap *table, char * kfun);


int gvirt_page_in_devptr(struct mem_map ** table, void ** devptr);
int gvirt_page_out_devptr(struct mem_map ** table, void ** devptr);
int gvirt_page_in(struct mem_map ** table, struct mem_map * rowptr);
int gvirt_page_out(struct mem_map ** table, struct mem_map * rowptr);
void gvirt_pageout_all(struct mem_map ** table);
void gvirt_pagein_all(struct mem_map ** table);

int gvirt_cuda_launch_index(struct kmap * table, int index);
#endif
