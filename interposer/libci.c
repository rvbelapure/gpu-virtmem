/**
 * @file libci.c
 *
 * @date Feb 27, 2011
 * @author Magda Slawinska, magg@gatech.edu

 * @brief Interposes the cuda calls and prints arguments of the call. It supports
 * the 3.2 CUDA Toolkit, specifically
 *   CUDA Runtime API Version 3.2
 *   #define CUDART_VERSION  3020
 *
 * To prepare the file I processed the /opt/cuda/include/cuda_runtime_api_no_comments.h
 * and removed the comments. I also removed CUDARTAPI and __host__ modifiers.
 * Then I have a list of function signatures that I need to interpose.
 * You can see the script in cuda_rt_api.
 *
 * 2011-02-09 It looks that  in my library currently is  95 calls plus 6 calls undocumented.
 * @todo Write a script that checks if the number or api are identical in cuda_runtime_api.h
 * and in our file.
 *
 *
 * @todo There is one thing: the prototypes or signatures of CUDA functions
 * have modifiers CUDARTAPI which is __stdcall and __host__ which is
 * __location__(host) as defined in file /opt/cuda/include/host_defines.h
 * The question is if this has any impact on the interposed calls. I guess not.
 * But I might be wrong.
 *
 * To use that library you can do
 * [magg@prost release]$ LD_PRELOAD=/home/magg/libs/libci.so ./deviceQuery
 *
 * The library interposes calls and delegates the execution to the other machine
 */

// if this file is .c, if you do not define _GNU_SOURCE then it complains
// that RTLD_NEXT is undeclared
// if this file is  .cpp, then you get warning "_GNU_SOURCE" redefined
#define _GNU_SOURCE

#include <stdio.h>
#include <driver_types.h>

// /opt/cuda/include for uint3
#include <vector_types.h>
#include <string.h>
#include <stdlib.h>
#include <dlfcn.h>

#include <cuda.h>		// for CUDA_SUCCESS
#include <__cudaFatFormat.h>  // for __cudaFatCudaBinary
#include "packetheader.h" 	// for cuda_packet_t
#include "debug.h"			// printd, ERROR, OK
#include <pthread.h>		// pthread_self()
#include "method_id.h"		// method identifiers
#include "remote_api_wrapper.h" // for nvback....rpc/srv functions
#include "connection.h"
#include "libciutils.h"
#include "../l2scheduler/sched_commons.h"
#include <assert.h>

#include <glib.h>		// for GHashTable

#define DEVICES_PER_NODE 2

//! to indicate the error with the dynamic loaded library
static cudaError_t cudaErrorDL = cudaErrorUnknown;

//! Maintain the last error for cudaGetLastError()
static cudaError_t cuda_err = 0;


#define HOSTNAME_STRLEN 256
#define MAX_BACKEND_NODES 100
#define MAX_BACKEND_DEVICES 1000
#define MAX_FATCUBIN_HANDLES 1000

#define MAX_REGISTERED_VARS 10

extern char BACKEND_LIST[MAX_BACKEND_NODES+1][HOSTNAME_STRLEN];
// \todo Clean it up later. Just need to make sure MemcpySymbol does jazz
// only when a variable has been registered
//char *reg_host_vars[MAX_REGISTERED_VARS];
//static int num_registered_vars = 0;

//! stores information about the fatcubin_info on the client side
//static fatcubin_info_t fatcubin_info_rpc;

//! the dynamic hashtable for storing info about registered vars
//! this array is stored on the client side
//! as key it stores the fatCubinHandles and the values are the arrays of
//! pointers to the hostVariables (hostVars)
static GHashTable * regHostVarsTab = NULL;

static int LOCAL_EXEC=1;  // by default local
int DEVICES_IN_NODE[MAX_BACKEND_NODES];

extern pthread_key_t tlsKey2;
extern int DONE;
extern int first_node;

//static __thread int CUR_DEV=0;
extern int BACKEND_NODES;
extern int BACKEND_DEVICES;
extern int DEV_TO_INDEX[MAX_BACKEND_DEVICES];
extern int DEV_TO_LOCALDEV[MAX_BACKEND_DEVICES];
int CUMMULATIVE_FREQ_DEV[MAX_BACKEND_DEVICES+1];
int first_local; 

static void** fatcubinhandle_array[MAX_FATCUBIN_HANDLES][MAX_BACKEND_NODES];
int fatcubin_handle_counter=0;

cudaError_t rcudaGetDevice(int *, int, int);


/**
 * @brief Handles errors caused by dlsym()
 * @return true no error - everything ok, otherwise the false
 */
int l_handleDlError() {
	char * error; // handles error description
	int ret = OK; // return value

	if ((error = dlerror()) != NULL) {
		printf("%s.%d: %s\n", __FUNCTION__, __LINE__, error);
		ret = ERROR;
	}

	return ret;
}

/**
 * Prints function signature
 * @param pSignature The string describing the function signature
 * @return always true
 */
int l_printFuncSig(const char* pSignature) {
	printf(">>>>>>>>>> %s\n", pSignature);
	//std::cout << ">>>>>>>>>> " << pSignature << std::endl;
	return OK;
}
/**
 * Prints function signature; should be used for the
 * implemented functions
 * @param pSignature The string describing the function signature
 * @return always true
 */
int l_printFuncSigImpl(const char* pSignature) {
	printf(">>>>>>>>>> Implemented >>>>>>>>>>: %s\n", pSignature);
	//std::cout << ">>>>>>>>>> " << pSignature << std::endl;
	return OK;
}
/**
 * sets the method_id, thr_id, flags in the packet structure to default values
 * @param pPacket The packet to be changed
 * @param methodId The method id you want to set
 *
 */
int l_setMetThrReq(cuda_packet_t ** const pPacket, const uint16_t methodId){
	(*pPacket)->method_id = methodId;
	(*pPacket)->thr_id = pthread_self();
	(*pPacket)->flags = CUDA_request;
	(*pPacket)->ret_ex_val.err = cudaErrorUnknown;

	return OK;
}

/**
 * sets the method_id, thr_id, flags in the packet structure to default values
 * @param pPacket The packet to be changed
 * @param methodId The method id you want to set
 * @param pSignature The string describing the function signature
 * @return OK everything is fine
 *         ERROR there is a problem with memory and cuda error contains
 *         the error; if calloc gave NULL
 */

int l_remoteInitMetThrReq(cuda_packet_t ** const pPacket,
		const uint16_t methodId, const char* pSignature){
	printf(">>>>>>>>>> Implemented >>>>>>>>>>: %s (id = %d)\n", pSignature, methodId);

	// Now make a packet and send
	if ((*pPacket = callocCudaPacket(pSignature, &cuda_err)) == NULL) {
		return ERROR;
	}

	(*pPacket)->method_id = methodId;
	(*pPacket)->thr_id = pthread_self();
	(*pPacket)->flags = CUDA_request;
	(*pPacket)->ret_ex_val.err = cudaErrorUnknown;

	return OK;
}

//! This appears in some values of arguments. I took this from /opt/cuda/include/cuda_runtime_api.h
//! It looks as this comes from a default value (dv)
#if !defined(__dv)
#	if defined(__cplusplus)
#		define __dv(v) \
        		= v
#	else
#		define __dv(v)
#	endif
#endif


// -------------------------------------------------------
//
// -------------------------------------------------------
cudaError_t rcudaThreadExit(int index) {
	cuda_packet_t * pPacket;

	if (l_remoteInitMetThrReq(&pPacket, CUDA_THREAD_EXIT, __FUNCTION__)
			== ERROR) {
		return cuda_err;
	}

	//pPacket->args[0].argi = device_id;
    	//index = 0;
	// send the packet
	if (nvbackCudaThreadExit_rpc(pPacket, index) == OK) {
		p_info("__OK__ (asynchronous)\n");
		cuda_err = pPacket->ret_ex_val.err;
		#ifdef L2_FEEDBACK_ENABLED
		if(pPacket->is_feedback_packet == 1) {
		/* We have L2 feedback data in packet. Now send it to global sched via cudaGetDevice*/
			cuda_packet_t * feedbackPacket;

			if (l_remoteInitMetThrReq(&feedbackPacket, CUDA_GET_DEVICE, "rcudaGetDevice") == ERROR) {
				return cuda_err;
			}

			feedbackPacket->is_feedback_packet = 1;
			feedbackPacket->node = pPacket->node;
			feedbackPacket->devid = pPacket->devid;
			feedbackPacket->app_type = pPacket->app_type;
			feedbackPacket->total_ex_time = pPacket->total_ex_time;
			feedbackPacket->sys_time = pPacket->sys_time;
			feedbackPacket->usr_time = pPacket->usr_time;
			feedbackPacket->cuda_kernel_launches = pPacket->cuda_kernel_launches;
			feedbackPacket->kernel_time = pPacket->kernel_time;
			feedbackPacket->non_kernel_time = pPacket->non_kernel_time;

			// send the packet
			if (nvbackCudaGetDevice_rpc(feedbackPacket, MAX_BACKEND_NODES) == OK) {
				p_info("L2FEEDBACK : Data sent to Global Sched\n");
				// remember the count number what we get from the remote device
			} else {
				p_warn( "L2FEEDBACK : __ERROR__ Return from rpc with the wrong return value.\n");
			}
			free(feedbackPacket);
		}
		#endif
	} else {
		p_warn("__ERROR__ Return from asynchronous rpc with the wrong return value.\n");
		cuda_err = cudaErrorUnknown;
	}

	free(pPacket);

	return cuda_err;

}

cudaError_t lcudaThreadExit(void) {
	typedef cudaError_t (* pFuncType)(void);
	l_printFuncSigImpl(__FUNCTION__);

	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaThreadExit");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	return (pFunc());
}

/*
cudaError_t cudaThreadExit(void) {

	return ((LOCAL_EXEC == 1) ? lcudaThreadExit() : rcudaThreadExit());
}
*/

cudaError_t cudaThreadExit(void) {
    cudaError_t ret;
    int* CUR_DEV;
    if(!(CUR_DEV=pthread_getspecific(tlsKey2))) {
        CUR_DEV= calloc(1, sizeof(int));
        pthread_setspecific(tlsKey2, CUR_DEV);
    }
    //if(CUR_DEV<DEVICES_PER_NODE)
        //ret = lcudaThreadExit();
    //else
        ret = rcudaThreadExit(DEV_TO_INDEX[*CUR_DEV]);
    return(ret);
}


cudaError_t rcudaThreadSynchronize(int index){
	cuda_packet_t * pPacket;

	if( l_remoteInitMetThrReq(&pPacket, CUDA_THREAD_SYNCHRONIZE, __FUNCTION__) == ERROR){
		return cuda_err;
	}

	// send the packet
	if(nvbackCudaThreadSynchronize_rpc(pPacket, index) == OK ){
		p_info( "__OK__ ; return from RPC \n");
		cuda_err = pPacket->ret_ex_val.err;
	} else {
		p_warn("__ERROR__ Return from rpc with the wrong return value.\n");
		cuda_err = cudaErrorUnknown;
	}

	free(pPacket);

	return cuda_err;
}

