/**
 * @file backend.c
 * @brief The executor of cuda calls
 *
 * based on : void * nvback_rdomu_thread(void *arg)
 * from remote_gpu/nvidia_backend/remote/remote_api_wrapper.c
 *
 * @date Mar 8, 2011
 * @author Magda Slawinska, magg __at_ gatech __dot_ edu
 */

#include <pthread.h>
#include "connection.h"
#include <stdlib.h>			// malloc
#include "libciutils.h"		// mallocCheck
#include <stdio.h>			// fprintf
#include <string.h>
#include "debug.h"
#include "remote_packet.h"
#include "remote_api_wrapper.h"
#include <unistd.h>
#include <assert.h>
#include <signal.h>
#include "../l2scheduler/fair_share_sched.h"
#include "../l2scheduler/las_scheduler.h"
#include "../include/method_id.h"

#include <sys/types.h>
#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <wait.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <sys/times.h>

void * backend_thread(){
	// connection for listening on a port
	// 2 conn_t cannot be allocated on stack (see comment on conn_t)
	// since cause a seg faults
	signal_block_all();
	conn_t * pConnListen;
	conn_t * pConn;
    pid_t childpid, childpid2;
    int status;

	//int retval = 0;

	// Network state
	// FIXME cuda_bridge_request_t == cuda_packet_t == rpkt_t, this is rediculous
	strm_hdr_t *hdr         = NULL;
	rpkt_t *rpkts           = NULL; // array of cuda packets

	if( (pConnListen = conn_malloc(__FUNCTION__, NULL)) == NULL ) return NULL;
	// this allocates memory for the strm.rpkts, i.e., the array of packets
	if( (pConn = conn_malloc(__FUNCTION__, NULL)) == NULL ) return NULL;


	fprintf(stderr, "**************************************\n");
	fprintf(stderr, "%s.%d: hey, here server thread!\n", __FUNCTION__, __LINE__);
	fprintf(stderr, "**************************************\n");

	// set up the connection
	conn_localbind(pConnListen, 0);
    
    for(;;)
    {
	conn_accept(pConnListen, pConn);   // blocking

    printf("ACCEPTED A CONN***********\n");    
    if((childpid = fork()) == 0)
    {
       signal_block_all(); 
    if((childpid2 = fork()) == 0)
    {    
	#ifdef SCHED_FAIR_SHARE
	printf("CFSCHED process pid %d getting added to queue\n",getpid());
	signal_block_all();
	#endif
	
	int signum = 0;
//	signum = get_RTsignal(getpid());
/*	signum = add_queue(getpid(), 25);
	if((getpid() /2) % 2 == 0)
		signum = add_queue(getpid(), 6);
	else
		signum = add_queue(getpid(), 44);
	if(signum == -1)
		fprintf(stderr,"%d: Handler registration failed.\n",getpid());*/
	/* Add queue for fare_share_sched called in nvbackCudaSetDevice_srv() in remote_api_wrapper.c */
	sigset_t set;
	sigemptyset(&set);
	printf("new connection : pid = %d\n",getpid());
    // CLOSE the listen connection
    //    conn_close(pConnListen);
        
	// Connection-related structures
	hdr = &pConn->strm.hdr;
	rpkts = pConn->strm.rpkts;   // an array of packets (MAX_REMOTE_BATCH_SIZE)
	// these are buffers for extra data transferred as
	pConn->pReqBuffer = NULL;
	pConn->pRspBuffer = NULL;
	unsigned long iter_count = 0;
	pid_t mypid = getpid();
	int running_gpu = -1;
	unsigned int index = -1;
	int my_priority = 0;
	long kernel_launch_count = 0;
	dim3 gDim,bDim;
	struct timeval kernel_time, non_kernel_time;
	kernel_time.tv_sec = non_kernel_time.tv_sec = 0;
	kernel_time.tv_usec = non_kernel_time.tv_usec = 0;
	int gives_feedback = 0;

    while(1) {

    	p_debug("%d: ------------------New RPC--------------------\n",mypid);
		
		#ifdef SCHED_LAS
		if(index != -1)
		{
			my_priority = las_get_priority(index, running_gpu);
			setpriority(PRIO_PROCESS, 0, my_priority);
		}
		#endif
		memset(hdr, 0, sizeof(strm_hdr_t));
		memset(rpkts, 0, MAX_REMOTE_BATCH_SIZE * sizeof(rpkt_t));
		pConn->request_data_size = 0;
		pConn->response_data_size = 0;

		pConn->pReqBuffer = freeBuffer(pConn->pReqBuffer);
		pConn->pRspBuffer = freeBuffer(pConn->pRspBuffer);

		//recv the header describing the batch of remote requests
		sigprocmask(SIG_BLOCK,&set,NULL);
		if (1 != get(pConn, hdr, sizeof(strm_hdr_t))) {
			sigprocmask(SIG_UNBLOCK,&set,NULL);
			fprintf(stderr,"EXIT %d: break 1\n",mypid);
			break;
		}
		sigprocmask(SIG_UNBLOCK,&set,NULL);
		p_debug("%d: received request header. Expecting  %d packets. And extra request buffer of data size %d\n",
				mypid,hdr->num_cuda_pkts, hdr->data_size);

		if (hdr->num_cuda_pkts <= 0) {
			p_warn("%d: Received header specifying zero packets, ignoring\n",mypid);
			continue;
		}

        // Receive the entire batch.
		// first the packets, then the extra data (reqbuf)
		//
		// let's assume that we have enough space. otherwise we have a problem
		// pConn allocates the buffers for incoming cuda packets
		// so we should be fine
		sigprocmask(SIG_BLOCK,&set,NULL);
		if(1 != get(pConn, rpkts, hdr->num_cuda_pkts * sizeof(rpkt_t))) {
			sigprocmask(SIG_UNBLOCK,&set,NULL);
			fprintf(stderr,"EXIT %d : break 2\n",mypid);
			break;
		}
		sigprocmask(SIG_UNBLOCK,&set,NULL);
		p_info("%d: Received %d packets, each of size of (%lu) bytes\n",
				mypid,hdr->num_cuda_pkts, sizeof(rpkt_t));

		p_info( "%d: Received method %s (method_id %d) from Thr_id: %lu.\n",mypid,
		 methodIdToString(rpkts[0].method_id), rpkts[0].method_id, rpkts[0].thr_id);

		// receiving the request buffer if any
		if(hdr->data_size > 0){
			p_info("%d: Expecting data size/Buffer: %u, %d.\n",mypid,
					hdr->data_size, pConn->request_data_size);
			// let's assume that the expected amount of data will fit into
			// the buffer we have (size of pConn->request_data_buffer

			// allocate the right amount of memory for the request buffer
			pConn->pReqBuffer = malloc(hdr->data_size);
			if( mallocCheck(pConn->pReqBuffer, __FUNCTION__, NULL) == ERROR ){
				fprintf(stderr,"%d: EXIT break 3\n",mypid);
				break;
			}

			//assert(hdr->data_size <= TOTAL_XFER_MAX);
			sigprocmask(SIG_BLOCK,&set,NULL);
			if(1 != get(pConn, pConn->pReqBuffer, hdr->data_size)){
				sigprocmask(SIG_UNBLOCK,&set,NULL);
				pConn->pReqBuffer = freeBuffer(pConn->pReqBuffer);
				fprintf(stderr,"%d: EXIT break 4\n",mypid);
				break;
			}
			sigprocmask(SIG_UNBLOCK,&set,NULL);
			pConn->request_data_size = hdr->data_size;
			p_info( "%d: Received request buffer (%d bytes)\n",mypid, pConn->request_data_size);
		}

		// execute the request
//		sleep(2);
		printf("ITER %ld : iter_count = %lu\n",getpid(),iter_count);
		iter_count++;
		struct timeval before, after;

		rpkts[0].is_feedback_packet = 0;
		#ifdef L2_FEEDBACK_ENABLED
//		if(index != -1)
//			printf("L2FB index = %d, sends feedback = %d\n",index,Scheduler_Data.sends_l2_feedback[index]);
		if((index != -1) && (Scheduler_Data.sends_l2_feedback[index]))
		{
			if(rpkts[0].method_id == CUDA_LAUNCH)
				kernel_launch_count++;

			if(rpkts[0].method_id == CUDA_CONFIGURE_CALL)
			{
				gDim =  rpkts[0].args[0].arg_dim;
				bDim =  rpkts[0].args[1].arg_dim;
			}

		}
		if(rpkts[0].method_id == CUDA_THREAD_EXIT)
		{
			if(index != -1)
			{
				// parameter 1 : application type
				// parameter 2 : total execution time
				struct timeval total_ex_time;
				int application; 
				int success = las_get_l2_data(running_gpu,index, &application, &total_ex_time);
				if(success)
				{

					// parameter 3 : system time , user time
					struct tms buf;
					times(&buf);
					long ticks_per_sec = sysconf(_SC_CLK_TCK);
					float vtime = ((float) buf.tms_utime / ticks_per_sec) + ((float) buf.tms_stime / ticks_per_sec);

					//parameter 4 : total kernel launches
					//have this in kernel_launch_count
					
					//TODO parameter 5 : <<<K,(B,T)>>>

					rpkts[0].is_feedback_packet = 1;
					rpkts[0].node = IFRIT_ID;
					rpkts[0].devid = running_gpu;
					rpkts[0].app_type = application;
					rpkts[0].total_ex_time = (float) total_ex_time.tv_sec + 
								((float) total_ex_time.tv_usec * 0.000001);
					rpkts[0].sys_time = ((float) buf.tms_stime / ticks_per_sec);
					rpkts[0].usr_time = ((float) buf.tms_utime / ticks_per_sec);
					rpkts[0].cuda_kernel_launches = kernel_launch_count;
					rpkts[0].args[0].arg_dim = gDim;
					rpkts[0].args[1].arg_dim = bDim;
					rpkts[0].kernel_time = kernel_time;
					rpkts[0].non_kernel_time = non_kernel_time;
					printf("FBPKT Feedback packet prepared. pid = %ld\n",getpid());
				}
			}
		}

		#endif

		gettimeofday(&before,NULL);
		pkt_execute(&rpkts[0], pConn);			// XXX - packet execution
		gettimeofday(&after,NULL);

		struct timeval temp;
		timersub(&after,&before,&temp);
		if(rpkts[0].method_id == CUDA_LAUNCH)
			timeradd(&kernel_time, &temp, &kernel_time);
		else
			timeradd(&non_kernel_time, &temp, &non_kernel_time);
		
		#ifdef SCHED_FAIR_SHARE
		sigprocmask(SIG_BLOCK,&set,NULL);
		fs_notify_scheduler(&before,&after,running_gpu);
		sigprocmask(SIG_UNBLOCK,&set,NULL);

		if(rpkts[0].method_id == CUDA_SET_DEVICE)
		{
			sigaddset(&set,rpkts[0].signo);
			running_gpu = rpkts[0].args[0].argi;
		}	
		#endif

		#ifdef SCHED_LAS
		las_notify_scheduler(&before,&after,running_gpu);
		if(rpkts[0].method_id == CUDA_SET_DEVICE)
		{
			index = rpkts[0].signo;
			running_gpu = rpkts[0].args[0].argi;
		}
		#endif


		// we need to send the one response packet + response_buffer if any

		// @todo you need to check if he method needs to send
		// and extended response - you need to provide the right
		// data_size

		if( strm_expects_response(&pConn->strm) ){

			// send the header about response
			p_debug( "%d: pConn->response_data_size %d\n",mypid, pConn->response_data_size);
			sigprocmask(SIG_BLOCK,&set,NULL);
			if (conn_sendCudaPktHdr(&*pConn, 1, pConn->response_data_size) == ERROR) {
				sigprocmask(SIG_UNBLOCK,&set,NULL);
				p_info( "__ERROR__ after : Sending the CUDA packet response header: Quitting ... \n");
				fprintf(stderr,"EXIT break 5\n");
				break;
			}

			// send the standard response (with cuda_error_t, and simple arguments etc)
			if (1 != put(pConn, rpkts, sizeof(rpkt_t))) {
				sigprocmask(SIG_UNBLOCK,&set,NULL);
				p_info("__ERROR__ after : Sending CUDA response packet: Quitting ... \n");
				fprintf(stderr,"EXIT break 6\n");
				break;
			}
			sigprocmask(SIG_UNBLOCK,&set,NULL);
			p_info("Response packet sent.\n");

			// send the extra data if you have anything to send
			if( pConn->response_data_size > 0 ){
				sigprocmask(SIG_BLOCK,&set,NULL);
				if (1 != put(pConn, pConn->pRspBuffer, pConn->response_data_size)) {
					sigprocmask(SIG_UNBLOCK,&set,NULL);
					p_info("__ERROR__ after: Sending accompanying response buffer: Quitting ... \n"
							);
				fprintf(stderr,"EXIT break 7\n");
					break;
				}
				sigprocmask(SIG_UNBLOCK,&set,NULL);
				p_info( "%d: Response buffer sent (%d) bytes.\n",mypid, pConn->response_data_size);
			}
		}
    	}

	freeBuffer(pConn->pReqBuffer);
    	freeBuffer(pConn->pRspBuffer);
	conn_close(pConnListen);
	conn_close(pConn);

	free(pConnListen);
	free(pConn);

	#ifdef SCHED_FAIR_SHARE
	sigprocmask(SIG_BLOCK,&set,NULL);
	fs_rem_queue(getpid(),running_gpu);
	sigprocmask(SIG_UNBLOCK,&set,NULL);
	#endif

	#ifdef SCHED_LAS
	las_rem_queue(getpid(),running_gpu);
	#endif
	return NULL;
    } //if(childpid2==0)   
    else
        exit(0);
        
        
    
    } //if(childpid==0)

        //CLOSE THE other conn
        conn_close(pConn);
        waitpid(childpid, &status, 0);
    }//for(;;)
}

int main(){
	// thread that listens for the incoming connections
	//pthread_t thread;

	//pthread_create(&thread, NULL, &backend_thread, NULL);
	//pthread_join(thread, NULL);
	backend_thread();
	printf("server thread says you bye bye!\n");
	return 0;
}
