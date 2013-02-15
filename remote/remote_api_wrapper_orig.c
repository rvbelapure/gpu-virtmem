/**
 * @file remote_api_wrapper.c
 * @brief Constants for the network module, copied from
 * remote_gpu/network/remote_api_wrapper.c and
 * edited by me MS to make it more independent
 *
 * @date Feb 25, 2011
 * @author Magda Slawinska, magg@gatech.edu
 */

/*#ifndef _GNU_SOURCE
 #	define _GNU_SOURCE 1
 #endif */

#include "remote_api_wrapper.h"
#include "debug.h"
#include <cuda.h>			// for CUDA_SUCCESS
#include <cuda_runtime_api.h> // for cuda calls, e.g., cudaGetDeviceCount, etc
#include "libciutils.h"
#include "method_id.h"
#include "remote_api_wrapper.h"

#include "remote_packet.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <dlfcn.h>
#include "connection.h"

#include "fatcubininfo.h"   // for fatcubin_info_t
#include "iniparser.h"

// stores the config parameters
#include "config.h"

#include <glib.h>

//! This will be storing the name of the hsot
static char REMOTE_HOSTNAME[HOSTNAME_STRLEN];

//! open the connection forever; if you open and then close the
//! connection the program stops to work, so you have to make it static
static conn_t myconn;

//! the dynamic array for storing info about registered fatcubins
//! this array is stored on the server side
static GArray * fatCInfoArr = NULL;

// the original function we eventually want to invoke
extern void** __cudaRegisterFatBinary(void* fatC);
extern void __cudaRegisterFunction(void** fatCubinHandle, const char* hostFun,
		char* deviceFun, const char* deviceName, int thread_limit, uint3* tid,
		uint3* bid, dim3* bDim, dim3* gDim, int* wSize);
extern void __cudaUnregisterFatBinary(void** fatCubinHandle);
extern void __cudaRegisterVar(void **fatCubinHandle, char *hostVar,
		char *deviceAddress, const char *deviceName, int ext, int vsize,
		int constant, int global);

///////////////////
// RPC CALL UTILS//
///////////////////

/**
 * closes the connection and frees the memory occupied by the connection
 * @param pConn (inout) The connection to be closed; changed to NULL
 * @param exit_code (in) What will be returned
 * @return exit_code indicates if we want this function to indicate the erroneous
 *        behavior or not @see l_do_cuda_rpc
 *
 * @todo check with passing pointers to functions
 */
int l_cleanUpConn(conn_t * pConn, const int exit_code) {
	//	conn_close(pConn);
	//	free(pConn);
	//	pConn = NULL;

	return exit_code;
}

/**
 * Returns the remote host or NULL if the remote host
 */
inline char * l_getRemoteHost(void) {

	dictionary * d;
	char * s;

	d = iniparser_load(KIDRON_INI);
	if (NULL == d) {
		p_error( "Can't parse the config file. Quitting ... ");
	}
	s = iniparser_getstring(d, "network:remote", NULL);

	// complain if the name is to long
	assert(strlen(s) < HOSTNAME_STRLEN - 1);
	strcpy(REMOTE_HOSTNAME, s);
	iniparser_freedict(d);

	p_debug( "%s\n", REMOTE_HOSTNAME);
	return REMOTE_HOSTNAME;
}