cudaError_t lcudaThreadSynchronize(void) {
	typedef cudaError_t (* pFuncType)(void);
	static pFuncType pFunc = NULL;

	l_printFuncSigImpl(__FUNCTION__);

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaThreadSynchronize");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	return (pFunc());
}

/*
cudaError_t cudaThreadSynchronize(void) {

	return ((LOCAL_EXEC == 1) ? lcudaThreadSynchronize() : rcudaThreadSynchronize());
}
*/

cudaError_t cudaThreadSynchronize(void) {
    cudaError_t ret;
    int* CUR_DEV;
    if(!(CUR_DEV=pthread_getspecific(tlsKey2))) {
        CUR_DEV=calloc(1, sizeof(int));
        pthread_setspecific(tlsKey2, CUR_DEV);
    }
    //if(CUR_DEV<DEVICES_PER_NODE)
        //ret = lcudaThreadSynchronize();
    //else
        ret = rcudaThreadSynchronize(DEV_TO_INDEX[*CUR_DEV]);
    return(ret);
}

cudaError_t cudaThreadSetLimit(enum cudaLimit limit, size_t value) {
	typedef cudaError_t (* pFuncType)(enum cudaLimit limit, size_t value);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaThreadSetLimit");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(limit, value));
}

cudaError_t cudaThreadGetLimit(size_t *pValue, enum cudaLimit limit) {
	typedef cudaError_t (* pFuncType)(size_t *pValue, enum cudaLimit limit);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaThreadGetLimit");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(pValue, limit));
}

cudaError_t cudaThreadGetCacheConfig(enum cudaFuncCache *pCacheConfig) {
	typedef cudaError_t (* pFuncType)(enum cudaFuncCache *pCacheConfig);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaThreadGetCacheConfig");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(pCacheConfig));
}
cudaError_t cudaThreadSetCacheConfig(enum cudaFuncCache cacheConfig) {
	typedef cudaError_t (* pFuncType)(enum cudaFuncCache cacheConfig);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaThreadSetCacheConfig");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(cacheConfig));
}
// -------------------------------------------
cudaError_t rcudaGetLastError(void) {
	p_debug(">>>>>>>>>> Implemented >>>>>>>>>>: %s (no id)\n", __FUNCTION__);

	return cuda_err;
}

cudaError_t lcudaGetLastError(void) {
	typedef cudaError_t (* pFuncType)(void);
		static pFuncType pFunc = NULL;

	l_printFuncSigImpl(__FUNCTION__);

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaGetLastError");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	return (pFunc());
}

/*
cudaError_t cudaGetLastError(void) {
	return ((LOCAL_EXEC == 1) ? lcudaGetLastError() : rcudaGetLastError());
}
*/

cudaError_t cudaGetLastError(void) {
    cudaError_t ret;
    //if(CUR_DEV<DEVICES_PER_NODE)
        //ret = lcudaGetLastError();
    //else 
        ret = rcudaGetLastError();
    return(ret);
}

cudaError_t cudaPeekAtLastError(void) {
	typedef cudaError_t (* pFuncType)(void);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaPeekAtLastError");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc());
}
const char* cudaGetErrorString(cudaError_t error) {
	typedef const char* (* pFuncType)(cudaError_t error);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaGetErrorString");

		if (l_handleDlError() != 0)
			return "DL error";
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(error));
}
// ----------------------------------

cudaError_t rcudaGetDeviceCount(int *count, int index) {
	cuda_packet_t * pPacket;

	if (l_remoteInitMetThrReq(&pPacket, CUDA_GET_DEVICE_COUNT, __FUNCTION__)
			== ERROR) {
		return cuda_err;
	}

	// send the packet
	if (nvbackCudaGetDeviceCount_rpc(pPacket, index) == OK) {
		p_info(" __OK__ the number of devices is %ld. Got from the RPC call\n",
				pPacket->args[0].argi);
		// remember the count number what we get from the remote device
		*count = pPacket->args[0].argi;
		cuda_err = pPacket->ret_ex_val.err;
	} else {
		p_warn( "__ERROR__ Return from rpc with the wrong return value.\n");
		cuda_err = cudaErrorUnknown;
	}

	free(pPacket);

	return cuda_err;
}
 
/* 
cudaError_t lcudaGetDeviceCount(int *count) {
	typedef cudaError_t (* pFuncType)(int *count);
	static pFuncType pFunc = NULL;

	l_printFuncSigImpl(__FUNCTION__);

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaGetDeviceCount");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	return (pFunc(count));
}

cudaError_t cudaGetDeviceCount(int *count) {
	return ((LOCAL_EXEC == 1) ? lcudaGetDeviceCount(count) : rcudaGetDeviceCount(count));
}
*/

cudaError_t cudaGetDeviceCount(int *count) {
    *count = BACKEND_DEVICES;
    return(cudaSuccess);
}

cudaError_t rcudaGetDeviceProperties(struct cudaDeviceProp *prop, int device, int index) {
	cuda_packet_t *pPacket;

	if( l_remoteInitMetThrReq(&pPacket, CUDA_GET_DEVICE_PROPERTIES, __FUNCTION__) == ERROR){
			return cuda_err;
	}

	// override the flags; just following the cudart.c
	// guessing the CUDA_Copytype means that something needs to be copied
	// over the network
	pPacket->flags |= CUDA_Copytype;   // it now should be CUDA_request | CUDA_Copytype

	// @todo (comment) now we are storing this into argp which is of type (void*)
	// please not that in _rpc counterpart we will interpret this as argui
	// which is of type uint64_t (unsigned long), actually I do not understand;
	// I am guessing that maybe because of mixing 32bit and 64bit machines in
	// original remote_gpu and we want to be sure that
	// I am sticking to the original implementation
	pPacket->args[0].argp = (void *) prop; // I do not understand why we do this
	pPacket->args[1].argi = device;   // I understand this
	pPacket->args[2].argi = sizeof(struct cudaDeviceProp); // for driver; I do not understand why we do this

	// send the packet
	if (nvbackCudaGetDeviceProperties_rpc(pPacket, index) == OK) {
		l_printCudaDeviceProp(prop);
		cuda_err = pPacket->ret_ex_val.err;
	} else {
		p_warn( "__ERROR__ Return from rpc with the wrong return value.\n");
		// @todo some cleaning or setting cuda_err
		cuda_err = cudaErrorUnknown;
	}

	free(pPacket);

	return cuda_err;
}

cudaError_t lcudaGetDeviceProperties(struct cudaDeviceProp *prop, int device) {

	typedef cudaError_t (* pFuncType)(struct cudaDeviceProp *prop, int device);
	static pFuncType pFunc = NULL;

	l_printFuncSigImpl(__FUNCTION__);

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaGetDeviceProperties");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	return (pFunc(prop, device));

}

/*
cudaError_t cudaGetDeviceProperties(struct cudaDeviceProp *prop, int device) {
	return LOCAL_EXEC == 1 ? lcudaGetDeviceProperties(prop, device) : rcudaGetDeviceProperties(prop, device);
}
 */

cudaError_t cudaGetDeviceProperties(struct cudaDeviceProp *prop, int device) {
    cudaError_t ret;
    //if(device<DEVICES_PER_NODE)
        //ret = lcudaGetDeviceProperties(prop, device);
    //else
        ret = rcudaGetDeviceProperties(prop, DEV_TO_LOCALDEV[device], DEV_TO_INDEX[device]);
    return(ret);
}

cudaError_t cudaChooseDevice(int *device,
		const struct cudaDeviceProp *prop) {
	typedef cudaError_t (* pFuncType)(int *device,
			const struct cudaDeviceProp *prop);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaChooseDevice");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(device, prop));
}

cudaError_t rcudaSetDevice(int device, int index, int isLocal) {
	cuda_packet_t *pPacket;

	if( l_remoteInitMetThrReq(&pPacket, CUDA_SET_DEVICE, __FUNCTION__) == ERROR){
		return cuda_err;
	}
	pPacket->args[0].argi = device;
	pPacket->args[1].argi = isLocal;
    
	// send the packet
	if (nvbackCudaSetDevice_rpc(pPacket, index) == OK) {
		//cuda_err = pPacket->ret_ex_val.err;
		// let's assume this is an asynchronous call
		cuda_err = cudaSuccess;
	} else {
		p_warn( "__ERROR__ Return from rpc with the wrong return value.\n");
		cuda_err = cudaErrorUnknown;
	}

	free(pPacket);

	return cuda_err;
}

cudaError_t lcudaSetDevice(int device) {
	l_printFuncSigImpl(__FUNCTION__);

	typedef cudaError_t (* pFuncType)(int device);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaSetDevice");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	return (pFunc(device));
}

/*
cudaError_t cudaSetDevice(int device) {
	return (LOCAL_EXEC == 1 ? lcudaSetDevice(device) : rcudaSetDevice(device));
}
 */

cudaError_t cudaSetDevice(int device) {
    cudaError_t ret;
    int* CUR_DEV;
    int device_DRR=BACKEND_DEVICES;
    
    if(!(CUR_DEV=pthread_getspecific(tlsKey2))) {
        CUR_DEV=calloc(1, sizeof(int));
        pthread_setspecific(tlsKey2, CUR_DEV);
    }
    
    //if(device >= BACKEND_NODES*DEVICES_PER_NODE)
      //  return(cudaErrorInvalidDevice);
    
               
    int isLocal = 0;//is big request ifrit hardcoded
    //if(device<DEVICES_PER_NODE)
        //ret = lcudaSetDevice(device);
    //else
    rcudaGetDevice(&device_DRR, MAX_BACKEND_NODES, isLocal);
    
    //device_DRR %= (BACKEND_NODES*DEVICES_PER_NODE);
    printf("GOT DEV:%d*****\n", device_DRR);

    ret = rcudaSetDevice(DEV_TO_LOCALDEV[device_DRR], DEV_TO_INDEX[device_DRR], isLocal);
    //fprintf(stderr, "\n\n\n\nnode_indx:%d, local_indx:%d\n\n\n\n", DEV_TO_INDEX[device], DEV_TO_LOCALDEV[device]); 
    //if(strcmp(BACKEND_LIST[DEV_TO_INDEX[device_DRR]], "localhost") == 0) isLocal = 1;
    //if(isLocal == 1){fprintf(stderr, "\n\nbackend is mapped to the local node\n\n"); exit(-1);}

    //ret = rcudaSetDevice(DEV_TO_LOCALDEV[device], DEV_TO_INDEX[device]);
    if(ret==cudaSuccess)
        (*CUR_DEV) = device_DRR;
    /*if(ret==cudaSuccess)
        (*CUR_DEV) = device;*/
    //exit(-1);
    return(ret);
}

