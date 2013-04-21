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
	D_NOALLOC,	// device mem not allocated, no data available
	D_INIT,		// device mem allocated, but no data available on either device or with vmem system
	D_READY,	// device mem allocated and data copied on device, in sync with vmem system - cudaLaunch allowed
	D_MODIFIED,	// device mem allocated, data present on device, but may be out of sync with vmem system - cudaLaunch allowed
//	D_IDLE,		// device mem allocated, data on device and host, may be out of sync, kernel execution complete
	D_MEMWAIT,	// device mem not allocated. But data exists with vmem system. - must call host2device copy before cudaLaunch
	D_DEFERRED	// device mem not allocated & can not allocate, data with vmem system, cudaLaunch request received

};

struct mem_map
{
	int valid;			// if the entry is valid
	int handle;			// return address of this as a devptr to application
	void * actual_devptr;		// actual devptr
	void * swap;			// host swap space
	size_t size;			// size of the requested memory
	enum vmem_status status;	// takes one of the values in enum vmem_status
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
void mem_map_creat(struct mem_map ** table, void ** devptr, size_t size);
void mem_map_delete(struct mem_map ** table, void **devptr);
int mem_map_find_entry(struct mem_map ** table, int *indexes, int len, void * devptr);
void mem_map_memcpy(struct mem_map ** table, int index, void * dest, void * src, int size, int type);


void mem_map_get_next_index(struct mem_map **table, struct *global_index);
int mem_map_get_status(struct mem_map ** table, void ** devptr);
void mem_map_update_status(struct mem_map ** table, void ** devptr, enum vmem_status status);
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
