/**
 * @file network.c
 * @brief Provides network related functions
 * copied from remote_gpu/network/network.c
 * @date Feb 23, 2011
 * @author Extended and modified by Magda Slawinska, magg@gatech.edu
 */

#include "connection.h"
#include <netdb.h>  // struct addrinfo
#include "debug.h"
#include <stdio.h>
#include <string.h> // memset()
#include <stdlib.h> // calloc()
#include <errno.h>  // errno
#include <unistd.h>

#include "libciutils.h"
#include <assert.h>


/**
 * Sends the cuda packet header over the connection pConn
 * @param pConn The connection we use to send the packet
 * @param num_cuda_pkts say how many cuda packets you promise to send
 * @param sends the size of the buffer (response or request)
 * @return OK if everything went ok
 *         ERROR there were problems with sending the packet of network
 */
int conn_sendCudaPktHdr(conn_t * pConn, const uint32_t num_cuda_pkts, const int
		buf_size){
	strm_hdr_t * pHdr = &pConn->strm.hdr;

	// prepare data for the header
	pHdr->num_cuda_pkts = num_cuda_pkts;
	pHdr->data_size = buf_size;

	// send request header (including data size) for the batch of remote packets
	// 1 is the normal put exit
	if (1 != put(pConn, pHdr, sizeof(strm_hdr_t))) {
		p_debug( "Problems with sending the request header.\n");
		return ERROR;
	}

	p_debug("Header sent: pkt_num %d, extra buffer size: %d.\n",
			pHdr->num_cuda_pkts, pHdr->data_size);

	return OK;
}

/**
 * Allocates the memory for the connection;
 * @return myconn The allocated place for myconn
 *         NULL
 */
conn_t * conn_malloc(const char* const pFuncName, const char* const pExtraMsg){
	conn_t * myconn = malloc(sizeof(conn_t));

	if( mallocCheck(myconn, pFuncName, pExtraMsg) != 0)
		myconn = NULL;

	return myconn;
}


/**
 *  Establish a connection (for local domUs to go remote)
 *  @param conn
 *  @param remote_host
 *  @return 0 everything ok
 *          -1 problems
 *
 */
int conn_connect(conn_t *conn, const char *remote_host, int flag) {
    int ret_val = 0;

    // Socket-related state
    struct addrinfo hints, *results = NULL;

    // for the re-entrant errno function calls
    int errno_str_size = 128;
    char errno_str[errno_str_size];

    if(!conn || !remote_host) {
        printd(DBG_ERROR, "Error: NULL args\n");
        return -1;
    }

    // Query host information.
    memset(&hints, 0, sizeof(hints));
    hints.ai_family      = AF_UNSPEC;
    hints.ai_socktype    = SOCK_STREAM;
    char *port = ADMISSION_PORT;
    if(flag) port = SCHED_ADMISSION_PORT; 

    if(0 != getaddrinfo(remote_host, port, &hints, &results)) {
        printd(DBG_ERROR, "Error: could not setup remote server connection. getaddrinfo failed.\n");
        goto client_connect_error;
    }
    if(!results) {
        printd(DBG_ERROR, "Error: getaddrinfo returned NULL results\n");
        goto client_connect_error;
    }

    // Store the first result to our connection structure.
    conn->address_family = results->ai_family;
    conn->socktype = results->ai_socktype;
    conn->protocol = results->ai_protocol;
    conn->address_len = results->ai_addrlen;
    conn->address = calloc(1, results->ai_addrlen);
    if(!conn->address) {
        printd(DBG_ERROR, "Error: Out of memory\n");
        return -1;
    }
    memcpy(conn->address, results->ai_addr, conn->address_len);
    free(results); // getaddrinfo() malloc's this
    results = NULL;

    // Obtain a new socket from the kernel.
    conn->socket = socket(conn->address_family, conn->socktype, conn->protocol);
    if(conn->socket < 0) {
        strerror_r(errno, errno_str, errno_str_size);
        printd(DBG_ERROR, "Error: socket failed: %s\n", errno_str);
        goto client_connect_error;
    }

    printd(DBG_DEBUG, "Socket = %d\n", conn->socket);

    // Converts a packed internet address to a human readable
    //inet_ntop(conn->address_family, &(((struct sockaddr *)conn->address)->sin_addr),
    //        inet_ntop_hostname, 256);
    //printd(DBG_INFO, "Trying to connect to %s:%s\n", inet_ntop_hostname, ADMISSION_PORT);

    // Establish a TCP connection.
    if(0 != connect(conn->socket, (struct sockaddr *)conn->address, conn->address_len)) {
        strerror_r(errno, errno_str, errno_str_size);
        printd(DBG_ERROR, "Error: connect() failed: %s\n", errno_str);
        goto client_connect_error;
    }

    ret_val = 0;
    goto client_connect_exit;

client_connect_error: // something went wrong, clean up and fall-through to exit
    if(-1 != conn->socket)
        close(conn->socket);
    conn->socket = -1;
    if(results)
        free(results);
    ret_val = -1;

client_connect_exit:
    return ret_val;
}