//local is flag to send the information that the backend is in local node or not
cudaError_t rcudaGetDevice(int *device, int index, int node_id) { 
	cuda_packet_t * pPacket;

	if (l_remoteInitMetThrReq(&pPacket, CUDA_GET_DEVICE, __FUNCTION__) == ERROR) {
		return cuda_err;
	}

	pPacket->args[0].argi=*device;
	pPacket->args[1].argi=first_local;
	pPacket->args[2].argi = node_id;
	pPacket->is_feedback_packet = 0;


	// send the packet
	if (nvbackCudaGetDevice_rpc(pPacket, index) == OK) {
		p_info("__OK__ RPC call returned: assigned device id = %ld.\n",
				pPacket->args[0].argi);
		// remember the count number what we get from the remote device
		*device = pPacket->args[0].argi;
		cuda_err = pPacket->ret_ex_val.err;
	} else {
		p_warn( "__ERROR__ Return from rpc with the wrong return value.\n");
		cuda_err = cudaErrorUnknown;
	}

	free(pPacket);

	return cuda_err;
}

/*
cudaError_t lcudaGetDevice(int *device) {
	typedef cudaError_t (* pFuncType)(int *device);
	static pFuncType pFunc = NULL;

	l_printFuncSigImpl(__FUNCTION__);

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaGetDevice");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	return (pFunc(device));
}


cudaError_t cudaGetDevice(int *device) {
	return (LOCAL_EXEC == 1 ? lcudaGetDevice(device) : rcudaGetDevice(device));
}
*/

cudaError_t cudaGetDevice(int *device) {
    
    cudaError_t ret;
    int* CUR_DEV;
    if(!(CUR_DEV=pthread_getspecific(tlsKey2))) {
        CUR_DEV=calloc(1, sizeof(int));
        pthread_setspecific(tlsKey2, CUR_DEV);
    }
    
    *device = (*CUR_DEV);
    ret = cudaSuccess;
    return(ret);
}


