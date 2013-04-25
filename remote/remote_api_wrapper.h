/**
 * @file remote_api_wrapper.h
 * @brief Constants for the network module, copied from
 * remote_gpu/network/remote_api_wrapper.c and
 * edited by me MS to make it more independent
 *
 * @date Feb 25, 2011
 * @author Magda Slawinska, magg@gatech.edu
 */

#ifndef __REMOTE_CUDA_CALLS_WRAPPER_H
#define __REMOTE_CUDA_CALLS_WRAPPER_H

#include "packetheader.h"
#include "connection.h"
#include "../l2scheduler/pager.h"

//extern void** __cudaRegisterFatBinary(void *fatCubin);

///////////////////
// RPC CALL UTILS//
///////////////////
//int do_cuda_rpc( cuda_packet_t *packet,
//                 void *request_buf,
//                 int request_buf_size,
//                 void *response_buf,
//                 int response_buf_size);

/**
 * executes the cuda call over the network
 * This is the entire protocol of sending and receiving requests.
 * Including data send as arguments, as well as extra responses
 * @param pPacket the packet that contains data to be send and executed over the
 * network
 * @param reqbuf (in) from this buffer data are added to myconn
 * @param reqbuf_size (in) size of the request buffer
 * @param rspbuf (out) we copy here a response we got from the server
 * @param rspbuf_size (out) the size of the response buffer
 *
 * @return OK everything went OK,
 *         ERROR if something went wrong
 */
int l_do_cuda_rpc( cuda_packet_t *pPacket, void *reqbuf,
        const int reqbuf_size,
        void *rspbuf,
        const int rspbuf_size, int index);

// Pager
extern struct mem_map * vmap_table;
extern int * vmap_index;
extern int vmapped_local_arr[MAX_MEMORY];
extern int localindex;

//////////////////////////
// GLOBAL SCHEDULER FUNCTIONS
//////////////////////////

int get_next_device_RR();
int get_next_device();
int get_next_weighted_device();
int get_next_device_local_pref(int localhost_id);
void dec_thread_count_per_device();


//////////////////////////
// CLIENT SIDE FUNCTIONS
// *_rpc means it marshalls the call and sends it to the remote host for execution.
// dom_info argument is void to fit into a jump table along with the functions from
// local_api_wrapper.c
//////////////////////////
int nvbackCudaMalloc_rpc(cuda_packet_t * packet, int index);
int nvbackCudaFree_rpc(cuda_packet_t * packet, int index);
int nvbackCudaGetDeviceCount_rpc(cuda_packet_t *packet, int index);
int nvbackCudaGetDeviceProperties_rpc(cuda_packet_t *packet, int index);
int nvbackCudaGetDevice_rpc(cuda_packet_t * packet, int index);
int nvbackCudaSetDevice_rpc(cuda_packet_t *packet, int index);
int nvbackCudaSetupArgument_rpc(cuda_packet_t * packet, int index);
int nvbackCudaConfigureCall_rpc(cuda_packet_t *packet, int index);
int nvbackCudaLaunch_rpc(cuda_packet_t * packet, int index);
int nvbackCudaMemcpy_rpc(cuda_packet_t *packet, int index);
int nvbackCudaMemcpyToSymbol_rpc(cuda_packet_t * packet, int index);
int nvbackCudaMemcpyFromSymbol_rpc(cuda_packet_t * packet, int index);
int nvbackCudaThreadSynchronize_rpc(cuda_packet_t *packet, int index);
int nvbackCudaThreadExit_rpc(cuda_packet_t *packet, int index);
int __nvback_cudaRegisterFatBinary_rpc(cuda_packet_t *packet, int index);
int __nvback_cudaRegisterFunction_rpc(cuda_packet_t *packet, int index);
int __nvback_cudaUnregisterFatBinary_rpc(cuda_packet_t *packet, int index);
int __nvback_cudaRegisterVar_rpc(cuda_packet_t * packet, int index);

/////////////////////////
// SERVER SIDE CODE
/////////////////////////
int nvbackCudaMalloc_srv(cuda_packet_t * packet, conn_t * pConn);
int nvbackCudaGetDeviceCount_srv(cuda_packet_t * packet, conn_t * pConn);
int nvbackCudaGetDeviceProperties_srv(cuda_packet_t * packet, conn_t *pConn);
int nvbackCudaGetDevice_srv(cuda_packet_t *packet, conn_t * pConn);
int nvbackCudaSetDevice_srv(cuda_packet_t *packet, conn_t * pConn);
int nvbackCudaFree_srv(cuda_packet_t * packet, conn_t * pConn);
int nvbackCudaSetupArgument_srv(cuda_packet_t * packet, conn_t *pConn);
int nvbackCudaConfigureCall_srv(cuda_packet_t *packet, conn_t *pConn);
int nvbackCudaLaunch_srv(cuda_packet_t * packet, conn_t * pConn);
int nvbackCudaMemcpy_srv(cuda_packet_t *packet, conn_t * pConn);
int nvbackCudaMemcpyToSymbol_srv(cuda_packet_t *packet, conn_t * pConn);
int nvbackCudaMemcpyFromSymbol_srv(cuda_packet_t *packet, conn_t * pConn);
int nvbackCudaThreadSynchronize_srv(cuda_packet_t *packet, conn_t * pConn);
int nvbackCudaThreadExit_srv(cuda_packet_t *packet, conn_t * pConn);
int __nvback_cudaRegisterFatBinary_srv(cuda_packet_t *packet, conn_t * myconn);
int __nvback_cudaRegisterFunction_srv(cuda_packet_t *packet, conn_t * myconn);
int __nvback_cudaUnregisterFatBinary_srv(cuda_packet_t *packet, conn_t  * myconn);
int __nvback_cudaRegisterVar_srv(cuda_packet_t * packet, conn_t * myconn);
#endif
