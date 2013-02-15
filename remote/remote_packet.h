/**
 * @file remote_packet.h
 * @brief copied from remote_gpu/network/remote_packet.h
 *
 * @date Feb 23, 2011
 * @author Magda Slawinska, magg@gatech.edu
 */

#ifndef REMOTE_PACKET_H_
#define REMOTE_PACKET_H_


#include "packetheader.h"  // cuda_packet_t
#include "connection.h"		// conn_t
#include "remote_packet_types.h"  // strm_t

int strm_full(strm_t * strm);
int strm_expects_response(strm_t *strm);
int strm_flush_needed( strm_t * strm );
//int req_strm_has_data(strm_t * strm);
//int rsp_strm_has_data(const strm_t * strm);

// compilation problems with if conn_t is included
rpkt_t *pkt_execute(rpkt_t *rpkt, conn_t *pConn);
void strm_execute(strm_t *strm, conn_t * pConn);


#endif /* REMOTE_PACKET_H_ */