cudaError_t cudaSetValidDevices(int *device_arr, int len) {
	typedef cudaError_t (* pFuncType)(int *device_arr, int len);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaSetValidDevices");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(device_arr, len));
}
cudaError_t cudaSetDeviceFlags(unsigned int flags) {
	typedef cudaError_t (* pFuncType)(unsigned int flags);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaSetDeviceFlags");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(flags));
}
// -----------------------------------------
cudaError_t cudaStreamCreate(cudaStream_t *pStream) {
	typedef cudaError_t (* pFuncType)(cudaStream_t *pStream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaStreamCreate");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(pStream));
}
cudaError_t cudaStreamDestroy(cudaStream_t stream) {
	typedef cudaError_t (* pFuncType)(cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaStreamDestroy");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(stream));
}
cudaError_t cudaStreamWaitEvent(cudaStream_t stream, cudaEvent_t event,
		unsigned int flags) {
	typedef cudaError_t (* pFuncType)(cudaStream_t stream, cudaEvent_t event,
			unsigned int flags);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaStreamWaitEvent");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(stream, event, flags));
}
cudaError_t cudaStreamSynchronize(cudaStream_t stream) {
	typedef cudaError_t (* pFuncType)(cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaStreamSynchronize");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(stream));
}
cudaError_t cudaStreamQuery(cudaStream_t stream) {
	typedef cudaError_t (* pFuncType)(cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaStreamQuery");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(stream));
}
// --------------------------------

cudaError_t cudaEventCreate(cudaEvent_t *event) {
	typedef cudaError_t (* pFuncType)(cudaEvent_t *event);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaEventCreate");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(event));
}
cudaError_t cudaEventCreateWithFlags(cudaEvent_t *event,
		unsigned int flags) {
	typedef cudaError_t (* pFuncType)(cudaEvent_t *event, unsigned int flags);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaEventCreateWithFlags");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(event, flags));
}
cudaError_t cudaEventRecord(cudaEvent_t event, cudaStream_t stream
		__dv(0)) {
	typedef cudaError_t (* pFuncType)(cudaEvent_t event, cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaEventRecord");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(event, stream));
}
cudaError_t cudaEventQuery(cudaEvent_t event) {
	typedef cudaError_t (* pFuncType)(cudaEvent_t event);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaEventQuery");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(event));
}
cudaError_t cudaEventSynchronize(cudaEvent_t event) {
	typedef cudaError_t (* pFuncType)(cudaEvent_t event);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaEventSynchronize");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(event));
}
cudaError_t cudaEventDestroy(cudaEvent_t event) {
	typedef cudaError_t (* pFuncType)(cudaEvent_t event);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaEventDestroy");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(event));
}
cudaError_t cudaEventElapsedTime(float *ms, cudaEvent_t start,
		cudaEvent_t end) {
	typedef cudaError_t (* pFuncType)(float *ms, cudaEvent_t start,
			cudaEvent_t end);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaEventElapsedTime");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(ms, start, end));
}

// --------------------------------------------
cudaError_t rcudaConfigureCall(dim3 gridDim, dim3 blockDim,
		size_t sharedMem  __dv(0), cudaStream_t stream  __dv(0), int index) {
	cuda_packet_t *pPacket;

	if( l_remoteInitMetThrReq(&pPacket, CUDA_CONFIGURE_CALL, __FUNCTION__) == ERROR)
		return cuda_err;

	pPacket->args[0].arg_dim = gridDim;
	pPacket->args[1].arg_dim = blockDim;
	pPacket->args[2].argi = sharedMem;
	pPacket->args[3].arg_str = stream;

	fprintf(stderr,"gridDim(x,y,z)=%u, %u, %u; blockDim(x,y,z)=%u, %u, %u; sharedMem (size) = %ld; stream =%ld\n",
			pPacket->args[0].arg_dim.x, pPacket->args[0].arg_dim.y, pPacket->args[0].arg_dim.z,
			pPacket->args[1].arg_dim.x, pPacket->args[1].arg_dim.y, pPacket->args[1].arg_dim.z,
			pPacket->args[2].argi, (long unsigned) pPacket->args[3].arg_str);

	// send the packet
	if (nvbackCudaConfigureCall_rpc(pPacket, index) == OK) {
		// asynchronous call
		cuda_err = cudaSuccess;
	} else {
		p_warn("__ERROR__: Return from rpc with the wrong return value.\n");
		// indicate error situation
		cuda_err = cudaErrorUnknown;
	}

	free(pPacket);

	return cuda_err;
}

cudaError_t lcudaConfigureCall(dim3 gridDim, dim3 blockDim,
		size_t sharedMem  __dv(0), cudaStream_t stream  __dv(0)) {

	typedef cudaError_t (* pFuncType)(dim3 gridDim, dim3 blockDim,
			size_t sharedMem, cudaStream_t stream);
	static pFuncType pFunc = NULL;

	l_printFuncSigImpl(__FUNCTION__);
	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaConfigureCall");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	return (pFunc(gridDim, blockDim, sharedMem, stream));
}

/*
cudaError_t cudaConfigureCall(dim3 gridDim, dim3 blockDim,
		size_t sharedMem  __dv(0), cudaStream_t stream  __dv(0)) {
	if( LOCAL_EXEC == 1 )
		return lcudaConfigureCall(gridDim, blockDim, sharedMem, stream);
	else
		return rcudaConfigureCall(gridDim, blockDim, sharedMem, stream);
}
*/


cudaError_t cudaConfigureCall(dim3 gridDim, dim3 blockDim,
        size_t sharedMem  __dv(0), cudaStream_t stream  __dv(0)) {

    cudaError_t ret;
    int* CUR_DEV;
    if(!(CUR_DEV=pthread_getspecific(tlsKey2))) {
        CUR_DEV=calloc(1, sizeof(int));
        pthread_setspecific(tlsKey2, CUR_DEV);
    }

    //if(CUR_DEV<DEVICES_PER_NODE)
        //ret = lcudaConfigureCall(gridDim, blockDim, sharedMem, stream);
    //else
        ret = rcudaConfigureCall(gridDim, blockDim, sharedMem, stream, DEV_TO_INDEX[*CUR_DEV]);
    return(ret);
}
 


cudaError_t rcudaSetupArgument(const void *arg, size_t size, size_t offset, int index) {
	cuda_packet_t *pPacket;

	if( l_remoteInitMetThrReq(&pPacket, CUDA_SETUP_ARGUMENT, __FUNCTION__) == ERROR){
				return cuda_err;
	}

	// override the flags; just following the cudart.c
	// guessing the CUDA_Copytype means that something needs to be copied
	// over the network
	pPacket->flags |= CUDA_Copytype; // it now should be CUDA_request | CUDA_Copytype

	// @todo (comment) now we are storing this into argp which is of type (void*)
	// please not that in _rpc counterpart we will interpret this as argui
	// which is of type uint64_t (unsigned long), actually I do not understand;
	// I am guessing that maybe because of mixing 32bit and 64bit machines in
	// original remote_gpu and we want to be sure that
	// I am sticking to the original implementation

	pPacket->args[0].argp = (void *)arg;  // argument to push for a kernel launch
	pPacket->args[1].argi = size;
	pPacket->args[2].argi = offset; // for driver; Offset in argument stack to push new arg

	// send the packet
	if (nvbackCudaSetupArgument_rpc(pPacket, index) == OK) {
		cuda_err = cudaSuccess;
	} else {
		p_warn( "__ERROR__ Return from rpc with the wrong return value.\n");
		cuda_err = cudaErrorUnknown;
	}

	free(pPacket);

	return cuda_err;
}

cudaError_t lcudaSetupArgument(const void *arg, size_t size, size_t offset) {

	typedef cudaError_t (* pFuncType)(const void *arg, size_t size,
			size_t offset);
	static pFuncType pFunc = NULL;

	l_printFuncSigImpl(__FUNCTION__);

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaSetupArgument");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	return (pFunc(arg, size, offset));
}

/*
cudaError_t cudaSetupArgument(const void *arg, size_t size, size_t offset) {
	if( LOCAL_EXEC == 1)
		return lcudaSetupArgument(arg, size, offset);
	else
		return rcudaSetupArgument(arg, size, offset);
}
*/

cudaError_t cudaSetupArgument(const void *arg, size_t size, size_t offset) {
    cudaError_t ret;
    int* CUR_DEV;
    if(!(CUR_DEV=pthread_getspecific(tlsKey2))) {
        CUR_DEV=calloc(1, sizeof(int));
        pthread_setspecific(tlsKey2, CUR_DEV);
    }
    //if(CUR_DEV<DEVICES_PER_NODE)
        //ret = lcudaSetupArgument(arg, size, offset);
    //else
        ret = rcudaSetupArgument(arg, size, offset, DEV_TO_INDEX[*CUR_DEV]);
	if(arg)
		fprintf(stderr,"ARGSETUP %s\n",arg);
    return(ret);
}


cudaError_t cudaFuncSetCacheConfig(const char *func,
		enum cudaFuncCache cacheConfig) {
	typedef cudaError_t (* pFuncType)(const char *func,
			enum cudaFuncCache cacheConfig);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaFuncSetCacheConfig");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(func, cacheConfig));
}

cudaError_t rcudaLaunch(const char *entry, int index) {
	cuda_packet_t *pPacket;

	if( l_remoteInitMetThrReq(&pPacket, CUDA_LAUNCH, __FUNCTION__) == ERROR){
				return cuda_err;
	}
	pPacket->args[0].argcp = (char *)entry;

	printf("%s, entry: %s\n", __FUNCTION__, entry);
	// send the packet
	if (nvbackCudaLaunch_rpc(pPacket, index) == OK) {
		cuda_err = cudaSuccess;
	} else {
		p_warn("__ERROR__: Return from rpc with the wrong return value.\n");
		// @todo some cleaning or setting cuda_err
		cuda_err = cudaErrorUnknown;
	}

	free(pPacket);

	return cuda_err;
}

cudaError_t lcudaLaunch(const char *entry) {

	typedef cudaError_t (* pFuncType)(const char *entry);
	static pFuncType pFunc = NULL;

	l_printFuncSigImpl(__FUNCTION__);
	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaLaunch");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	return (pFunc(entry));
}

/*
cudaError_t cudaLaunch(const char *entry) {
	return (LOCAL_EXEC == 1 ? lcudaLaunch(entry) : rcudaLaunch(entry));
}
*/

cudaError_t cudaLaunch(const char *entry) {
    cudaError_t ret;
    int* CUR_DEV;
    if(!(CUR_DEV=pthread_getspecific(tlsKey2))) {
        CUR_DEV=calloc(1, sizeof(int));
        pthread_setspecific(tlsKey2, CUR_DEV);
    }
    
    //if(CUR_DEV<DEVICES_PER_NODE)
        //ret = lcudaLaunch(entry);
    //else
        ret = rcudaLaunch(entry, DEV_TO_INDEX[*CUR_DEV]);
    return(ret);
}

cudaError_t cudaFuncGetAttributes(struct cudaFuncAttributes *attr,
		const char *func) {
	typedef cudaError_t (* pFuncType)(struct cudaFuncAttributes *attr,
			const char *func);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaFuncGetAttributes");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(attr, func));
}
cudaError_t cudaSetDoubleForDevice(double *d) {
	typedef cudaError_t (* pFuncType)(double *d);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaSetDoubleForDevice");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(d));
}
cudaError_t cudaSetDoubleForHost(double *d) {
	l_printFuncSig(__FUNCTION__);

	typedef cudaError_t (* pFuncType)(double *d);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaSetDoubleForHost");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	return (pFunc(d));
}

cudaError_t rcudaMalloc(void **devPtr, size_t size, int index) {
	cuda_packet_t * pPacket;

	if( l_remoteInitMetThrReq(&pPacket, CUDA_MALLOC, __FUNCTION__) == ERROR){
		return cuda_err;
	}

	pPacket->args[0].argdp = devPtr;
	pPacket->args[1].argi = size;

	printf("\ndevPtr %p, *devPtr %p, size %ld\n", devPtr, *devPtr, size);

	if(nvbackCudaMalloc_rpc(pPacket, index) != OK ){
		printd(DBG_ERROR, "%s: __ERROR__: Return from the RPC\n", __FUNCTION__);
		cuda_err = cudaErrorMemoryAllocation;
		*devPtr = NULL;
	} else {
		printd(DBG_INFO, "%s: __OK__:  Return from the RPC call DevPtr %p\n", __FUNCTION__,
				pPacket->args[0].argp);
		// unpack what we have got from the packet
		*devPtr = pPacket->args[0].argp;
		cuda_err = pPacket->ret_ex_val.err;
	}

	free(pPacket);
	return cuda_err;
}

cudaError_t lcudaMalloc(void **devPtr, size_t size) {

	typedef cudaError_t (* pFuncType)(void **devPtr, size_t size);
	static pFuncType pFunc = NULL;

	l_printFuncSigImpl(__FUNCTION__);

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMalloc");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	return (pFunc(devPtr, size));
}

// --------------------------------------------
/*
cudaError_t cudaMalloc(void **devPtr, size_t size) {
	return LOCAL_EXEC == 1 ? lcudaMalloc(devPtr, size) : rcudaMalloc(devPtr, size);
}
*/

cudaError_t cudaMalloc(void **devPtr, size_t size) {
    cudaError_t ret;
    int* CUR_DEV;
    if(!(CUR_DEV=pthread_getspecific(tlsKey2))) {
        CUR_DEV=calloc(1, sizeof(int));
        pthread_setspecific(tlsKey2, CUR_DEV);
    }
    
    //if (CUR_DEV<DEVICES_PER_NODE)
        //ret = lcudaMalloc(devPtr, size);
    //else
        ret = rcudaMalloc(devPtr, size, DEV_TO_INDEX[*CUR_DEV]);
    return(ret);
}

cudaError_t cudaMallocHost(void **ptr, size_t size) {
	typedef cudaError_t (* pFuncType)(void **ptr, size_t size);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMallocHost");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(ptr, size));
}

cudaError_t cudaMallocPitch(void **devPtr, size_t *pitch, size_t width,
		size_t height) {
	typedef cudaError_t (* pFuncType)(void **devPtr, size_t *pitch,
			size_t width, size_t height);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMallocPitch");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}
	l_printFuncSig(__FUNCTION__);

	return (pFunc(devPtr, pitch, width, height));
}

cudaError_t cudaMallocArray(struct cudaArray **array,
		const struct cudaChannelFormatDesc *desc, size_t width, size_t height
				__dv(0), unsigned int flags __dv(0)) {
	typedef cudaError_t (* pFuncType)(struct cudaArray **,
			const struct cudaChannelFormatDesc *, size_t, size_t, unsigned int);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMallocArray");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}
	l_printFuncSig(__FUNCTION__);

	return (pFunc(array, desc, width, height, flags));
}


cudaError_t rcudaFree(void * devPtr, int index) {
	cuda_packet_t *pPacket;

	if( l_remoteInitMetThrReq(&pPacket, CUDA_FREE, __FUNCTION__) == ERROR){
				return cuda_err;
	}
	pPacket->args[0].argp = devPtr;

	// send the packet
	if(nvbackCudaFree_rpc(pPacket, index) == OK ){
		printd(DBG_DEBUG, "%s: __OK__ The used pointer %p\n", __FUNCTION__,
						pPacket->args[0].argp);
		cuda_err = cudaSuccess;
	} else {
		printd(DBG_ERROR, "%s: __ERROR__ Return from rpc with the wrong return value.\n", __FUNCTION__);
		cuda_err = cudaErrorUnknown;
	}

	free(pPacket);

	return cuda_err;
}

/**
 * @brief The pattern of the functions so far. This function is being interposed
 * via PRE_LOAD. We need the original function; that's
 * why we call dlsym that seeks to find the next call of this signature. So first
 * we find that call, store in a function pointer and later call it eventually.
 * Right now, the only thing that interposed function does prints the arguments
 * of this function.
 */
cudaError_t lcudaFree(void * devPtr) {

	typedef cudaError_t (* pFuncType)(void *);
	static pFuncType pFunc = NULL;

	l_printFuncSigImpl(__FUNCTION__);

	if (!pFunc) {
		// find next occurence of the cudaFree() call,
		// C++ requires casting void to the func ptr
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaFree");

		if (l_handleDlError() != 0)
			// problems with the dynamic library
			return cudaErrorDL;
	}

	// call the function that was found by the dlsym - we hope this is
	// the original function
	return (pFunc(devPtr));
}

/*
cudaError_t cudaFree(void * devPtr) {
	return 1 == LOCAL_EXEC ? lcudaFree(devPtr) : rcudaFree(devPtr);
}
*/

cudaError_t cudaFree(void * devPtr) {
    cudaError_t ret;
    int* CUR_DEV;
    if(!(CUR_DEV=pthread_getspecific(tlsKey2))) {
        CUR_DEV=calloc(1, sizeof(int));
        pthread_setspecific(tlsKey2, CUR_DEV);
    }
    
    //if(CUR_DEV<DEVICES_PER_NODE)
        //ret = lcudaFree(devPtr);
    //else
        ret = rcudaFree(devPtr, DEV_TO_INDEX[*CUR_DEV]);
    return(ret);
}

cudaError_t cudaFreeHost(void * ptr) {
	typedef cudaError_t (* pFuncType)(void *);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaFreeHost");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}
	l_printFuncSig(__FUNCTION__);

	return (pFunc(ptr));
}

cudaError_t cudaFreeArray(struct cudaArray * array) {
	typedef cudaError_t (* pFuncType)(struct cudaArray * array);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaFreeArray");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(array));
}

// --------------------------------------------------------
cudaError_t cudaHostAlloc(void **pHost, size_t size, unsigned int flags) {
	typedef cudaError_t (* pFuncType)(void **, size_t, unsigned int);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaHostAlloc");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(pHost, size, flags));
}

cudaError_t cudaHostGetDevicePointer(void **pDevice, void *pHost,
		unsigned int flags) {
	typedef cudaError_t (* pFuncType)(void **pDevice, void *pHost,
			unsigned int flags);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaHostGetDevicePointer");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}
	l_printFuncSig(__FUNCTION__);

	return (pFunc(pDevice, pHost, flags));
}

cudaError_t cudaHostGetFlags(unsigned int *pFlags, void *pHost) {
	typedef cudaError_t (* pFuncType)(unsigned int*, void*);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaHostGetFlags");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(pFlags, pHost));
}

cudaError_t cudaMalloc3D(struct cudaPitchedPtr* pitchedDevPtr,
		struct cudaExtent extent) {
	typedef cudaError_t
	(* pFuncType)(struct cudaPitchedPtr*, struct cudaExtent);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMalloc3D");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(pitchedDevPtr, extent));
}

cudaError_t cudaMalloc3DArray(struct cudaArray** array,
		const struct cudaChannelFormatDesc* desc, struct cudaExtent extent,
		unsigned int flags) {
	typedef cudaError_t (* pFuncType)(struct cudaArray** array,
			const struct cudaChannelFormatDesc* desc, struct cudaExtent extent,
			unsigned int flags);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMalloc3DArray");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}
	l_printFuncSig(__FUNCTION__);

	return (pFunc(array, desc, extent, flags));
}
// --------------------------------
cudaError_t cudaMemcpy3D(const struct cudaMemcpy3DParms *p) {
	typedef cudaError_t (* pFuncType)(const struct cudaMemcpy3DParms *p);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpy3D");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}
	l_printFuncSig(__FUNCTION__);

	return (pFunc(p));
}
cudaError_t cudaMemcpy3DAsync(const struct cudaMemcpy3DParms *p,
		cudaStream_t stream __dv(0)) {
	typedef cudaError_t (* pFuncType)(const struct cudaMemcpy3DParms *p,
			cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpy3DAsync");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}
	l_printFuncSig(__FUNCTION__);

	return (pFunc(p, stream));
}

cudaError_t cudaMemGetInfo(size_t *free, size_t *total) {
	typedef cudaError_t (* pFuncType)(size_t *free, size_t *total);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemGetInfo");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}
	l_printFuncSig(__FUNCTION__);

	return (pFunc(free, total));
}

cudaError_t rcudaMemcpy(void *dst, const void *src, size_t count,
		enum cudaMemcpyKind kind, int index) {
	cuda_packet_t *pPacket;

	// you need to setup a method id individually
	if( l_remoteInitMetThrReq(&pPacket, ERROR, __FUNCTION__) == ERROR){
		return cuda_err;
	}

	pPacket->args[0].argp = dst;
	pPacket->args[1].argp = (void *)src;
	pPacket->args[2].argi = count;
	pPacket->args[3].argi = kind;
	pPacket->flags |= CUDA_Copytype;

	// send the packet
	if(nvbackCudaMemcpy_rpc(pPacket, index) != OK ){
		printd(DBG_ERROR, "%s: __ERROR__ Return from rpc with the wrong return value.\n", __FUNCTION__);
		// @todo some cleaning or setting cuda_err
		cuda_err = cudaErrorUnknown;
	} else {
		printd(DBG_DEBUG, "%s: __OK__ Return from RPC.\n", __FUNCTION__);
		cuda_err = pPacket->ret_ex_val.err;
	}

	free(pPacket);

	return cuda_err;
}

cudaError_t lcudaMemcpy(void *dst, const void *src, size_t count,
		enum cudaMemcpyKind kind) {
	typedef cudaError_t (* pFuncType)(void *dst, const void *src, size_t count,
			enum cudaMemcpyKind kind);
	static pFuncType pFunc = NULL;

	l_printFuncSigImpl(__FUNCTION__);

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpy");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}


	return (pFunc(dst, src, count, kind));
}


/*
cudaError_t cudaMemcpy(void *dst, const void *src, size_t count,
		enum cudaMemcpyKind kind) {
	if( 1 == LOCAL_EXEC )
		return lcudaMemcpy(dst, (const void *) src, count, kind);
	else
		return rcudaMemcpy(dst, (const void *) src, count, kind);
}
*/

cudaError_t cudaMemcpy(void *dst, const void *src, size_t count,
                       enum cudaMemcpyKind kind) {
    cudaError_t ret;
    int* CUR_DEV;
    if(!(CUR_DEV=pthread_getspecific(tlsKey2))) {
        CUR_DEV=calloc(1, sizeof(int));
        pthread_setspecific(tlsKey2, CUR_DEV);
    }
    
    //if(CUR_DEV<DEVICES_PER_NODE)
        //ret = lcudaMemcpy(dst, (const void *) src, count, kind);
    //else
        ret = rcudaMemcpy(dst, (const void *) src, count, kind, DEV_TO_INDEX[*CUR_DEV]);
    return(ret);
}
    


cudaError_t cudaMemcpyToArray(struct cudaArray *dst, size_t wOffset,
		size_t hOffset, const void *src, size_t count, enum cudaMemcpyKind kind) {
	typedef cudaError_t (* pFuncType)(struct cudaArray *dst, size_t wOffset,
			size_t hOffset, const void *src, size_t count,
			enum cudaMemcpyKind kind);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpyToArray");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}
	l_printFuncSig(__FUNCTION__);

	return (pFunc(dst, wOffset, hOffset, src, count, kind));
}

cudaError_t cudaMemcpyFromArray(void *dst, const struct cudaArray *src,
		size_t wOffset, size_t hOffset, size_t count, enum cudaMemcpyKind kind) {
	typedef cudaError_t (* pFuncType)(void *dst, const struct cudaArray *src,
			size_t wOffset, size_t hOffset, size_t count,
			enum cudaMemcpyKind kind);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpyFromArray");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}
	l_printFuncSig(__FUNCTION__);

	return (pFunc(dst, src, wOffset, hOffset, count, kind));
}

cudaError_t cudaMemcpyArrayToArray(struct cudaArray *dst,
		size_t wOffsetDst, size_t hOffsetDst, const struct cudaArray *src,
		size_t wOffsetSrc, size_t hOffsetSrc, size_t count,
		enum cudaMemcpyKind kind __dv(cudaMemcpyDeviceToDevice)) {
	typedef cudaError_t (* pFuncType)(struct cudaArray *dst, size_t wOffsetDst,
			size_t hOffsetDst, const struct cudaArray *src, size_t wOffsetSrc,
			size_t hOffsetSrc, size_t count, enum cudaMemcpyKind kind);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpyArrayToArray");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}
	l_printFuncSig(__FUNCTION__);

	return (pFunc(dst, wOffsetDst, hOffsetDst, src, wOffsetSrc, hOffsetSrc,
			count, kind));

}

cudaError_t cudaMemcpy2D(void *dst, size_t dpitch, const void *src,
		size_t spitch, size_t width, size_t height, enum cudaMemcpyKind kind) {
	typedef cudaError_t (* pFuncType)(void *dst, size_t dpitch,
			const void *src, size_t spitch, size_t width, size_t height,
			enum cudaMemcpyKind kind);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpy2D");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}
	l_printFuncSig(__FUNCTION__);

	return (pFunc(dst, dpitch, src, spitch, width, height, kind));
}

cudaError_t cudaMemcpy2DToArray(struct cudaArray *dst, size_t wOffset,
		size_t hOffset, const void *src, size_t spitch, size_t width,
		size_t height, enum cudaMemcpyKind kind) {

	typedef cudaError_t (* pFuncType)(struct cudaArray *dst, size_t wOffset,
			size_t hOffset, const void *src, size_t spitch, size_t width,
			size_t height, enum cudaMemcpyKind kind);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpy2DToArray");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}
	l_printFuncSig(__FUNCTION__);

	return (pFunc(dst, wOffset, hOffset, src, spitch, width, height, kind));
}

cudaError_t cudaMemcpy2DFromArray(void *dst, size_t dpitch,
		const struct cudaArray *src, size_t wOffset, size_t hOffset,
		size_t width, size_t height, enum cudaMemcpyKind kind) {
	typedef cudaError_t (* pFuncType)(void *dst, size_t dpitch,
			const struct cudaArray *src, size_t wOffset, size_t hOffset,
			size_t width, size_t height, enum cudaMemcpyKind kind);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpy2DFromArray");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}
	l_printFuncSig(__FUNCTION__);

	return (pFunc(dst, dpitch, src, wOffset, hOffset, width, height, kind));
}

cudaError_t cudaMemcpy2DArrayToArray(struct cudaArray *dst,
		size_t wOffsetDst, size_t hOffsetDst, const struct cudaArray *src,
		size_t wOffsetSrc, size_t hOffsetSrc, size_t width, size_t height,
		enum cudaMemcpyKind kind __dv(cudaMemcpyDeviceToDevice)) {
	typedef cudaError_t (* pFuncType)(struct cudaArray *dst, size_t wOffsetDst,
			size_t hOffsetDst, const struct cudaArray *src, size_t wOffsetSrc,
			size_t hOffsetSrc, size_t width, size_t height,
			enum cudaMemcpyKind kind);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpy2DArrayToArray");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}
	l_printFuncSig(__FUNCTION__);

	return (pFunc(dst, wOffsetDst, hOffsetDst, src, wOffsetSrc, hOffsetSrc,
			width, height, kind));
}

cudaError_t rcudaMemcpyToSymbol(const char *symbol, const void *src,
		size_t count, size_t offset __dv(0), enum cudaMemcpyKind kind
				__dv(cudaMemcpyHostToDevice), int index) {
	cuda_packet_t *pPacket;
	// this will hold the hostVar value (a pointer corresponding
	// ot a symbol
	char * hostVar = NULL;

	// symbol might be a pointer or a name of variable (see CUDA API)
	// can either be a variable that resides in global or constant memory space,
	// or it can be a character string, naming a variable that resides in global
	// or constant memory space
	// we use a trick to find out if symbol is a pointer or
	// a string; since all pointers are registered during
	// the __cudaRegisterVar and we store those register
	// pointers in regHostVarsTab; so if we assume that our
	// symbol is a pointer is should be stored in regHostVarsTab;
	// if it is not, then our assumption is wrong and symbol is a string
	// a name of the variable

	hostVar = g_vars_find(regHostVarsTab, symbol);
	if ( NULL == hostVar ){
		p_warn("__ERROR__: The symbol %p has not been found", symbol);
		cuda_err = cudaErrorInvalidSymbol;
		return cuda_err;
	}

	if( l_remoteInitMetThrReq(&pPacket, CUDA_MEMCPY_TO_SYMBOL,__FUNCTION__) == ERROR){
		return cuda_err;
	}

	// should be hostVar corresponding to a symbol
	pPacket->args[0].argcp = (char*)hostVar;
	pPacket->args[1].argp = (void *)src;
	pPacket->args[2].arr_argi[0] = count;
	pPacket->args[2].arr_argi[1] = offset;
	pPacket->args[3].argi = kind;
	pPacket->flags |= CUDA_Copytype;

	// send the packet
	if(nvbackCudaMemcpyToSymbol_rpc(pPacket, index) == OK ){
		p_debug( "__OK__: Return from RPC.\n");
		cuda_err = pPacket->ret_ex_val.err;
	} else {
		p_warn("__ERROR__: Return from rpc with the wrong return value.\n");
		cuda_err = cudaErrorUnknown;
	}

	free(pPacket);

	return cuda_err;

}

cudaError_t lcudaMemcpyToSymbol(const char *symbol, const void *src,
		size_t count, size_t offset __dv(0), enum cudaMemcpyKind kind
				__dv(cudaMemcpyHostToDevice)) {
	typedef cudaError_t (* pFuncType)(const char *symbol, const void *src,
			size_t count, size_t offset, enum cudaMemcpyKind kind);
	static pFuncType pFunc = NULL;

	l_printFuncSigImpl(__FUNCTION__);

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpyToSymbol");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	return (pFunc(symbol, src, count, offset, kind));
}

/*
cudaError_t cudaMemcpyToSymbol(const char *symbol, const void *src,
		size_t count, size_t offset __dv(0), enum cudaMemcpyKind kind
				__dv(cudaMemcpyHostToDevice)) {

	p_debug("symbol = %p, src = %p, count = %ld, offset = %ld, kind = %u\n",
			 symbol, src, count, offset, kind);

	if( 1 == LOCAL_EXEC )
		return lcudaMemcpyToSymbol(symbol, src, count, offset, kind);
	else
		return rcudaMemcpyToSymbol(symbol, src, count, offset, kind);
}
*/

cudaError_t cudaMemcpyToSymbol(const char *symbol, const void *src,
                               size_t count, size_t offset __dv(0), enum cudaMemcpyKind kind
                               __dv(cudaMemcpyHostToDevice)) {
    cudaError_t ret;
    int* CUR_DEV;
    if(!(CUR_DEV=pthread_getspecific(tlsKey2))) {
        CUR_DEV=calloc(1, sizeof(int));
        pthread_setspecific(tlsKey2, CUR_DEV);
    }
    
    //if(CUR_DEV<DEVICES_PER_NODE)
        //ret=lcudaMemcpyToSymbol(symbol, src, count, offset, kind);
    //else
        ret=rcudaMemcpyToSymbol(symbol, src, count, offset, kind, DEV_TO_INDEX[*CUR_DEV]);
    return(ret);
}


// new implementation; absent in gvim/pegasus
cudaError_t rcudaMemcpyFromSymbol(void *dst, const char *symbol,
		size_t count, size_t offset __dv(0), enum cudaMemcpyKind kind
				__dv(cudaMemcpyDeviceToHost), int index) {
	cuda_packet_t *pPacket;
	// this will hold the hostVar value (a pointer corresponding
	// ot a symbol
	char * hostVar = NULL;

	// symbol might be a pointer or a name of variable (see CUDA API)
	// can either be a variable that resides in global or constant memory space,
	// or it can be a character string, naming a variable that resides in global
	// or constant memory space
	// we use a trick to find out if symbol is a pointer or
	// a string; since all pointers are registered during
	// the __cudaRegisterVar and we store those register
	// pointers in regHostVarsTab; so if we assume that our
	// symbol is a pointer is should be stored in regHostVarsTab;
	// if it is not, then our assumption is wrong and symbol is a string
	// a name of the variable


	hostVar = g_vars_find(regHostVarsTab, symbol);
	if ( NULL == hostVar ){
		p_warn("The symbol %p has not been found!", symbol);
		cuda_err = cudaErrorInvalidSymbol;
		return cuda_err;
	}

	// you need to setup a method id individually
	if( l_remoteInitMetThrReq(&pPacket, CUDA_MEMCPY_FROM_SYMBOL, __FUNCTION__) == ERROR){
		return cuda_err;
	}

	// hostVar (a pointer) corresponding symbol
	pPacket->args[0].argcp = (char*)hostVar;
	pPacket->args[1].argp = (void *)dst;
	pPacket->args[2].arr_argi[0] = count;
	pPacket->args[2].arr_argi[1] = offset;
	pPacket->args[3].argi = kind;
	pPacket->flags |= CUDA_Copytype;

	// send the packet
	if(nvbackCudaMemcpyFromSymbol_rpc(pPacket, index) == OK ){
		p_debug( " __OK__ Return from RPC.\n");
		cuda_err = pPacket->ret_ex_val.err;
	} else {
		p_warn( "__ERROR__ Return from rpc with the wrong return value.\n");
		// @todo some cleaning or setting cuda_err
		cuda_err = cudaErrorUnknown;
	}

	free(pPacket);

	return cuda_err;
}

cudaError_t lcudaMemcpyFromSymbol(void *dst, const char *symbol,
		size_t count, size_t offset __dv(0), enum cudaMemcpyKind kind
				__dv(cudaMemcpyDeviceToHost)) {
	typedef cudaError_t (* pFuncType)(void *dst, const char *symbol,
			size_t count, size_t offset, enum cudaMemcpyKind kind);
	static pFuncType pFunc = NULL;

	l_printFuncSigImpl(__FUNCTION__);

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpyFromSymbol");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	return (pFunc(dst, symbol, count, offset, kind));
}

/*
cudaError_t cudaMemcpyFromSymbol(void *dst, const char *symbol,
		size_t count, size_t offset __dv(0), enum cudaMemcpyKind kind
				__dv(cudaMemcpyDeviceToHost)) {
	p_debug("dst = %p, symbol = %p (str %s), count = %ld, offset = %ld, kind = %d\n",
			 dst, symbol, symbol, count, offset, kind);

	if( 1 == LOCAL_EXEC )
		return lcudaMemcpyFromSymbol(dst, symbol, count, offset, kind);
	else
		return rcudaMemcpyFromSymbol(dst, symbol, count, offset, kind);
}
 */

cudaError_t cudaMemcpyFromSymbol(void *dst, const char *symbol,
                                 size_t count, size_t offset __dv(0), enum cudaMemcpyKind kind
                                 __dv(cudaMemcpyDeviceToHost)) {
    cudaError_t ret;
    int* CUR_DEV;
    if(!(CUR_DEV=pthread_getspecific(tlsKey2))) {
        CUR_DEV=calloc(1, sizeof(int));
        pthread_setspecific(tlsKey2, CUR_DEV);
    }
    
    //if(CUR_DEV<DEVICES_PER_NODE)
        //ret=lcudaMemcpyFromSymbol(dst, symbol, count, offset, kind);
    //else
        ret=rcudaMemcpyFromSymbol(dst, symbol, count, offset, kind, DEV_TO_INDEX[*CUR_DEV]);
    return(ret);
}

// -----------------------------------
cudaError_t cudaMemcpyAsync(void *dst, const void *src, size_t count,
		enum cudaMemcpyKind kind, cudaStream_t stream __dv(0)) {
	typedef cudaError_t (* pFuncType)(void *dst, const void *src, size_t count,
			enum cudaMemcpyKind kind, cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpyAsync");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(dst, src, count, kind, stream));
}

cudaError_t cudaMemcpyToArrayAsync(struct cudaArray *dst,
		size_t wOffset, size_t hOffset, const void *src, size_t count,
		enum cudaMemcpyKind kind, cudaStream_t stream __dv(0)) {
	typedef cudaError_t (* pFuncType)(struct cudaArray *dst, size_t wOffset,
			size_t hOffset, const void *src, size_t count,
			enum cudaMemcpyKind kind, cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpyToArrayAsync");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(dst, wOffset, hOffset, src, count, kind, stream));
}

cudaError_t cudaMemcpyFromArrayAsync(void *dst,
		const struct cudaArray *src, size_t wOffset, size_t hOffset,
		size_t count, enum cudaMemcpyKind kind, cudaStream_t stream __dv(0)) {
	typedef cudaError_t (* pFuncType)(void *dst, const struct cudaArray *src,
			size_t wOffset, size_t hOffset, size_t count,
			enum cudaMemcpyKind kind, cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpyFromArrayAsync");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(dst, src, wOffset, hOffset, count, kind, stream));
}

cudaError_t cudaMemcpy2DAsync(void *dst, size_t dpitch, const void *src,
		size_t spitch, size_t width, size_t height, enum cudaMemcpyKind kind,
		cudaStream_t stream __dv(0)) {
	typedef cudaError_t (* pFuncType)(void *dst, size_t dpitch,
			const void *src, size_t spitch, size_t width, size_t height,
			enum cudaMemcpyKind kind, cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpy2DAsync");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(dst, dpitch, src, spitch, width, height, kind, stream));
}

cudaError_t cudaMemcpy2DToArrayAsync(struct cudaArray *dst,
		size_t wOffset, size_t hOffset, const void *src, size_t spitch,
		size_t width, size_t height, enum cudaMemcpyKind kind,
		cudaStream_t stream __dv(0)) {
	typedef cudaError_t (* pFuncType)(struct cudaArray *dst, size_t wOffset,
			size_t hOffset, const void *src, size_t spitch, size_t width,
			size_t height, enum cudaMemcpyKind kind, cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpy2DToArrayAsync");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(dst, wOffset, hOffset, src, spitch, width, height, kind,
			stream));
}

cudaError_t cudaMemcpy2DFromArrayAsync(void *dst, size_t dpitch,
		const struct cudaArray *src, size_t wOffset, size_t hOffset,
		size_t width, size_t height, enum cudaMemcpyKind kind,
		cudaStream_t stream __dv(0)) {
	typedef cudaError_t (* pFuncType)(void *dst, size_t dpitch,
			const struct cudaArray *src, size_t wOffset, size_t hOffset,
			size_t width, size_t height, enum cudaMemcpyKind kind,
			cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpy2DFromArrayAsync");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(dst, dpitch, src, wOffset, hOffset, width, height, kind,
			stream));
}

cudaError_t cudaMemcpyToSymbolAsync(const char *symbol, const void *src,
		size_t count, size_t offset, enum cudaMemcpyKind kind,
		cudaStream_t stream __dv(0)) {
	typedef cudaError_t (* pFuncType)(const char *symbol, const void *src,
			size_t count, size_t offset, enum cudaMemcpyKind kind,
			cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpyToSymbolAsync");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(symbol, src, count, offset, kind, stream));
}

cudaError_t cudaMemcpyFromSymbolAsync(void *dst, const char *symbol,
		size_t count, size_t offset, enum cudaMemcpyKind kind,
		cudaStream_t stream __dv(0)) {
	typedef cudaError_t (* pFuncType)(void *dst, const char *symbol,
			size_t count, size_t offset, enum cudaMemcpyKind kind,
			cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemcpyFromSymbolAsync");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(dst, symbol, count, offset, kind, stream));
}

// -------------------------------------
cudaError_t cudaMemset(void *devPtr, int value, size_t count) {
	typedef cudaError_t (* pFuncType)(void *devPtr, int value, size_t count);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemset");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(devPtr, value, count));
}

cudaError_t cudaMemset2D(void *devPtr, size_t pitch, int value,
		size_t width, size_t height) {
	typedef cudaError_t (* pFuncType)(void *devPtr, size_t pitch, int value,
			size_t width, size_t height);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemset2D");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(devPtr, pitch, value, width, height));
}
cudaError_t cudaMemset3D(struct cudaPitchedPtr pitchedDevPtr, int value,
		struct cudaExtent extent) {
	typedef cudaError_t (* pFuncType)(struct cudaPitchedPtr pitchedDevPtr,
			int value, struct cudaExtent extent);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemset3D");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(pitchedDevPtr, value, extent));
}
cudaError_t cudaMemsetAsync(void *devPtr, int value, size_t count,
		cudaStream_t stream __dv(0)) {
	typedef cudaError_t (* pFuncType)(void *devPtr, int value, size_t count,
			cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemsetAsync");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(devPtr, value, count, stream));
}
cudaError_t cudaMemset2DAsync(void *devPtr, size_t pitch, int value,
		size_t width, size_t height, cudaStream_t stream __dv(0)) {
	typedef cudaError_t (* pFuncType)(void *devPtr, size_t pitch, int value,
			size_t width, size_t height, cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemset2DAsync");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(devPtr, pitch, value, width, height, stream));
}
cudaError_t cudaMemset3DAsync(struct cudaPitchedPtr pitchedDevPtr,
		int value, struct cudaExtent extent, cudaStream_t stream __dv(0)) {
	typedef cudaError_t (* pFuncType)(struct cudaPitchedPtr pitchedDevPtr,
			int value, struct cudaExtent extent, cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaMemset3DAsync");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(pitchedDevPtr, value, extent, stream));
}

cudaError_t cudaGetSymbolAddress(void **devPtr, const char *symbol) {
	typedef cudaError_t (* pFuncType)(void **devPtr, const char *symbol);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaGetSymbolAddress");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(devPtr, symbol));
}

cudaError_t cudaGetSymbolSize(size_t *size, const char *symbol) {
	typedef cudaError_t (* pFuncType)(size_t *size, const char *symbol);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaGetSymbolSize");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(size, symbol));
}

// -----------------------
cudaError_t cudaGraphicsUnregisterResource(
		struct cudaGraphicsResource * resource) {
	typedef cudaError_t (* pFuncType)(struct cudaGraphicsResource * resource);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaGraphicsUnregisterResource");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(resource));
}
cudaError_t cudaGraphicsResourceSetMapFlags(
		struct cudaGraphicsResource * resource, unsigned int flags) {
	typedef cudaError_t (* pFuncType)(struct cudaGraphicsResource * resource,
			unsigned int flags);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaGraphicsResourceSetMapFlags");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(resource, flags));
}
cudaError_t cudaGraphicsMapResources(int count,
		struct cudaGraphicsResource * *resources, cudaStream_t stream __dv(0)) {
	typedef cudaError_t (* pFuncType)(int count,
			struct cudaGraphicsResource * *resources, cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaGraphicsMapResources");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(count, resources, stream));
}
cudaError_t cudaGraphicsUnmapResources(int count,
		struct cudaGraphicsResource * *resources, cudaStream_t stream __dv(0)) {
	typedef cudaError_t (* pFuncType)(int count,
			struct cudaGraphicsResource * *resources, cudaStream_t stream);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaGraphicsUnmapResources");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(count, resources, stream));
}
cudaError_t cudaGraphicsResourceGetMappedPointer(void **devPtr,
		size_t *size, struct cudaGraphicsResource * resource) {
	typedef cudaError_t (* pFuncType)(void **devPtr, size_t *size,
			struct cudaGraphicsResource * resource);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT,
				"cudaGraphicsResourceGetMappedPointer");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(devPtr, size, resource));
}
cudaError_t cudaGraphicsSubResourceGetMappedArray(
		struct cudaArray **array, struct cudaGraphicsResource * resource,
		unsigned int arrayIndex, unsigned int mipLevel) {
	typedef cudaError_t (* pFuncType)(struct cudaArray **array,
			struct cudaGraphicsResource * resource, unsigned int arrayIndex,
			unsigned int mipLevel);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT,
				"cudaGraphicsSubResourceGetMappedArray");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(array, resource, arrayIndex, mipLevel));
}

// --------------------------
cudaError_t cudaGetChannelDesc(struct cudaChannelFormatDesc *desc,
		const struct cudaArray *array) {
	typedef cudaError_t (* pFuncType)(struct cudaChannelFormatDesc *desc,
			const struct cudaArray *array);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaGetChannelDesc");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(desc, array));

}
/**
 * This call returns something different than cudaError_t so we must use different something
 * else than cudaErrorDL
 * @todo better handle DL error
 * @return empty cudaChannelFormatDesc if there is a problem with DL, as well (maybe other NULL might means something else)
 */
struct cudaChannelFormatDesc cudaCreateChannelDesc(int x, int y, int z,
		int w, enum cudaChannelFormatKind f) {
	typedef struct cudaChannelFormatDesc (* pFuncType)(int x, int y, int z,
			int w, enum cudaChannelFormatKind f);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaCreateChannelDesc");

		if (l_handleDlError() != 0) {
			struct cudaChannelFormatDesc desc;
			return desc;
		}

	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(x, y, z, w, f));

}

// --------------------------
cudaError_t cudaBindTexture(size_t *offset,
		const struct textureReference *texref, const void *devPtr,
		const struct cudaChannelFormatDesc *desc, size_t size __dv(UINT_MAX)) {
	typedef cudaError_t (* pFuncType)(size_t *offset,
			const struct textureReference *texref, const void *devPtr,
			const struct cudaChannelFormatDesc *desc, size_t size);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaBindTexture");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(offset, texref, devPtr, desc, size));

}
cudaError_t cudaBindTexture2D(size_t *offset,
		const struct textureReference *texref, const void *devPtr,
		const struct cudaChannelFormatDesc *desc, size_t width, size_t height,
		size_t pitch) {
	typedef cudaError_t (* pFuncType)(size_t *offset,
			const struct textureReference *texref, const void *devPtr,
			const struct cudaChannelFormatDesc *desc, size_t width,
			size_t height, size_t pitch);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaBindTexture2D");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(offset, texref, devPtr, desc, width, height, pitch));
}
cudaError_t cudaBindTextureToArray(
		const struct textureReference *texref, const struct cudaArray *array,
		const struct cudaChannelFormatDesc *desc) {
	typedef cudaError_t (* pFuncType)(const struct textureReference *texref,
			const struct cudaArray *array,
			const struct cudaChannelFormatDesc *desc);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaBindTextureToArray");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(texref, array, desc));

}
cudaError_t cudaUnbindTexture(const struct textureReference *texref) {
	typedef cudaError_t (* pFuncType)(const struct textureReference *texref);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaUnbindTexture");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(texref));

}
cudaError_t cudaGetTextureAlignmentOffset(size_t *offset,
		const struct textureReference *texref) {
	typedef cudaError_t (* pFuncType)(size_t *offset,
			const struct textureReference *texref);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaGetTextureAlignmentOffset");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(offset, texref));
}
cudaError_t cudaGetTextureReference(
		const struct textureReference **texref, const char *symbol) {
	typedef cudaError_t (* pFuncType)(const struct textureReference **texref,
			const char *symbol);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaGetTextureReference");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(texref, symbol));

}

// --------------------------
cudaError_t cudaBindSurfaceToArray(
		const struct surfaceReference *surfref, const struct cudaArray *array,
		const struct cudaChannelFormatDesc *desc) {
	typedef cudaError_t (* pFuncType)(const struct surfaceReference *surfref,
			const struct cudaArray *array,
			const struct cudaChannelFormatDesc *desc);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaBindSurfaceToArray");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(surfref, array, desc));

}
cudaError_t cudaGetSurfaceReference(
		const struct surfaceReference **surfref, const char *symbol) {
	typedef cudaError_t (* pFuncType)(const struct surfaceReference **surfref,
			const char *symbol);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaGetSurfaceReference");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(surfref, symbol));
}

// --------------------------
cudaError_t cudaDriverGetVersion(int *driverVersion) {
	typedef cudaError_t (* pFuncType)(int *driverVersion);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaDriverGetVersion");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(driverVersion));

}
cudaError_t cudaRuntimeGetVersion(int *runtimeVersion) {
	typedef cudaError_t (* pFuncType)(int *runtimeVersion);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaRuntimeGetVersion");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(runtimeVersion));
}

// --------------------------
cudaError_t cudaGetExportTable(const void **ppExportTable,
		const cudaUUID_t *pExportTableId) {
	typedef cudaError_t (* pFuncType)(const void **ppExportTable,
			const cudaUUID_t *pExportTableId);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "cudaGetExportTable");

		if (l_handleDlError() != 0)
			return cudaErrorDL;
	}

	l_printFuncSig(__FUNCTION__);

	return (pFunc(ppExportTable, pExportTableId));
}

// ----------------------------------------
//! Unlisted CUDA calls for state registration
// ----------------------------------------

void** pFatBinaryHandle = NULL;


/**
 * The implementation is taken from __nvback_cudaRegisterFatBinary_rpc from
 * remote_api_wrapper and from cudart.c __cudaRegisterFatBinary
 *
 * @return cuda_err set to cudaErrorMemoryAllocation if I cannot calloc the packet
 *
 */
void** r__cudaRegisterFatBinary(void* fatC, int index){
	cuda_packet_t * pPacket;
	// here we will store the number of entries to spare counting again and again
	// @todo might be unimportant
	cache_num_entries_t entries_cached = {0, 0, 0, 0, 0, 0, 0};
	// the size of the packet for cubin
	int fb_size;
	void ** fatCubinHandle = NULL;

	// In original version of the code we created a kind of a structure
	// in a contiguous thing
	// in fact we are allocating the contiguous area of memory that should
	// be treated as a void*, but we want to make it look like the structure
	// __cudaFatCudaBinary; that's why we put it as a __cudaFatCudaBinary
	// and not *void; it will be the serialized version of fatC

	// the original cubin to get rid of casting to __cudaFatCudaBinary
	__cudaFatCudaBinary * pSrcFatC = (__cudaFatCudaBinary *)fatC;
	// the place where the packed fat binary will be stored
	char * pPackedFat = NULL;

	nullExitChkpt(fatC, "NULL CUDA fat binary. Have to exit\n.");

	// allocate and initialize a packet
	if( l_remoteInitMetThrReq(&pPacket, __CUDA_REGISTER_FAT_BINARY, __FUNCTION__) == ERROR){
		exit(ERROR);
	}

	fb_size = getFatRecPktSize(pSrcFatC, &entries_cached);

	p_debug( "FatCubin size: %d\n",fb_size);
	//l_printFatBinary(pSrcFatC);

	pPackedFat = (char*) malloc(fb_size);

	if( mallocCheck(pPackedFat, __FUNCTION__, NULL) == ERROR ){
		exit(ERROR);
	}

	if( packFatBinary(pPackedFat, pSrcFatC, &entries_cached) == ERROR ){
		exit(ERROR);
	}

	// now update the packets information
	pPacket->flags |= CUDA_Copytype;
	pPacket->args[0].argp = pPackedFat;			// start of the request buffer
	pPacket->args[1].argi = fb_size;			// the size of the request buffer

	p_debug( "pPackedFat, pPacket->args[0].argp = %p, %ld\n",
			pPacket->args[0].argp, pPacket->args[1].argi);
	// send the packet
	if (__nvback_cudaRegisterFatBinary_rpc(pPacket, index) != OK) {
		p_critical("Return from rpc with the wrong return value.\n");
		cuda_err = cudaErrorUnknown;
	} else {
		fatCubinHandle = pPacket->ret_ex_val.handle;
		p_debug( "Returned fatCubinHandle = %p\n", pPacket->ret_ex_val.handle);
	}

	free(pPacket);

	return fatCubinHandle;
}

void** l__cudaRegisterFatBinary(void* fatC) {

	static void** (*func)(void* fatC) = NULL;

	l_printFuncSigImpl(__FUNCTION__);

	if (!func) {
		func = dlsym(RTLD_NEXT, "__cudaRegisterFatBinary");

		if (l_handleDlError() != 0)
			exit(-1);
	}

	return (func(fatC));
}




void** __cudaRegisterFatBinary(void* fatC) {

	l_getLocalFromConfig();

  if(DONE==1)
  {
    int i, k=0;
    for(i=0; i < BACKEND_NODES; i++)
    {
        rcudaGetDeviceCount(&DEVICES_IN_NODE[i], i);
        BACKEND_DEVICES+=DEVICES_IN_NODE[i];
        for(; k<BACKEND_DEVICES; k++) {
            DEV_TO_INDEX[k]=i;
            DEV_TO_LOCALDEV[k]= k-(BACKEND_DEVICES-DEVICES_IN_NODE[i]);
        }
    }
	for(i=1; i<=BACKEND_NODES; i++) 
		CUMMULATIVE_FREQ_DEV[i] = CUMMULATIVE_FREQ_DEV[i-1] + DEVICES_IN_NODE[i-1];

	first_local = CUMMULATIVE_FREQ_DEV[first_node];
	
   DONE=2;
  }


	//p_debug( "LOCAL_EXEC=%d (1-local, 0-remote), faC = %p\n", LOCAL_EXEC, fatC);
    int index=0;
    void** ret;
    //ret = l__cudaRegisterFatBinary(fatC);

    fatcubin_handle_counter++;
    while(index<BACKEND_NODES)
    {
        fatcubinhandle_array[fatcubin_handle_counter-1][index]=r__cudaRegisterFatBinary(fatC, index);
        index++;
    }
    
    return(ret);

        
}


void r__cudaUnregisterFatBinary(void** fatCubinHandle, int index) {
	cuda_packet_t * pPacket;
    
	if (l_remoteInitMetThrReq(&pPacket, __CUDA_UNREGISTER_FAT_BINARY,
                              __FUNCTION__) == ERROR) {
		exit(ERROR);
	}
    
	// update packet
	pPacket->args[0].argdp = fatCubinHandle;
    
	if (__nvback_cudaUnregisterFatBinary_rpc(pPacket, index) == ERROR) {
		p_warn("__ERROR__ Return from rpc with the wrong return value.\n");
		// @todo some cleaning or setting cuda_err
		cuda_err = cudaErrorUnknown;
	} else {
		// printRegVarTab(regHostVarsTab);
        
		p_debug("__OK__ Return from rpc with ok value.\n");
	#if 0
		// remove the handler;
		g_vars_remove(regHostVarsTab, fatCubinHandle);
		// destroy the table if the last handler has been removed
		if( regHostVarsTab != NULL && g_hash_table_size(regHostVarsTab)  == 0)
			g_hash_table_destroy(regHostVarsTab);
        #endif
        regHostVarsTab = NULL;
	}
    
	free(pPacket);
}

void l__cudaUnregisterFatBinary(void** fatCubinHandle) {
	typedef void** (* pFuncType)(void** fatCubinHandle);
	static pFuncType pFunc = NULL;
    
	l_printFuncSigImpl(__FUNCTION__);
    
	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "__cudaUnregisterFatBinary");
        
		if (l_handleDlError() != 0)
			exit(-1);
	}
    
	(pFunc(fatCubinHandle));
}

void __cudaUnregisterFatBinary(void** fatCubinHandle) {
	
    //l__cudaUnregisterFatBinary(fatCubinHandle);
    
    int index=0;
    while(index<BACKEND_NODES)
    {
		r__cudaUnregisterFatBinary(fatcubinhandle_array[fatcubin_handle_counter-1][index], index);
        index++;

    }
    fatcubin_handle_counter--;
    
}


void r__cudaRegisterFunction(void** fatCubinHandle, const char* hostFun,
		char* deviceFun, const char* deviceName, int thread_limit, uint3* tid,
		uint3* bid, dim3* bDim, dim3* gDim, int* wSize, int index) {
	cuda_packet_t * pPacket;

	if (l_remoteInitMetThrReq(&pPacket, __CUDA_REGISTER_FUNCTION, __FUNCTION__)
			== ERROR) {
		exit(ERROR);
	}

	l_printRegFunArgs(fatCubinHandle, hostFun, deviceFun, deviceName,
			thread_limit, tid, bid, bDim, gDim, wSize);

	int size = 0;

	char * p = packRegFuncArgs(fatCubinHandle, hostFun, deviceFun, deviceName,
			thread_limit, tid, bid, bDim, gDim, wSize, &size);

	if (!p) {
		p_error("__ERROR__ Problems with allocating the memory. Quitting ... \n");
	}
	// update packet; point to the buffer from which you will
	// take data to send over the network
	pPacket->flags |= CUDA_Copytype;
	pPacket->args[0].argp = p; // buffer pointer
	pPacket->args[1].argi = size; // size of the buffer

	//(void *) packet->args[0].argui, packet->args[1].argi

	if (__nvback_cudaRegisterFunction_rpc(pPacket, index) == OK) {
		// do nothing;
		// @todo don't you need to put some stuff
		// to fatcubin_info_rpc like the functions registered?
		cuda_err = pPacket->ret_ex_val.err;
	} else {
		p_warn("__ERROR__: Return from the RPC with an error\n");
		cuda_err = cudaErrorUnknown;
	}

	free(pPacket);
    
    
    
    
	return;
}

void l__cudaRegisterFunction(void** fatCubinHandle, const char* hostFun,
		char* deviceFun, const char* deviceName, int thread_limit, uint3* tid,
		uint3* bid, dim3* bDim, dim3* gDim, int* wSize) {
	typedef void** (* pFuncType)(void** fatCubinHandle, const char* hostFun,
			char* deviceFun, const char* deviceName, int thread_limit,
			uint3* tid, uint3* bid, dim3* bDim, dim3* gDim, int* wSize);

	static pFuncType pFunc = NULL;

	l_printFuncSigImpl(__FUNCTION__);

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "__cudaRegisterFunction");

		if (l_handleDlError() != 0)
			exit(-1);
	}

	(pFunc(fatCubinHandle, hostFun, deviceFun, deviceName, thread_limit, tid,
			bid, bDim, gDim, wSize));
}

void __cudaRegisterFunction(void** fatCubinHandle, const char* hostFun,
		char* deviceFun, const char* deviceName, int thread_limit, uint3* tid,
		uint3* bid, dim3* bDim, dim3* gDim, int* wSize) {
    
    int index=0;
    
    //l__cudaRegisterFunction(fatCubinHandle, hostFun, deviceFun,
            //deviceName, thread_limit, tid, bid,  bDim,  gDim, wSize);
    
    while(index < BACKEND_NODES)
    {
        r__cudaRegisterFunction(
                                fatcubinhandle_array[fatcubin_handle_counter-1][index],
                                hostFun, deviceFun, deviceName, thread_limit, tid, bid,  bDim,  gDim, wSize, index
                                );
        index++;
    }
    
   
}

void l__cudaRegisterVar(void **fatCubinHandle, char *hostVar,
		char *deviceAddress, const char *deviceName, int ext, int vsize,
		int constant, int global) {
	typedef void** (* pFuncType)(void **fatCubinHandle, char *hostVar,
			char *deviceAddress, const char *deviceName, int ext, int vsize,
			int constant, int global);
	static pFuncType pFunc = NULL;

	l_printFuncSigImpl(__FUNCTION__);

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "__cudaRegisterVar");

		if (l_handleDlError() != 0)
			exit(-1);
	}

	(pFunc(fatCubinHandle, hostVar, deviceAddress, deviceName, ext, vsize,
			constant, global));
}


void r__cudaRegisterVar(void **fatCubinHandle, char *hostVar,
		char *deviceAddress, const char *deviceName, int ext, int vsize,
		int constant, int global, int index) {
	cuda_packet_t * pPacket;

	if (l_remoteInitMetThrReq(&pPacket, __CUDA_REGISTER_VARIABLE, __FUNCTION__)
			== ERROR) {
			exit(ERROR);
	}

//	l_printRegVar(fatCubinHandle, hostVar, deviceAddress, deviceName, ext,
//			vsize, constant, global);

	int size = 0;

	char * p = packRegVar(fatCubinHandle, hostVar, deviceAddress, deviceName, ext,
			vsize, constant, global, &size);

	if (!p) {
		p_error( "__ERROR__ Problems with allocating the memory. Exiting ... \n");
	}

	// do the trick with remembering variables to know if in cudaMemcpyFrom/To
	// Symbol is used a pointer or a variable
	if( NULL == regHostVarsTab ){
		// create a hash table since it doesn't exist
		regHostVarsTab = g_hash_table_new_full(g_direct_hash, g_direct_equal, NULL,
				(GDestroyNotify)g_vars_remove);
	}

	// first check if the key exists
	assert(fatCubinHandle != NULL); 		// we assume the fatCubinHandle is not NULL

	// update packet; point to the buffer from which you will
	// take data to send over the network
	pPacket->flags |= CUDA_Copytype;
	pPacket->args[0].argp = p; // buffer pointer (packed var)
	pPacket->args[1].argi = size; // size of the buffer

	if (__nvback_cudaRegisterVar_rpc(pPacket, index) == OK) {
		cuda_err = pPacket->ret_ex_val.err;
	} else {
		p_warn("__ERROR__: Return from the RPC with an error\n");
		cuda_err = cudaErrorUnknown;
	}

	// construct a value we put the the regHostVarsTab
	g_vars_insert(regHostVarsTab, fatCubinHandle, g_vars_val_new(hostVar, deviceName));

	printRegVarTab(regHostVarsTab);

	free(pPacket);
	return;
}

/**
 * Andrew Kerr: "this function establishes a mapping between global variables
 * defined in .ptx or .cu modules and host-side variables. In PTX, global
 * variables have module scope and can be globally referenced by module and
 * variable name. In the CUDA Runtime API, globals in two modules must not have
 * the same name."
 */
    
//WE ASSUME THAT cudaregistervar() is called AFTER cudaregisterfunction()
    
void __cudaRegisterVar(void **fatCubinHandle, char *hostVar,
		char *deviceAddress, const char *deviceName, int ext, int vsize,
		int constant, int global) {
	l_printRegVar(fatCubinHandle, hostVar, deviceAddress, deviceName, ext,
			vsize, constant, global);

    int index=0;
    //l__cudaRegisterVar(fatCubinHandle, hostVar,
		//deviceAddress, deviceName, ext, vsize, constant, global);
	
    while(index<BACKEND_NODES)
    {
		r__cudaRegisterVar(fatcubinhandle_array[fatcubin_handle_counter-1][index], hostVar,
				deviceAddress, deviceName, ext, vsize, constant, global, index);
        index++;
    }
}

void __cudaRegisterTexture(void** fatCubinHandle,
		const struct textureReference* hostVar, const void** deviceAddress,
		const char* deviceName, int dim, int norm, int ext) {
	typedef void** (* pFuncType)(void** fatCubinHandle,
			const struct textureReference* hostVar, const void** deviceAddress,
			const char* deviceName, int dim, int norm, int ext);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "__cudaRegisterTexture");

		if (l_handleDlError() != 0)
			exit(-1);
	}

	l_printFuncSig(__FUNCTION__);

	(pFunc(fatCubinHandle, hostVar, deviceAddress, deviceName, dim, norm, ext));
}

void __cudaRegisterShared(void** fatCubinHandle, void** devicePtr) {
	typedef void** (* pFuncType)(void** fatCubinHandle, void** devicePtr);
	static pFuncType pFunc = NULL;

	if (!pFunc) {
		pFunc = (pFuncType) dlsym(RTLD_NEXT, "__cudaRegisterShared");

		if (l_handleDlError() != 0)
			exit(-1);
	}

	l_printFuncSig(__FUNCTION__);

	(pFunc(fatCubinHandle, devicePtr));
}
// ---------------------------
// end
// ---------------------------
