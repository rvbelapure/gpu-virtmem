/**
 * @file remote_packet.c
 * @brief copied from
 *
 * @date Mar 3, 2011
 * @author Magda Slawinska, magg __at_ gatech __dot_ edu
 */

#include <debug.h>  // printd
#include "remote_packet.h"
#include "method_id.h"
#include <assert.h>
#include "remote_api_wrapper.h"
#include <cuda.h>   // cudaGetErrorString

extern char * methodIdToString(const int method_id);

int strm_full(strm_t * strm)
{
    if(!strm) {
        printd(DBG_ERROR, "NULL argument\n");
        return -1;
    }

    return (strm->hdr.num_cuda_pkts >= strm->batch_size ? 1 : 0);
}

/**
 * indicates if some data somehow needs to be transferred from the execution
 * place (callee) to the calling (caller); compare with
 * rsp_strm_has_data; seems that they are doing very similar thing,
 * although this asks about the in parameters as well,
 * and rsp_strm_has_data tells that you should receive the
 * extra buffer of response, not only a response
 * via function arguments
 *
 * @return 1 means yes, some data need to be transferred via (rsp_buffer or via
 *          parameters)
 *         0 it doesn't expect the response
 */
int strm_expects_response(strm_t *strm)
{
    int n = strm->hdr.num_cuda_pkts;
    int method_id = strm->rpkts[n-1].method_id;

    switch(method_id)
    {
        case __CUDA_REGISTER_FAT_BINARY:
        case __CUDA_REGISTER_FUNCTION:
        case __CUDA_REGISTER_SHARED:
        case __CUDA_REGISTER_TEXTURE:
        case __CUDA_REGISTER_VARIABLE:
        case CUDA_BIND_TEXTURE_TO_ARRAY:
        case CUDA_UNBIND_TEXTURE:
        case CUDA_MALLOC:
        case CUDA_MALLOC_ARRAY:
        case CUDA_MEMCPY_H2H:
        case CUDA_MEMCPY_H2D:
        case CUDA_MEMCPY_D2H:
        case CUDA_MEMCPY_D2D:
        case CUDA_MEMCPY_TO_ARRAY_H2H:
        case CUDA_MEMCPY_TO_ARRAY_H2D:
        case CUDA_MEMCPY_TO_ARRAY_D2H:
        case CUDA_MEMCPY_TO_ARRAY_D2D:
        case CUDA_MEMCPY_TO_SYMBOL:
        case CUDA_MEMCPY_FROM_SYMBOL:
        case CUDA_MEMCPY_2D_TO_ARRAY_H2H:
        case CUDA_MEMCPY_2D_TO_ARRAY_H2D:
        case CUDA_MEMCPY_2D_TO_ARRAY_D2H:
        case CUDA_MEMCPY_2D_TO_ARRAY_D2D:
        case CUDA_GET_DEVICE_COUNT:
        case CUDA_GET_DEVICE_PROPERTIES:
        case CUDA_GET_DEVICE:
        case CUDA_THREAD_SYNCHRONIZE:
        //case CUDA_SETUP_ARGUMENT:
             return 1;
             break;
        // asynchronous calls that return to the client immediately
        // CUDA_FREE
        // CUDA_SETUP_ARGUMENT
        // CUDA_CONFIGURE_CALL
        // CUDA_LAUNCH
        // CUDA_SET_DEVICE
        default:
        	break;
    }
    return 0;
}

int strm_flush_needed( strm_t * strm )
{
    typedef enum REASON {
		STREAM_FULL = 0, SYNC_FUNC_SEEN, UNKNOWN
	} reason_t;

	reason_t r;
	r = UNKNOWN;

	if (!strm) {
		p_critical("NULL argument\n");
		return -1;
	}

	if (strm_full(strm)) {
		r = STREAM_FULL;
	} else if (strm_expects_response(strm)) {
		r = SYNC_FUNC_SEEN;
	} else {
		r = UNKNOWN;
	}

	return (UNKNOWN == r ? 0 : 1);
}

/*int req_strm_has_data(strm_t * strm)
{
    int ret_val = 0;
    rpkt_t * last_pkt = NULL;

    rpkt_t *pkts;
    int num_cuda_pkts;
    pkts    = strm->rpkts; // don't need to check for NULL, it is a static array
    num_cuda_pkts  = strm->hdr.num_cuda_pkts;

    if(!strm) {
        printd(DBG_ERROR, "NULL argument\n" );
        return -1;
    }

    assert(num_cuda_pkts > 0);

    last_pkt = &pkts[ num_cuda_pkts - 1 ];

    // Based on the method, select the appropriate argument index in the packet
    // Use last packet in stream (property of batching)
    switch( last_pkt->method_id )
    {
           case __CUDA_REGISTER_FAT_BINARY:
           case __CUDA_REGISTER_FUNCTION:
           case __CUDA_REGISTER_VARIABLE:
           case __CUDA_REGISTER_TEXTURE:
           case __CUDA_REGISTER_SHARED:
           case CUDA_MEMCPY_H2D:
           case CUDA_MEMCPY_TO_SYMBOL:
           case CUDA_MEMCPY_TO_ARRAY_H2D:
           case CUDA_MEMCPY_2D_TO_ARRAY_H2D:
           case CUDA_SETUP_ARGUMENT:
               ret_val = 1;
               break;
           default:   // no data to be transferred in the request
              break;
    }

    return ret_val;
} */

