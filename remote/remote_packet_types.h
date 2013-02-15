/**
 * @file remote_packet_data.h
 * @brief copied from remote_gpu/network/remote_packet.h. I needed to split this
 * because there was a circular conflict with including headers
 *
 * @date Mar 9, 2011
 * @author Magda Slawinska, magg __at_ gatech __dot_ edu
 */

#ifndef REMOTE_PACKET_DATA_H_
#define REMOTE_PACKET_DATA_H_

#include "packetheader.h"  // cuda_packet_t
#include "rconfig.h"       // MAX_REMOTE_BATCH_SIZE


// reusing cuda_packet_t.ret_ex_val.data_unit as data offset for remote request batching.
typedef cuda_packet_t rpkt_t;

typedef struct remote_packet_stream_hdr
{
    uint32_t num_cuda_pkts;
    uint32_t data_size;
} strm_hdr_t;

typedef struct remote_packet_stream
{
    uint32_t batch_size; // HACK but need this here for strm_flush_needed() function to have access to this dynamic value. SHOULD NOT MEMSET OR REASSIGN THIS FIELD
    strm_hdr_t hdr;
    rpkt_t rpkts[MAX_REMOTE_BATCH_SIZE];
} strm_t;


#endif /* REMOTE_PACKET_DATA_H_ */
