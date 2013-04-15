/**
 * @file packetheader.h
 * @brief copied from remote_gpu/include/packetheader.h and modified
 *
 * @date Feb 23, 2011
 * @author Magda Slawinska, magg@gatech.edu
 */

#ifndef PACKETHEADER_H_
#define PACKETHEADER_H_

typedef unsigned char uint8_t;
typedef unsigned short int uint16_t;
typedef unsigned int uint32_t;
typedef long int64_t;
typedef unsigned long uint64_t;
typedef uint32_t grant_ref_t;

// if including from driver, manually define. but ***make sure*** it
// remains consistent with nvidia definition
// Assuming enum is defined as int everywhere
//typedef int cudaError_t;

// include this file when not compiling from frontend driver
// some crappy make issues due to include dependencies and path messup
#include <driver_types.h>
#include <vector_types.h>

#include <pthread.h>
#include <sys/time.h>

typedef pthread_t tid_t;


#define MAX_ARGS 4       // most cuda calls so far

// Possible flag values
// request - from DomU to Dom0
// response - from Dom0 to DomU
// \todo Possible to define 4 more flags - may correspond to type of error
#define CUDA_response 0x1
#define CUDA_request 0x2
#define CUDA_more_data 0x4
#define CUDA_error 0x8

// For faster checking for {Memcpy, SetupArgument, Launch, GetDevice props}
// mark the flags value with this. The actual function can then be retrieved
// using the method id
#define CUDA_Copytype 0x10

// Sometimes it may not be required from the backend that it map the pages being
// passed because they have already been mapped at handshake time
// Since ret_ex_val in cuda_packet_t is the only field in the packet which is
// not interpreted at the time of frontend calling backend,
// using this field to indicate to the backend whether it should
// bother calling xc_map_foreign_range or not.
// And this needs to be looked at only in cases of those calls which require
// a buffer passing
// Therefore, if this position in flag is set, it would mean address is already
// mapped else mapping needs to be done
#define CUDA_Addrmapped 0x20

// Indicate whether this buffer was allocated with cudaMallocHost or usual
// malloc. If former, then no copying of buffer is required for the calls that
// need to use this
#define CUDA_Addrshared 0x40

// Values within the driver to indicate whether mapping of buffer was done or not
#define ADDR_ALREADY_MAPPED 0x1
#define ADDR_UNMAPPED 0x2

// Possible data size units. These are used to mark the ret_ex_val field as and
// when needed in calls from frontend to backend. The reason the field is not
// getting used as size itself is that their could be more than one argument
// that needs to specify the size. So leaving size in the args array instead
// of putting in ret_ex_val. Also, the unit will be constant for any number of
// fields that specify data. Therefore use the max granularity possible to avoid
// extra copy and wrong arguments. These units can be used as multiplies to get
// the real size whenever needed. There are multiple granularities to avoid
// extra copying as far as possible
#define DATA_UNIT_1BYTE 1
#define DATA_UNIT_2BYTE 2
#define DATA_UNIT_3BYTE 3
#define DATA_UNIT_4BYTE 4
#define DATA_UNIT_5BYTE 5
#define DATA_UNIT_6BYTE 6
#define DATA_UNIT_7BYTE 7
#define DATA_UNIT_8BYTE 8
#define DATA_UNIT_PAGES 4096
#define DATA_UNIT_KB 1024
#define DATA_UNIT_MB (1024 * 1024)
#define DATA_UNIT_GB (1024 * 1024 * 1024)

#define MAX_SIZE_SIZE 65535   // max number that size var can take

typedef struct tf_arg {
	// \todo For now following ring mechanism and using mfns straight
//	grant_ref_t gref;   // Reference to page with data
	unsigned long mfn;  // Granted mfn
	uint32_t ref;       // need to maintain grant ref for ending foreign access
	uint16_t offset;    // offset within the page
	// This size can be in different units as indicated by the extra info
	// and should be interpreted accordingly
	uint16_t size;      // size from offset, if it goes beyond a page,
			// means those pages will also be granted already
} tf_args_t;