/**
 * executes the cuda call over the network
 * This is the entire protocol of sending and receiving requests.
 * Including data send as arguments, as well as extra responses
 *
 * We add the specific packet to the buffer that is maintained by the connection.
 * We also check if there are some requests in the reqbuf and we add this to our
 * connection. Then we send the connection data. TODO here I have problems, since
 * conn_t is a connection, and not the data so it should be called something
 * else (sending_endpoint (?) ).
 * It also deals with response. Since the connection can expect responses. Then
 * the response is passed through packet and rspbuf.
 *
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
int l_do_cuda_rpc(cuda_packet_t *packet, void * reqbuf, const int reqbuf_size,
		void * rspbuf, const int rspbuf_size) {

	strm_hdr_t *pHdr; // declared to help with my connection, will be a pointer
	// to the header in my packet I want to send
	rpkt_t * pRpkts; // declared to help with connections
	size_t rpkt_size = sizeof(rpkt_t);

	p_debug("MethodID: %d, reqbuf %p, reqbuf_size %d, rspbuf %p, rspbuf_size %d\n",
			packet->method_id, reqbuf, reqbuf_size, rspbuf, rspbuf_size);

	// connect if not connected, otherwise reuse the connection
	// if you close and open the connection, the program exits; a kind of
	// singleton
	if (0 == myconn.valid) {
		if (conn_connect(&myconn, l_getRemoteHost()) == -1)
			exit(ERROR);
		p_info( "Connection to host: %s\n", REMOTE_HOSTNAME);
		myconn.valid = 1;
	}

	// for simplicity we use aliases for particular fields of the myconn
	pHdr = &myconn.strm.hdr;
	pRpkts = myconn.strm.rpkts;

	//pRpkts[0].ret_ex_val.data_unit = sizeof(rpkt_t);
	// @todo check since this might be a redundancy since
	// this is set in
	// conn_sendCudaPktHdr(&myconn, 1, reqbuf_size)
	pHdr->num_cuda_pkts = 1;
	pHdr->data_size = reqbuf_size;

	if (reqbuf_size > 0) {
		// @todo I changed the order in this section compared to the original
		// version; this indicates an offset for easy use
		pRpkts[0].ret_ex_val.data_unit = pHdr->data_size;
	} else {
		// this is an offset - to indicate there is no offset at all
		pRpkts[0].ret_ex_val.data_unit = -1;
	}

	if (conn_sendCudaPktHdr(&myconn, 1, reqbuf_size) == ERROR) {
		return l_cleanUpConn(&myconn, ERROR);
	}

	// now we are preparing for sending a cuda packet
	// start with  copying the packet into a contiguous space
	memcpy(&pRpkts[0], packet, rpkt_size);

	// send the packet
	if (1 != put(&myconn, (char *) pRpkts, pHdr->num_cuda_pkts * rpkt_size)) {
		return l_cleanUpConn(&myconn, ERROR);
	}

	// now send the extra request buffer if any
	if (reqbuf_size > 0) {
		assert(reqbuf && reqbuf_size);
		if (1 != put(&myconn, (char*) reqbuf, reqbuf_size)) {
			return l_cleanUpConn(&myconn, ERROR);
		}
		p_debug( "Request buffer sent (%d bytes).\n", reqbuf_size);
	}

	// now check if we have some extra response data, i.e.
	// check if the packet expects the response, i.e.,
	// the decision if we expect the response is hard-coded
	// in strm_expects_response
	if (!strm_expects_response(&myconn.strm)) {
		// apparently this indicates that the strm doesn't expect the response
		//packet->ret_ex_val.err = 0; //@todo it seems to be unnecessary
		return l_cleanUpConn(&myconn, OK);
	}

	// so we are expecting the response; ok now get the response
	memset(pHdr, 0, sizeof(strm_hdr_t));
	memset(pRpkts, 0, MAX_REMOTE_BATCH_SIZE * rpkt_size);

	// recv response header for the batch
	// the header will contain the size of the extra response
	// data if any
	if (1 != get(&myconn, pHdr, sizeof(strm_hdr_t))) {
		return l_cleanUpConn(&myconn, ERROR);
	}

	p_debug("received response header. Expecting %d packets and extra response size of %u in response batch\n",
			pHdr->num_cuda_pkts, pHdr->data_size);

	assert(pHdr->num_cuda_pkts == 1);

	// recv the  batch of the responses
	if (1 != get(&myconn, pRpkts, pHdr->num_cuda_pkts * rpkt_size)) {
		return l_cleanUpConn(&myconn, ERROR);
	}

	p_info("Received response batch. %d packets\n", pHdr->num_cuda_pkts);

	//copy back the received response packet to given request packet
	memcpy(packet, &pRpkts[0], rpkt_size);

	if (packet->method_id == __CUDA_REGISTER_FAT_BINARY) {
		p_debug("FAT CUBIN HANDLE: registered %p.\n", packet->ret_ex_val.handle);
	}

	// check if we need to receive an extra buffer of response
	//if( rsp_strm_has_data(&myconn.strm) ){
	if (pHdr->data_size > 0) {
		assert(rspbuf && rspbuf_size);
		// actually pHdr->data_size should be equal to rspbuf_size
		assert((int) pHdr->data_size <= rspbuf_size );

		// ok, get the data, data will be stored in the rspbuf
		// first receive the header
		if (1 != get(&myconn, rspbuf, (int) pHdr->data_size)) {
			return l_cleanUpConn(&myconn, ERROR);
		}
	}

	// finalize do_cuda_rpc
	memset(pHdr, 0, sizeof(strm_hdr_t));
	memset(pRpkts, 0, MAX_REMOTE_BATCH_SIZE * rpkt_size);

	return l_cleanUpConn(&myconn, OK);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// REMOTE FUNCTIONS (CLIENT)
//
// They should convert dom_info + cpkt -> remote packet stream
//
////////////////////////////////////////////////////////////////////////////////////////////////////
int nvbackCudaGetDeviceCount_rpc(cuda_packet_t *packet) {
	printd(DBG_DEBUG, "CUDA_ERROR=%d before RPC on method %d\n",
			packet->ret_ex_val.err, packet->method_id);
	l_do_cuda_rpc(packet, NULL, 0, NULL, 0);

	return (packet->ret_ex_val.err == 0) ? OK : ERROR;
}

int nvbackCudaGetDeviceProperties_rpc(cuda_packet_t *packet) {
	printd(DBG_DEBUG, "CUDA_ERROR=%d before RPC on method %d\n",
			packet->ret_ex_val.err, packet->method_id);

	// we need to provide a buffer where we will copy the data from
	// cudaDeviceProp structure we will get from the server
	// actually this is in pPacket->args[0].argp
	// packet->args[2].argi-> the size of the buffer required
	// we will interpret the pPacket->args[0].argp as argui (see explanation
	// in cudaGetDeviceProperies in libci.c why
	printd(DBG_DEBUG, "Response Buffer: pointer %p, size %ld\n", (void*)packet->args[0].argui, packet->args[2].argi);
	l_do_cuda_rpc(packet, NULL, 0, (void *) packet->args[0].argui,
			packet->args[2].argi);

	return (packet->ret_ex_val.err == 0) ? OK : ERROR;
}

int nvbackCudaGetDevice_rpc(cuda_packet_t * pPacket) {
	printd(DBG_DEBUG, "CUDA_ERROR=%d before RPC on method %d\n",
			pPacket->ret_ex_val.err, pPacket->method_id);
	l_do_cuda_rpc(pPacket, NULL, 0, NULL, 0);

	return (pPacket->ret_ex_val.err == 0) ? OK : ERROR;
}

int nvbackCudaSetDevice_rpc(cuda_packet_t *packet) {
	p_debug( "CUDA_ERROR=%d before RPC on method %d\n",
			packet->ret_ex_val.err, packet->method_id);

	l_do_cuda_rpc(packet, NULL, 0, NULL, 0);
	// error value in packet->ret_ex_val.err
	// let's assume this is an asynchronous call, don't care about the packet->ret_ex_val.err

	return OK;
}

int nvbackCudaFree_rpc(cuda_packet_t *packet) {

	p_debug( "CUDA_ERROR=%d before RPC on method %d\n",
			packet->ret_ex_val.err, packet->method_id);

	l_do_cuda_rpc(packet, NULL, 0, NULL, 0);
	// asynchronous call; just return the ok
	return OK;
}

int nvbackCudaMalloc_rpc(cuda_packet_t *packet) {

	p_debug( "CUDA_ERROR=%d before RPC on method %d\n",
			packet->ret_ex_val.err, packet->method_id);
	// clear the packet, we are also sending the size of
	// the memory to allocate
	//packet->args[0].argp = NULL;
	l_do_cuda_rpc(packet, NULL, 0, NULL, 0);

	p_debug("%s: devPtr is %p",__FUNCTION__, packet->args[0].argp);

	return (packet->ret_ex_val.err == cudaSuccess) ? OK : ERROR;
}

int nvbackCudaSetupArgument_rpc(cuda_packet_t *packet) {
	printd(DBG_DEBUG, "CUDA_ERROR=%d before RPC on method %d\n",
			packet->ret_ex_val.err, packet->method_id);

	l_do_cuda_rpc(packet, (void *) packet->args[0].argp, packet->args[1].argi,
			NULL, 0);

	// asynchronous call
	return OK;
}

int nvbackCudaConfigureCall_rpc(cuda_packet_t *packet) {
	printd(DBG_DEBUG, "CUDA_ERROR=%d before RPC on method %d\n",
			packet->ret_ex_val.err, packet->method_id);

	l_do_cuda_rpc(packet, NULL, 0, NULL, 0);
	// asynchronous call
	return OK;
}

int nvbackCudaLaunch_rpc(cuda_packet_t * packet) {

	p_debug( "CUDA_ERROR=%d before RPC on method %d\n",
			packet->ret_ex_val.err, packet->method_id);

	l_do_cuda_rpc(packet, NULL, 0, NULL, 0);

	// asynchronous call
	return OK;
}

int nvbackCudaMemcpy_rpc(cuda_packet_t *packet) {

	p_debug( "Packet content: args[0].argp (dst)= %p, args[1].argp (src)= %p\n",
			packet->args[0].argp, packet->args[1].argp);
	p_debug( "args[2].argi=%ld, args[3].argi=%ld\n", packet->args[2].argi, packet->args[3].argi);

	// this is the kind of the original cudaMemcpy
	int64_t kind = packet->args[3].argi;

	switch (packet->args[3].argi) {
	case cudaMemcpyHostToDevice:
		packet->method_id = CUDA_MEMCPY_H2D;
		l_do_cuda_rpc(packet, (void *) packet->args[1].argui,
				packet->args[2].argi, NULL, 0);
		break;
	case cudaMemcpyDeviceToHost:
		packet->method_id = CUDA_MEMCPY_D2H;
		l_do_cuda_rpc(packet, NULL, 0, (void *) packet->args[0].argui,
				packet->args[2].argi);
		break;
	case cudaMemcpyDeviceToDevice:
		packet->method_id = CUDA_MEMCPY_D2D;
		packet->flags &= ~CUDA_Copytype;
		packet->flags &= ~CUDA_Addrshared;
		l_do_cuda_rpc(packet, NULL, 0, NULL, 0);
		break;
	case cudaMemcpyHostToHost:
		p_critical("Not implemented yet\n");
		packet->ret_ex_val.err = cudaErrorInvalidMemcpyDirection;
		break;

	default:
		p_critical( "Unknown memcpy value %ld\n", kind);
		packet->ret_ex_val.err = cudaErrorInvalidMemcpyDirection;
		break;
	}

	return (packet->ret_ex_val.err == cudaSuccess) ? OK : ERROR;
}

int nvbackCudaThreadSynchronize_rpc(cuda_packet_t *packet) {
	p_debug( "CUDA_ERROR=%d before RPC on method %d\n",
			packet->ret_ex_val.err, packet->method_id);

	l_do_cuda_rpc(packet, NULL, 0, NULL, 0);

	return (packet->ret_ex_val.err == 0) ? OK : ERROR;
}

int nvbackCudaThreadExit_rpc(cuda_packet_t * packet) {
	p_debug( "CUDA_ERROR=%d before RPC on method %d\n",
			packet->ret_ex_val.err, packet->method_id);

	l_do_cuda_rpc(packet, NULL, 0, NULL, 0);
	// error value in packet->ret_ex_val.err
	// let's assume this is an asynchronous call, don't care about the packet->ret_ex_val.err

	return OK;
}

int nvbackCudaMemcpyToSymbol_rpc(cuda_packet_t * packet) {
	p_debug( "CUDA_ERROR=%d before RPC on method %d\n",
			packet->ret_ex_val.err, packet->method_id);

	switch ((enum cudaMemcpyKind) packet->args[3].argi) {
	case cudaMemcpyHostToDevice:
		// I believe that sy
		l_do_cuda_rpc(packet, packet->args[1].argp,
				packet->args[2].arr_argi[0], NULL, 0);
		break;
	case cudaMemcpyDeviceToDevice:
		l_do_cuda_rpc(packet, NULL, 0, NULL, 0);
		break;
	default:
		p_critical("Unsupported memcpy direction: %ld\n", packet->args[3].argi);
		return ERROR;
	}

	return (packet->ret_ex_val.err == cudaSuccess) ? OK : ERROR;
}

int nvbackCudaMemcpyFromSymbol_rpc(cuda_packet_t * packet) {
	p_debug("CUDA_ERROR=%d before RPC on method %d\n",
			packet->ret_ex_val.err, packet->method_id);

	switch ((enum cudaMemcpyKind) packet->args[3].argi) {
	case cudaMemcpyDeviceToDevice:
		l_do_cuda_rpc(packet, NULL, 0, NULL, 0);
		break;
	case cudaMemcpyDeviceToHost:
		l_do_cuda_rpc(packet, NULL, 0, packet->args[1].argp,
				packet->args[2].arr_argi[0]);
		break;
	default:
		p_critical("__ERROR__: unsupported memcpy direction: %ld\n", packet->args[3].argi);
		return ERROR;
	}

	return (packet->ret_ex_val.err == cudaSuccess) ? OK : ERROR;
}

int __nvback_cudaRegisterFatBinary_rpc(cuda_packet_t *packet) {
	p_debug("CUDA_ERROR=%u before RPC on method %d\n",
			packet->ret_ex_val.err, packet->method_id);

	p_debug( "pPackedFat, packet->args[0].argp, size = %p, %ld\n",
			packet->args[0].argp, packet->args[1].argi);

	l_do_cuda_rpc(packet, (void *) packet->args[0].argui, packet->args[1].argi,
			NULL, 0);

	return (packet->ret_ex_val.handle != NULL) ? OK : ERROR;
}

int __nvback_cudaRegisterFunction_rpc(cuda_packet_t *packet) {
	p_debug( "CUDA_ERROR=%d before RPC on method %d\n",
			packet->ret_ex_val.err, packet->method_id);
	l_do_cuda_rpc(packet, (void *) packet->args[0].argui, packet->args[1].argi,
			NULL, 0);

	return (packet->ret_ex_val.err == cudaSuccess) ? OK : ERROR;
}

int __nvback_cudaRegisterVar_rpc(cuda_packet_t * packet) {
	p_debug( "CUDA_ERROR=%d before RPC on method %d\n",
			packet->ret_ex_val.err, packet->method_id);
	l_do_cuda_rpc(packet, (void *) packet->args[0].argui, packet->args[1].argi,
			NULL, 0);

	return (packet->ret_ex_val.err == cudaSuccess) ? OK : ERROR;
}

int __nvback_cudaUnregisterFatBinary_rpc(cuda_packet_t *packet) {
	p_debug("CUDA_ERROR=%d before RPC on method %d\n",
			packet->ret_ex_val.err, packet->method_id);
	l_do_cuda_rpc(packet, NULL, 0, NULL, 0);

	// this doesn't get info from the _srv counterpart
	// return (packet->ret_ex_val.err == cudaSuccess) ? OK : ERROR;
	return OK;
}

/////////////////////////
// SERVER SIDE CODE
/////////////////////////

int nvbackCudaGetDeviceCount_srv(cuda_packet_t *packet, conn_t * pConn) {
	int devCount = 0;

	// just call the function
	packet->ret_ex_val.err = cudaGetDeviceCount(&devCount);
	packet->args[0].argi = devCount;

	p_debug("CUDA_ERROR=%d for method id=%d after calling method\n",
			packet->ret_ex_val.err, packet->method_id);
	return OK;
}

int nvbackCudaGetDeviceProperties_srv(cuda_packet_t *packet, conn_t * pConn) {

	struct cudaDeviceProp * prop = NULL;

	pConn->response_data_size = sizeof(struct cudaDeviceProp);
	pConn->pRspBuffer = malloc(pConn->response_data_size);
	if (mallocCheck(pConn->pRspBuffer, __FUNCTION__, NULL) == ERROR) {
		return ERROR;
	}
	prop = (struct cudaDeviceProp *) pConn->pRspBuffer;

	packet->ret_ex_val.err
			= cudaGetDeviceProperties(prop, packet->args[1].argi);

	// I guess you need to pack the change somehow the l_do_cuda_rpc
	// to use and send the response_data_buffer
	p_debug("CUDA_ERROR=%d for method id=%d\n", packet->ret_ex_val.err, packet->method_id);

	return (packet->ret_ex_val.err == 0) ? OK : ERROR;
}

int nvbackCudaGetDevice_srv(cuda_packet_t *packet, conn_t * pConn) {
	int device = 0;

	packet->ret_ex_val.err = cudaGetDevice(&device);
	packet->args[0].argi = device;

	p_debug( "Current assigned device id = %ld\n", packet->args[0].argi );
	p_debug( "CUDA_ERROR=%d for method id=%d after calling method\n",
			packet->ret_ex_val.err, packet->method_id);
	return (packet->ret_ex_val.err == 0) ? OK : ERROR;
}

int nvbackCudaSetDevice_srv(cuda_packet_t *packet, conn_t * pConn) {
	packet->ret_ex_val.err = cudaSetDevice(packet->args[0].argi);

	p_debug("Set device id = %ld\n", packet->args[0].argi );
	p_debug("CUDA_ERROR=%d for method id=%d\n", packet->ret_ex_val.err, packet->method_id);

	return (packet->ret_ex_val.err == 0) ? OK : ERROR;
}

int nvbackCudaMalloc_srv(cuda_packet_t * packet, conn_t * pConn) {
	// @todo valgrind shows that there a memory leak. I will leave it now
	// but I think this is because when we return from cudaMalloc some
	// memory is allocated which can be released after sending a packet
	// the remote part (of course not the part on the device), but
	// a kind of 'host' memory on the remote side. Need to return to this
	// issue later

	printf("\nbefore devPtr %p, *devPtr %p, size %ld\n",
			&(packet->args[0].argp), packet->args[0].argp, packet->args[1].argi);
	packet->args[0].argp = NULL;
	packet->ret_ex_val.err = cudaMalloc((void**)&(packet->args[0].argp),
			packet->args[1].argi);
	printf(" after devPtr is %p, *devPtr %p\n", &(packet->args[0].argp),
			packet->args[0].argp);

	p_debug("devPtr is %p",packet->args[0].argp);

	p_debug( "CUDA_ERROR=%d for method id=%d after execution\n",
			packet->ret_ex_val.err, packet->method_id);

	return (packet->ret_ex_val.err == cudaSuccess) ? OK : ERROR;
}

int nvbackCudaFree_srv(cuda_packet_t *packet, conn_t *pConn) {
	p_debug("devPtr is %p\n",packet->args[0].argp);
	packet->ret_ex_val.err = cudaFree(packet->args[0].argp);
	p_debug("CUDA_ERROR=%d for method id=%d\n", packet->ret_ex_val.err, packet->method_id);
	return (packet->ret_ex_val.err == 0) ? OK : ERROR;
}

int nvbackCudaSetupArgument_srv(cuda_packet_t *packet, conn_t *pConn) {
	// this packet->ret_ex_val.data_unit is the offset used in batching
	// to put data and offset of the data to the request_data_buffer
	// but since we do not use batching it doesn't make no sense here
	// and may contribute to some bugs
	//void *arg = (void*) ((char *)pConn->request_data_buffer + packet->ret_ex_val.data_unit);
	void *arg = (void*) ((char *) pConn->pReqBuffer);
	packet->ret_ex_val.err = cudaSetupArgument(arg, packet->args[1].argi,
			packet->args[2].argi);
	p_debug("CUDA_ERROR=%d for method id=%d\n", packet->ret_ex_val.err, packet->method_id);
	return (packet->ret_ex_val.err == cudaSuccess) ? OK : ERROR;
}

int nvbackCudaConfigureCall_srv(cuda_packet_t *packet, conn_t *pConn) {
	packet->ret_ex_val.err = cudaConfigureCall(packet->args[0].arg_dim,
			packet->args[1].arg_dim, packet->args[2].argi,
			(cudaStream_t) packet->args[3].argi);

	p_debug(
			"After: gridDim(x,y,z)=%u, %u, %u; blockDim(x,y,z)=%u, %u, %u; sharedMem (size) = %ld; stream =%ld\n",
			packet->args[0].arg_dim.x, packet->args[0].arg_dim.y,
			packet->args[0].arg_dim.z, packet->args[1].arg_dim.x,
			packet->args[1].arg_dim.y, packet->args[1].arg_dim.z,
			packet->args[2].argi, packet->args[3].argi);

	p_debug("CUDA_ERROR=%d for method id=%d\n", packet->ret_ex_val.err, packet->method_id);
	return (packet->ret_ex_val.err == cudaSuccess) ? OK : ERROR;
}

int nvbackCudaLaunch_srv(cuda_packet_t * packet, conn_t * pConn) {
	unsigned int i;
	int j;
	const char *arg;
	int found = 0;

	// this is entry for the cudaLaunch
	arg = (const char *) packet->args[0].argcp;

	packet->ret_ex_val.err = cudaErrorLaunchFailure;

	// in the CUDA Runtime API, globals in two modules must not have the same name
	// I guess the same applies to functions; that's why I am implementing this
	// as there function names are unique across .cu or .ptx modules

	for (i = 0; i < fatCInfoArr->len; i++) {
		fatcubin_info_t * p = &g_array_index(fatCInfoArr, fatcubin_info_t, i);
		assert( p != NULL );
		// now iterate per chosen fatcubin registered structure
		for (j = 0; j < p->num_reg_fns; j++) {
			if (p->reg_fns[j] != NULL && p->reg_fns[j]->hostFEaddr == arg) {
				p_debug( "function %p:%s\n",
						p->reg_fns[j]->hostFEaddr,
						p->reg_fns[j]->hostFun);
				packet->ret_ex_val.err = cudaLaunch(p->reg_fns[j]->hostFun);
				found = 1;
				break;
			}
		}
		if (found == 1)
			break;
	}

	p_debug("CUDA_ERROR=%d for method id=%d\n", packet->ret_ex_val.err, packet->method_id);

	return (packet->ret_ex_val.err == cudaSuccess) ? OK : ERROR;
}

int nvbackCudaMemcpy_srv(cuda_packet_t *packet, conn_t * pConn) {
	p_debug( "Packet content: args[0].argp (dst)= %p, args[1].argp (src)= %p\n",
			packet->args[0].argp, packet->args[1].argp);
	p_debug( "args[2].argi=%ld, args[3].argi=%ld\n", packet->args[2].argi, packet->args[3].argi);

	switch (packet->method_id) {
	//case cudaMemcpyHostToHost:
	case CUDA_MEMCPY_H2H:
		// TODO: Should remote GPU handle this? - good question
		p_warn( "Warning: CUDA_MEMCPY_H2H not supported\n");
		return ERROR;
		//case cudaMemcpyHostToDevice:
	case CUDA_MEMCPY_H2D:
		p_debug("request_data_size = %d, received count =%ld\n",
				pConn->request_data_size, packet->args[2].argi);
		assert(pConn->request_data_size == packet->args[2].argi);
		// originally this packet->ret_ex_val.data_unit is 30
		//packet->args[1].argui = (uint64_t)((char *)myconn->request_data_buffer + packet->ret_ex_val.data_unit);
		packet->args[1].argui = (uint64_t) ((char *) pConn->pReqBuffer);

		// @todo to remove after implementation of cudaMemcpyTo/From Symbol
		//		assert( cudaGetSymbolAddress(&packet->args[0].argui,  "tab_d") == cudaSuccess);

		break;
		//case cudaMemcpyDeviceToHost:
	case CUDA_MEMCPY_D2H:
		pConn->response_data_size = packet->args[2].argi;
		assert(pConn->pRspBuffer == NULL);
		pConn->pRspBuffer = malloc(pConn->response_data_size);
		if (mallocCheck(pConn->pRspBuffer, __FUNCTION__, NULL) == ERROR) {
			return ERROR;
		}
		packet->args[0].argui = (uint64_t) pConn->pRspBuffer;
		// @todo to remove after implementation of cudaMemcpyTo/From Symbol
		//assert( cudaGetSymbolAddress(&packet->args[1].argui,  "tab_d") == cudaSuccess);

		//memset(myconn->response_data_buffer, 0, TOTAL_XFER_MAX);
		break;
		//case cudaMemcpyDeviceToHost:
	case CUDA_MEMCPY_D2D:
		// both src and dst addresses on device. nothing to modify
		break;
	}

	packet->ret_ex_val.err = cudaMemcpy((void *) packet->args[0].argui,
			(void *) packet->args[1].argui, packet->args[2].argi,
			packet->args[3].argi);

	p_info( "CUDA_ERROR=%d (%s) for method id=%d\n", packet->ret_ex_val.err,
			cudaGetErrorString(packet->ret_ex_val.err), packet->method_id);

	return (packet->ret_ex_val.err == cudaSuccess) ? OK : ERROR;
}

int nvbackCudaThreadSynchronize_srv(cuda_packet_t *packet, conn_t * pConn) {
	packet->ret_ex_val.err = cudaThreadSynchronize();

	p_info( "CUDA_ERROR=%d (%s) for method id=%d\n", packet->ret_ex_val.err,
			cudaGetErrorString(packet->ret_ex_val.err), packet->method_id);

	return (packet->ret_ex_val.err == cudaSuccess) ? OK : ERROR;
}

int nvbackCudaThreadExit_srv(cuda_packet_t *packet, conn_t * pConn) {
	packet->ret_ex_val.err = cudaThreadExit();

	p_info( "CUDA_ERROR=%d (%s) for method id=%d\n", packet->ret_ex_val.err,
			cudaGetErrorString(packet->ret_ex_val.err), packet->method_id);

	return (packet->ret_ex_val.err == cudaSuccess) ? OK : ERROR;
}

int nvbackCudaMemcpyToSymbol_srv(cuda_packet_t *packet, conn_t * pConn) {
	// this will hold original hostVar obtained from the client
	const char * hostVar = (const char *) packet->args[0].argcp; // symbol

	switch ((enum cudaMemcpyKind) packet->args[3].argi) {
	case cudaMemcpyHostToDevice:
		p_debug("pconn->request_data_size = %d, packet->count = %ld\n", pConn->request_data_size,
				packet->args[2].arr_argi[0]);

		assert((unsigned int)pConn->request_data_size == packet->args[2].arr_argi[0]);

		packet->args[1].argui = (uint64_t) ((char *) pConn->pReqBuffer);
		break;

	case cudaMemcpyDeviceToDevice:
		packet->ret_ex_val.err = cudaErrorNotYetImplemented;
		p_critical("__ERROR__: cudaMemcpyDeviceToDevice not supported\n");
		p_info( "CUDA_ERROR=%d (%s) for method id=%d\n", packet->ret_ex_val.err,
				cudaGetErrorString(packet->ret_ex_val.err), packet->method_id);
		return ERROR;

	default:
		packet->ret_ex_val.err = cudaErrorInvalidMemcpyDirection;
		p_critical("__ERROR__: Invalid Memcpy direction\n");
		p_info( "CUDA_ERROR=%d (%s) for method id=%d\n", packet->ret_ex_val.err,
				cudaGetErrorString(packet->ret_ex_val.err), packet->method_id);
		return ERROR;
	}

	// now find the symbol in the server space (based on what you have got
	// from the client
	int idx = 0;
	fatcubin_info_t * p = g_fcia_host_var(fatCInfoArr, (char*) hostVar, &idx);

	if (nullDebugChkpt(p, __FUNCTION__, "The hostVar has not been found\n")
			== TRUE) {
		packet->ret_ex_val.err = cudaErrorInvalidSymbol;
	} else {
		assert(idx > -1);
		assert(idx < MAX_REGISTERED_VARS);

		// @todo this cudaGetSymbolAddress seems not to work
		//assert( cudaGetSymbolAddress(&symbol,
		//		p->variables[idx]->deviceAddress) == cudaSuccess);

		// finally call the function; if you want to call the symbol as
		// a deviceName it wreaks havoc with looking up the names if used many
		// .cu modules, specifically, 'duplicate global variable looked up by
		// a string name'
		packet->ret_ex_val.err = cudaMemcpyToSymbol(
				p->variables[idx]->dom0HostAddr, // symbol
				//p->variables[idx]->deviceName, 	// symbol
				(void *) packet->args[1].argui, // src
				packet->args[2].arr_argi[0], // count
				packet->args[2].arr_argi[1], // offset
				packet->args[3].argi); // kind
	}

	p_info( "CUDA_ERROR=%d (%s) for method id=%d\n", packet->ret_ex_val.err,
			cudaGetErrorString(packet->ret_ex_val.err), packet->method_id);

	return packet->ret_ex_val.err == cudaSuccess ? OK : ERROR;
}

int nvbackCudaMemcpyFromSymbol_srv(cuda_packet_t *packet, conn_t * pConn) {
	// this will hold original hostVar obtained from the client
	const char * hostVar = (const char *) packet->args[0].argcp;

	switch ((enum cudaMemcpyKind) packet->args[3].argi) {
	case cudaMemcpyDeviceToHost:
		pConn->response_data_size = packet->args[2].arr_argi[0];
		assert(pConn->pRspBuffer == NULL);
		pConn->pRspBuffer = malloc(pConn->response_data_size);
		if (mallocCheck(pConn->pRspBuffer, __FUNCTION__, NULL) == ERROR) {
			return ERROR;
		}
		packet->args[1].argui = (uint64_t) pConn->pRspBuffer;
		break;

	case cudaMemcpyDeviceToDevice:
		packet->ret_ex_val.err = cudaErrorNotYetImplemented;
		p_critical("__ERROR__: cudaMemcpyDeviceToDevice not supported\n");
		p_info( "CUDA_ERROR=%d (%s) for method id=%d\n", packet->ret_ex_val.err,
				cudaGetErrorString(packet->ret_ex_val.err), packet->method_id);
		return ERROR;

	default:
		packet->ret_ex_val.err = cudaErrorInvalidMemcpyDirection;
		p_critical("__ERROR__: Invalid Memcpy direction\n");
		p_info( "CUDA_ERROR=%d (%s) for method id=%d\n", packet->ret_ex_val.err,
				cudaGetErrorString(packet->ret_ex_val.err), packet->method_id);
		return ERROR;
	}

	// now find the symbol in the server space (based on what you have got
	// from the client
	int idx = 0;
	fatcubin_info_t * p = g_fcia_host_var(fatCInfoArr, (char*) hostVar, &idx);

	if (nullDebugChkpt(p, __FUNCTION__, "The hostVar has not been found\n")
			== TRUE) {
		packet->ret_ex_val.err = cudaErrorInvalidSymbol;
	} else {
		assert(idx > -1);
		assert(idx < MAX_REGISTERED_VARS);

		// finally call the function; if you want to call the symbol as
		// a deviceName it wreaks havoc with looking up the names if used many
		// .cu modules, specifically, 'duplicate global variable looked up by
		// a string name'
		packet->ret_ex_val.err = cudaMemcpyFromSymbol(
				(void *) packet->args[1].argui, // dst
				//p->variables[idx]->deviceName, // symbol
				p->variables[idx]->dom0HostAddr, // symbol
				packet->args[2].arr_argi[0], // count
				packet->args[2].arr_argi[1], // offset
				packet->args[3].argi); // kind
	}

	p_info( "CUDA_ERROR=%d (%s) for method id=%d\n", packet->ret_ex_val.err,
			cudaGetErrorString(packet->ret_ex_val.err), packet->method_id);

	return packet->ret_ex_val.err == cudaSuccess ? OK : ERROR;
}

/**
 * in this function we do not return in the handle the
 * packet->ret_ex_val.err is not set I believe as
 * in most of the other calls so take this into account
 */
