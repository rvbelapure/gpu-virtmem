/**
 * @file rconfig.h
 * @brief Constants for the network module, copied from
 * remote_gpu/network/rconfig.h
 *
 * @date Feb 23, 2011
 * @author Magda Slawinska, magg@gatech.edu
 */

#ifndef RCONFIG_H_
#define RCONFIG_H_

//
// Configuration options for the remoting infrastructure
//

// The port clients request remote execution on.
// This must be a string literal and specified in decimal.
#define ADMISSION_PORT                      "1024"
#define SCHED_ADMISSION_PORT                "1025"

// Length for all hostnames.
#define HOSTNAME_STRLEN                     256

// Size of the table and number of threads allowed to run.
#define MAX_REMOTE_CONNECTIONS              8

// Size of queue for incoming requests
#define REMOTE_THREAD_BACKLOG               8

// Size of the buffer a service thread has, in bytes
#define REMOTE_SERVICE_THREAD_BUFFER_SIZE   1024

// Bytes limit for a complete PUT() or GET() operation
#define TOTAL_XFER_MAX                   4194304

// Bytes each send/recv should attempt
#define PER_XFER_MAX                        1024

// For "batching" requests.
#define MAX_EXTRA_ARGS          4
#define MAX_REMOTE_BATCH_SIZE   1024

// Direction of any transfer of data.
typedef enum direction { SEND, RECV } direction_t;


#endif /* RCONFIG_H_ */