/**
 * Close a connection
 * @param conn connection to be closed
 * @return 0 ok, -1 problems
 */
int conn_close( conn_t *conn ) {
    if( ! conn ) return -1;

    if( conn->socket > 0 ) close( conn->socket );
    conn->socket = -1;

    free(conn->address);
    conn->address = NULL;

    return 0;
}
/**
 * Set up a connection to be bound to the localhost. After calling this function, accept() can be
 * called on the contained socket.
 *
 * @param listen_conn
 * @return execution status (0 - 0k, -1 problems)
 */
int conn_localbind(conn_t *listen_conn, int flag)
{
    int err = 0;
    int serverfd = -1; /* parent socket */
    int optval; /* flag value for setsockopt */

    int errno_str_size = 128;
    char errno_str[errno_str_size];

    struct addrinfo hints, *servaddrinfo;
    char servername[HOSTNAME_STRLEN];

    if(!listen_conn) {
        printd(DBG_ERROR, "Error: NULL arg\n");
        return -1;
    }
    memset(errno_str, 0, errno_str_size * sizeof(char));

    memset(servername, 0, HOSTNAME_STRLEN * sizeof(char));
    gethostname(servername, HOSTNAME_STRLEN);
    printd(DBG_INFO, "Queried for hostname: %s\n", servername);

    memset(&hints, 0, sizeof(struct addrinfo));
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE; //use my IP
    char *port = ADMISSION_PORT;
    if(flag)
	port = SCHED_ADMISSION_PORT;

    err = getaddrinfo(NULL, port, &hints, &servaddrinfo);
    if(err != 0) {
        printd(DBG_ERROR, "getaddrinfo() failed. Error: %s\n", gai_strerror(err));
        goto conn_localbind_error;
    }
    serverfd = socket(servaddrinfo->ai_family, servaddrinfo->ai_socktype, servaddrinfo->ai_protocol);
    if (serverfd < 0) {
        printd(DBG_ERROR, "socket() failed. \n");
        goto conn_localbind_error;
    }
    optval = 1;
    if(0 > setsockopt(serverfd, SOL_SOCKET, SO_REUSEADDR, (const void *)&optval , sizeof(int))) {
        goto conn_localbind_error;
    }
    if(0 > bind(serverfd, (struct sockaddr *)servaddrinfo->ai_addr, servaddrinfo->ai_addrlen)) {
        close(serverfd);
        printd(DBG_ERROR, "bind() failed. Error: %s\n", strerror(errno));
        goto conn_localbind_error;
    }

    // TODO probably don't need these in the future
    listen_conn->socket         = serverfd;
    listen_conn->socktype       = servaddrinfo->ai_socktype;
    listen_conn->protocol       = servaddrinfo->ai_protocol;
    listen_conn->address_len    = servaddrinfo->ai_addrlen;
    listen_conn->address_family = servaddrinfo->ai_family;
    listen_conn->address        = calloc(1, servaddrinfo->ai_addrlen);
    if(!listen_conn->address) {
        printd(DBG_ERROR, "Error: Out of memory\n");
        return -1;
    }
    memcpy(listen_conn->address, servaddrinfo->ai_addr, servaddrinfo->ai_addrlen );
    freeaddrinfo(servaddrinfo);
    servaddrinfo = NULL;

    // Listen for incoming requests; not a blocking call
    if(0 > listen(serverfd, REMOTE_THREAD_BACKLOG)) {
        strerror_r(errno, errno_str, errno_str_size);
        printd(DBG_ERROR, "Error calling listen on socket %d: %s\n", serverfd, errno_str);
        goto conn_localbind_error;
    }

    return 0;

conn_localbind_error:
    if(-1 != serverfd)
        close(serverfd);
    if(servaddrinfo) {
        freeaddrinfo(servaddrinfo);
        servaddrinfo = NULL;
    }
    return -1;
}