int __nvback_cudaRegisterFatBinary_srv(cuda_packet_t *packet, conn_t * myconn) {

	// this will held the new structure for fatcubin_info_srv
	fatcubin_info_t * pFatCInfo = NULL;

	// NULL value indicates that we need to create an array of cudaRegisterFatBinaries
	// it is because each .cu file has a register fat binary
	if (NULL == fatCInfoArr)
		// NULL value indicates that this is the first fat binary to be registered
		// clear all values to 0
		fatCInfoArr = g_array_new(FALSE, TRUE, sizeof(fatcubin_info_t));

	// clear all values to 0
	pFatCInfo = (fatcubin_info_t*) calloc(1, sizeof(fatcubin_info_t));

	nullExitChkptMalloc(pFatCInfo, (char*) __FUNCTION__);

	pFatCInfo->fatCubin = (__cudaFatCudaBinary *) malloc(
			sizeof(__cudaFatCudaBinary ));

	if (mallocCheck(pFatCInfo->fatCubin, __FUNCTION__, NULL) == ERROR)
		exit(ERROR);

	if (unpackFatBinary(pFatCInfo->fatCubin, myconn->pReqBuffer) == ERROR) {
		p_error("Problems with unpacking fat binary. Exiting ... \n");
	} else {
		p_debug( "__OK__ No problem with unpacking fat binary\n");
		//l_printFatBinary(pFatCInfo->fatCubin);
	}

	// start to build the structure
	pFatCInfo->fatCubinHandle = __cudaRegisterFatBinary(pFatCInfo->fatCubin);

	// remember, this macro requires appending value (not a pointer to a value)
	// the second thing you need to remember, it looks that the place
	// where you put this call can make a difference, since it looks as
	// it makes a copy of that value, so if you do not have the right thing
	// you are
	g_array_append_val(fatCInfoArr, *pFatCInfo);

	packet->args[1].argp = pFatCInfo->fatCubin;
	packet->ret_ex_val.handle = pFatCInfo->fatCubinHandle;

	p_debug( "FATCUBIN HANDLE: registered %p\n", pFatCInfo->fatCubinHandle);
	p_debug( "FATCUBIN: registered %p\n", pFatCInfo->fatCubin);
	return OK;
}

