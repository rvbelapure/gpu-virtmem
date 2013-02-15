/**
 * @file connection.h
 * @brief Provides implementation of network related functions
 * copied from remote_gpu/network/network.h
 * @date Feb 23, 2011
 * @author Magda Slawinska, magg@gatech.edu
 */

#ifndef CONNECTION_H_
#define CONNECTION_H_


#include "rconfig.h"
#include <netinet/in.h>
#include "packetheader.h"
#include "remote_packet_types.h" 		// strm_t; if you include this as the first
								// include the compilation errors appear


// Connection directions. These of course are with respect to the location of the dom0 containing
// this connection table. Each connection will have an associated entry in the remote server table, but
// with the opposite direction.
typedef enum connection_type {
    UNUSED = 0,
    INCOMING,   // servicing a remote guest domain
    OUTGOING    // offloading work to a remote machine
} conn_type_t;

typedef int             socket_t;  // just to make the code more legible
//typedef pthread_mutex_t ctlock_t;  // lock for entire connection table

/**
 * Each backend maintains one table consisting of these. Each struct represents one connection,
 * either coming into or going out from the machine on which the backend is physically located on.
 * Each entry will have two instances, one on each machine participating in the connection.
 *
 * Be careful with using this structure. request_data_buffer and response_data_buffer
 * might overflow the stack if used as local variables. So this structure might
 * be allocated as globally as a global variable or maybe on the heap, i.e., in
 * a memory region dedicated for dynamic memory allocations. The behavior of the program
 * you might expect if you are using this structure inappropriately is the segmentation
 * fault when program runs, even if your program does nothing apart from
 * declaring e.g. conn_t a, b; in a function (including also main()).
 * So be careful in which region the memory for this structure will be allocated: heap,
 * stack or permanent storage area. And likely it shouldn't be allocated on stack, since
 * your program might experience seg fault.
 *
 * Default stack limit is 10MB ($ ulimit -a) . conn_t big buffers allocate 8MB at least
 * per one struct; if I use two local variables conn_t then there is stack overflow
 * and a program crashes with segmentation fault. So there are a couple of solutions
 * 1. allocate only one conn_t locally (one conn_t per function)
 * 2. allocate it not on a stack
 *   a. globally
 *   b. or on a heap
 * 3. increase the stack limit ($ulimit -s or sys/resource.h rlim_t, getrlimit()/setrlimit)
 */
typedef struct connection
{
    int                 valid;      // true if this structure is associated with a live connection
    pthread_t           tid;        // associated thread ID, remote or local

    struct sockaddr_in  *address;
    socklen_t           address_len;
    int                 address_family;

    socket_t            socket;     // socket to connect to on this machine for remote communcation
    int                 socktype, protocol;   // and its type/protocol

    conn_type_t         type;
    strm_t              strm;
    //network_state_t     state;      // TODO (implement this) state this connection is in

    // TODO Instead of statically allocating these, create pointers. During connection
    // reservation/unreservation they can become allocated and deallocated for use.
 //   char request_data_buffer[TOTAL_XFER_MAX];
 //   char response_data_buffer[TOTAL_XFER_MAX];

    // the pointers held the  dynamically allocated memory required by the
    // extra buffer for requests or responses, respectively
    // @todo they should eventually should substitute the request_data_buffer
    // and response_data_buffer
    // you are responsible for allocating and releasing the request
    // and response buffers.
    char * pReqBuffer;
    char * pRspBuffer;

    // sizes of the request and response buffers, respectively
    int request_data_size;
    int response_data_size;

    cudaError_t lastCudaErrorRemote;

} conn_t;

/**
 * Sends the cuda packet header over the connection pConn
 * @param pConn The connection we use to send the packet
 * @param num_cuda_pkts say how many cuda packets you promise to send
 * @param buf_size The size of the buffer (response or request)
 * @return OK if everything went ok
 *         ERROR there were problems with sending the packet of network
 */
int conn_sendCudaPktHdr(conn_t * pConn, const uint32_t num_cuda_pkts, const int
		buf_size);


/**
 * Allocates the memory for the connection;
 * @param pFuncName The name of the function
 * @param pExtraMsg The extra information you want to print
 * @return myconn The allocated place for myconn
 *         NULL
 */
conn_t * conn_malloc(const char* const pFuncName, const char* const pExtraMsg);

/**
 * Connect to a machine/port using the specified information. Populates the
 * connection object if return value is success (0).
 * @param pConn Connection
 * @param pRemoteHost
 */
int conn_connect(conn_t *conn, const char *remote_host, int flag);

/**
 * Simply close the connection (the socket within this structure).
 */
int conn_close( conn_t *conn );

/**
 * Set up a connection to be bound to the localhost. After calling this function, accept() can be
 * called on the contained socket.
 *
 * The function will fill the listen_conn with the information about the host
 *
 * @param listen_conn (out) This parameter will be filled with the information about
 *        our listening side connection such as hostname, listening port, etc)
 * @return execution status (0 - 0k, -1 problems)
 */
int conn_localbind(conn_t *listen_conn, int flag);

/**
 * Accept a new connection (for the listening thread)
 *
 * First should be called conn_localbind before accept can be called.
 * It is because, conn_localbind initializes appropriately the listen_conn
 *
 * @param listen_conn (in) the info about our listener
 * @param new_conn (out) this information is filled by the communication layer
 *        and contains data about peer socket connection
 * @return execution status
 */
int conn_accept(conn_t *listen_conn, conn_t *new_conn);


/*
 *  Put (send) data.
 *  @todo Put and Send should probably accept remote packets, not all this fine-grained detail. Maybe
 *  call it put_strm.
 *
 * @param conn (out) where the data will be put
 * @param msg (in) what data will be put to conn
 * @param int (in) what is the size of the data to be put
 * @todo strange return values
 * @return -EINVAL
 *         0 if sent finished
 *         1 normal exit from the function
 */
int put( conn_t *conn, void *msg, int len );

/**
 * Get (receive) data.
 * @todo Put and Send should probably accept remote packets, not all this fine-grained detail. Maybe
 * call it recv_strm.
 *
 * @param conn
 * @param msg
 * @param len
 * @todo strange return values
 * @return -EINVAL
 *         0 if sent finished
 *         1 normal exit from the function
 */
int get(conn_t *conn, void *msg, int len);
#endif /* CONNECTION_H_ */