// The cudaRegisterFunction() has 10 arguments. Instead of passing them in multiple
// packet rounds, it is serialized onto as many pages and can be accessed by
// using this struct
typedef struct {
	void** fatCubinHandle;
	char* hostFun;
	// the hostFEaddr is used to keep the local pointer to the hostFun
	// this is retrieved when launch is called; this is only the pointer
	// not the string
	char* hostFEaddr;  // original Key in BE to retrieve when launch is called
    char* deviceFun;
	char* deviceName;
	int thread_limit;
	uint3* tid;
    uint3* bid;
	dim3* bDim;
	dim3* gDim;
	int* wSize;
} reg_func_args_t;

// The __cudaRegisterVar() has 8 arguments. Pass them in one page
typedef struct {
	void **fatCubinHandle;
	char *hostVar;  // Address coming from Guest thru RegisterVar
	char *dom0HostAddr;  // This addr will be registered with cuda driver instead
	char *deviceAddress;
	char *deviceName;
	int ext;
	int size;
	int constant;
	int global;
} reg_var_args_t;

// The __cudaRegisterTex() has 8 arguments. Pass them in one page
typedef struct {
	void **fatCubinHandle;
	struct textureReference *hostVar;  // Address coming from Guest thru RegisterTexture
	struct cudaChannelFormatDesc *hostChannel;  // Note this down as well
	struct textureReference *hostFEVar;  // This addr will be registered with cuda driver instead
	void **deviceAddress;
	char *deviceName;
	int dim;
	int norm;
	int ext;
} reg_tex_args_t;

// Arguments to functions can either be a simple argument or grant reference
// Left to the function to decipher
// Arguments will be filled in the order as in function declaration
// Currently this union has the possible arguments seen in common CUDA calls
typedef union args {
	int arr_argii[4];
	unsigned int arr_arguii[4];
	int64_t argi;
	uint64_t argui;
	float argf;
	void *argp;
	void **argdp;
	char *argcp;
	size_t arr_argi[2];  // to combine multiple args wherever possible to keep total
				// args restricted to 4
	uint64_t arr_argui[2];  // anyway the union is of size 128 due to tf_args
	tf_args_t tf_args;
	dim3 arg_dim;      // This does increase the size of the union but what to do
	cudaStream_t arg_str;
	reg_func_args_t *reg_func_args;
	reg_var_args_t *reg_vars;
	reg_tex_args_t *reg_texs;
} args_t;

// Possible return types in a response or some extra information on the way to
// the backend
typedef union ret_extra {
	int num_args;       // tells backend the number of args in case of map_pages_in_backend
	int bit_idx;        // Pass idx into bitmap for mmap cases (HACK)
	uint32_t data_unit; // tells how to interpret size
	cudaError_t err;    // most common return type
	cudaError_t *errp;  // return type for cudaMalloc so far
	const char *charp;  // seen this one somewhere
	void **handle;	    // Used to return fatCubinHandle
} ret_extra_t;

typedef struct cuda_packet {
	uint16_t method_id;     // to identify which method
	uint16_t req_id;        // to identify which request is the response for in case async
	tid_t thr_id;           // thread sending request
	uint8_t flags;          // if ever needed to indicate more data for the same call
	args_t args[MAX_ARGS];  // arguments to be copied on ring
	ret_extra_t ret_ex_val; // return value from call filled in response packet
							// when coming from backend or extra information from
							// frontend
	int signo;

	// l2feedback data
	int is_feedback_packet;
	int node;
	int devid;
	int app_type;
	float total_ex_time, sys_time, usr_time;
	long cuda_kernel_launches;
	struct timeval kernel_time, non_kernel_time;

	// vitual mem map
	void **vmmap;
} cuda_packet_t;


#endif /* PACKETHEADER_H_ */