int __nvback_cudaRegisterFunction_srv(cuda_packet_t *packet, conn_t * myconn) {
	reg_func_args_t * pA = malloc(sizeof(reg_func_args_t));
	fatcubin_info_t * pFcI = NULL;

	nullExitChkptMalloc((void*) pA, (char*) __FUNCTION__);

	if (unpackRegFuncArgs(pA, myconn->pReqBuffer) == ERROR)
		p_warn("Problems with unpacking arguments in function register\n");

	printFatCIArray(fatCInfoArr);

	// find the fatCubinHandle in our array
	pFcI = g_fcia_elem(fatCInfoArr, pA->fatCubinHandle);

	if (NULL == pFcI) {
		p_warn("__ERROR__: Not such fat cubin handler %p\n", pA->fatCubinHandle);
	}

	p_debug("FATCUBIN HANDLE: received=%p, found=%p", pA->fatCubinHandle, pFcI->fatCubinHandle);

	assert(pA->fatCubinHandle == pFcI->fatCubinHandle);

	l_printRegFunArgs(pA->fatCubinHandle, (const char *) pA->hostFun,
			pA->deviceFun, (const char *) pA->deviceName, pA->thread_limit,
			pA->tid, pA->bid, pA->bDim, pA->gDim, pA->wSize);

	__cudaRegisterFunction(pA->fatCubinHandle, (const char *) pA->hostFun,
			pA->deviceFun, (const char *) pA->deviceName, pA->thread_limit,
			pA->tid, pA->bid, pA->bDim, pA->gDim, pA->wSize);

	// warn us if we want to write outbounds; fatcubin_info_srv.num_reg_fns
	// should indicate the first free slot you can write in an array
	assert(pFcI->num_reg_fns < MAX_REGISTERED_FUNCS);
	pFcI->reg_fns[pFcI->num_reg_fns] = pA;
	pFcI->num_reg_fns++;

	packet->ret_ex_val.err = cudaSuccess;
	p_debug( "CUDA_ERROR=%u for method id=%d\n", packet->ret_ex_val.err, packet->method_id);
    
    int* x=NULL;
    cudaMalloc((void**)&x, 8);
    printf("RANDOM CUDAMALLOC: %d\n", x);

	return OK;
}

