#ifndef __LAS_SCHED
#define __LAS_SCHED 1

#include "sched_commons.h"

#define PRIORITY_NORMAL 19
#define PRIORITY_HIGH 	-20

extern pthread_rwlock_t las_lock;

int las_register_process(pid_t process_id, int gpuid, int app_type, int to_mark);
void* las_listen_thread(void *thid);
void* las_control_thread(void *thid_arr);
int las_cpu_bind(const unsigned short cpu); 

void mysignalhandler1(int n, siginfo_t* info, void* k);
int already_added(process_credit_data pcd);
int las_register_handler(int signum);
int las_start_scheduler();
int las_add_queue(pid_t process_id, int unsigned gpuid, int app_type);
int las_rem_queue(pid_t process_id, int gpuid);
void las_notify_scheduler(struct timeval *before, struct timeval *after, int gpuid);
#endif