/**
 * Checks method needs to transfer some  data in response.
 * Apparently there is not much method that need to transfer data
 *
 * @param strm The stream that contains the method id to be checked
 * @return 0 The method (therefore a strm) doesn't require the data
 *           to be transferred in response
 *         1 Otherwise (the data are required to be transferred)
 */
/*int rsp_strm_has_data(const strm_t * strm)
{
    int n = strm->hdr.num_cuda_pkts;
    int method_id = strm->rpkts[n-1].method_id;

    switch(method_id)
    {
        case CUDA_MEMCPY_D2H:
        case CUDA_MEMCPY_TO_ARRAY_D2H:
        case CUDA_MEMCPY_2D_TO_ARRAY_D2H:
        case CUDA_GET_DEVICE_PROPERTIES:
            return 1;
            break;
        default:   // no data to be transferred in response
            break;
    }

    return 0;
}*/



//
// Stream execution (server)
//

rpkt_t *pkt_execute(rpkt_t *rpkt, conn_t * pConn)
{
    p_debug("\tcalling function %s, id=%d\n", methodIdToString(rpkt->method_id),
    		rpkt->method_id);

    // FIXME Use the provided function table instead of this large switch statement.
    switch (rpkt->method_id) {
    case CUDA_MALLOC:
    	nvbackCudaMalloc_srv(rpkt, pConn);
    	break;

	case CUDA_GET_DEVICE_COUNT:
		nvbackCudaGetDeviceCount_srv(rpkt, pConn);
		break;

	case CUDA_GET_DEVICE_PROPERTIES:
		nvbackCudaGetDeviceProperties_srv(rpkt, pConn);
		break;

	case CUDA_GET_DEVICE:
		nvbackCudaGetDevice_srv(rpkt, pConn);
		break;

	case CUDA_SET_DEVICE:
		nvbackCudaSetDevice_srv(rpkt, pConn);
		break;

	case CUDA_FREE:
		nvbackCudaFree_srv(rpkt, pConn);
		break;

	case CUDA_SETUP_ARGUMENT:
		nvbackCudaSetupArgument_srv(rpkt, pConn);
		break;

	case CUDA_CONFIGURE_CALL:
		nvbackCudaConfigureCall_srv(rpkt, pConn);
		break;

	case CUDA_LAUNCH:
		nvbackCudaLaunch_srv(rpkt, pConn);
		break;

	case CUDA_MEMCPY_H2H:
	case CUDA_MEMCPY_H2D:
	case CUDA_MEMCPY_D2H:
	case CUDA_MEMCPY_D2D:
		nvbackCudaMemcpy_srv(rpkt, pConn);
		break;

	case CUDA_MEMCPY_TO_SYMBOL:
		nvbackCudaMemcpyToSymbol_srv(rpkt, pConn);
		break;

	case CUDA_MEMCPY_FROM_SYMBOL:
		nvbackCudaMemcpyFromSymbol_srv(rpkt, pConn);
		break;

	case CUDA_THREAD_SYNCHRONIZE:
		nvbackCudaThreadSynchronize_srv(rpkt, pConn);
		break;

	case CUDA_THREAD_EXIT:
		nvbackCudaThreadExit_srv(rpkt, pConn);
		break;

	case __CUDA_REGISTER_FAT_BINARY:
		__nvback_cudaRegisterFatBinary_srv(rpkt, pConn);
		break;

	case __CUDA_REGISTER_FUNCTION:
		__nvback_cudaRegisterFunction_srv(rpkt, pConn);
		break;

	case __CUDA_REGISTER_VARIABLE:
		__nvback_cudaRegisterVar_srv(rpkt, pConn);
		break;

	case __CUDA_UNREGISTER_FAT_BINARY:
		__nvback_cudaUnregisterFatBinary_srv(rpkt, pConn);
		break;

	default:
		p_critical( "__ERROR__: Unknown method ID %d\n", rpkt->method_id);
		rpkt->flags = CUDA_error;
		rpkt->ret_ex_val.err = cudaErrorInvalidValue;
		break;
	}

    if(rpkt->method_id != __CUDA_REGISTER_FAT_BINARY)
        if(0 != rpkt->ret_ex_val.err)
            p_critical("__ERROR__: method returned an error %d, %s\n", rpkt->ret_ex_val.err,
            		cudaGetErrorString(rpkt->ret_ex_val.err));

    return rpkt;
}

void strm_execute(strm_t *strm, conn_t *pConn)
{

    int num_cuda_pkts = 0, i = 0;
    rpkt_t *rpkts = NULL;

    if(!strm) {
        printd(DBG_ERROR, "Error null argument\n");
        return;
    }

    num_cuda_pkts = strm->hdr.num_cuda_pkts;
    rpkts   = strm->rpkts;

    for(i = 0; i < num_cuda_pkts; i++) {
        pkt_execute(&rpkts[i], pConn);
        printd(DBG_DEBUG, "last error = %d for method id <%d>.\n", rpkts[i].ret_ex_val.err, rpkts[i].method_id);
    }
}