/**
 * Accept a new connection (for the listening thread)
 * @param listen_conn listening connection
 * @param new_conn receiving connection
 * @return execution status
 */
int conn_accept(conn_t *listen_conn, conn_t *new_conn)
{
    int ret_val = -1;

    // for the re-entrant errno function calls
    int errno_str_size = 128;
    char errno_str[errno_str_size];

    // new_conn must have been returned from a call to ctable_reserve()
    if(!listen_conn || !new_conn)
        return -1;

    // wait for a new connection - blocking call
    memset(&new_conn->address, 0, sizeof(struct sockaddr_in));
    new_conn->address_len = 0;
    new_conn->socket =
        accept(listen_conn->socket, (struct sockaddr *)&new_conn->address, &new_conn->address_len);
    if(-1 == new_conn->socket) {
        strerror_r(errno, errno_str, errno_str_size);
        printd(DBG_ERROR, "Error accepting new connection: %s\n", errno_str);
        goto conn_accept_error;
    }

    printd(DBG_INFO, "Got new incoming connection\n");

    ret_val = 0;
    goto conn_accept_exit;

conn_accept_error:
    ret_val = -1;

conn_accept_exit:
    return ret_val;
}

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
int put( conn_t *conn, void *msg, int len ) {
    char *msg_ptr = (char *)msg;    // place holder in msg
    int sent = 0;                  // bytes transferred on each send()
    int remain = len;              // bytes (<= len) remaining to send

    if(!conn || conn->socket < 0 || !msg || len < 0) {
        printd(DBG_ERROR, "Invalid arguments\n");
        return -EINVAL;
    }
    while(remain > 0) {
        sent = send(conn->socket, msg_ptr, (remain > PER_XFER_MAX ? PER_XFER_MAX : remain), 0);
        if( sent <= 0 )
            return sent; // error (< 0) or finished (= 0)
        remain -= sent;
        msg_ptr += sent;
    }

    return 1;
}

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
int get(conn_t *conn, void *msg, int len)
{
    char *msg_ptr = (char *)msg;    // place holder in msg
    int recvd = 0;                  // bytes transferred on each recv()
    int remain = len;              // bytes (<= len) remaining to recv

    if( ! conn || conn->socket < 0 || ! msg || len < 0) {
        printd(DBG_ERROR, "Invalid arguments\n");
        return -EINVAL;
    }

    while(remain > 0) {
        recvd = recv(conn->socket, msg_ptr, (remain > PER_XFER_MAX ? PER_XFER_MAX : remain), 0);
        if( recvd <= 0 ) return recvd; // error (< 0) or finished (= 0)
        remain -= recvd;
        msg_ptr += recvd;
    }

    return 1;
}