int __nvback_cudaRegisterVar_srv(cuda_packet_t * packet, conn_t * myconn) {
	reg_var_args_t * pA = (reg_var_args_t *) malloc(sizeof(reg_var_args_t));
	fatcubin_info_t * pFcI = NULL;

	nullExitChkptMalloc((void*) pA, (char*) __FUNCTION__);

	if (unpackRegVar(pA, myconn->pReqBuffer) == ERROR)
		p_error("Problems with unpacking arguments in function register. Exiting ...\n");

	// find the fatCubinHandle in our array
	pFcI = g_fcia_elem(fatCInfoArr, pA->fatCubinHandle);
	p_debug("num_reg_vars: %d\n", pFcI->num_reg_vars);

	if (NULL == pFcI)
		p_error("Not such fat cubin handler. Exiting %p\n", pA->fatCubinHandle);

	p_debug("FATCUBIN HANDLE: received=%p, found=%p\n",
			pA->fatCubinHandle, pFcI->fatCubinHandle);

	assert(pA->fatCubinHandle == pFcI->fatCubinHandle);

	l_printRegVar(pA->fatCubinHandle, pA->hostVar, pA->deviceAddress,
			(const char *) pA->deviceName, pA->ext, pA->size, pA->constant,
			pA->global);

	p_debug("pA->dom0HostAddr before = %p\n", pA->dom0HostAddr);
	__cudaRegisterVar(pA->fatCubinHandle, pA->dom0HostAddr, pA->deviceAddress,
			(const char *) pA->deviceName, pA->ext, pA->size, pA->constant,
			pA->global);
	p_debug("pA->hostVar after __cudaRegisterVar: pointer = %p\n",
			pA->dom0HostAddr);

	// warn us if we want to write outbounds; fatcubin_info_srv.num_reg_fns
	// should indicate the first free slot you can write in an array
	assert(pFcI->num_reg_vars < MAX_REGISTERED_VARS);
	pFcI->variables[pFcI->num_reg_vars] = pA;
	pFcI->num_reg_vars++;

	packet->ret_ex_val.err = cudaSuccess;
	p_debug("CUDA_ERROR=%u for method id=%d\n", packet->ret_ex_val.err,
			packet->method_id);

	return OK;
}

int __nvback_cudaUnregisterFatBinary_srv(cuda_packet_t *packet, conn_t * pConn) {

	// get the handle
	void ** pFCHandle = packet->args[0].argdp;
	// will hold the pointer to the fatcubin_info_t from the array
	fatcubin_info_t * pFCI;
	int pFCIdx;

	printFatCIArray(fatCInfoArr);
	p_debug( "The FAT cubin handle we've got: %p\n", pFCHandle);

	// find the handle in our table and an index
	pFCI = g_fcia_elidx(fatCInfoArr, pFCHandle, &pFCIdx);
	assert(pFCI != NULL);

	__cudaUnregisterFatBinary(pFCHandle);

	cleanFatCubinInfo(pFCI);

	// and remove it from our array
	g_array_remove_index_fast(fatCInfoArr, pFCIdx);

	packet->ret_ex_val.err = cudaSuccess;
	p_debug("CUDA_ERROR=%u for method id=%d\n", packet->ret_ex_val.err, packet->method_id);

	return OK;
}
