#ifndef __CFS_SCHED
#define __CFS_SCHED 1

#include "sched_commons.h"

#define APP_TYPE_A_SHARE 70
#define APP_TYPE_B_SHARE 30

extern pthread_mutex_t mut;

void fs_register_process(pid_t process_id, int signum, int app_type, int gpuid, int share);
void* fs_listen_thread(void *thid);
void* fs_control_thread(void *thid_arr);
int fs_cpu_bind(const unsigned short cpu); 
void fs_calculate_timeslice(int gpuid);

void mysignalhandler1(int n, siginfo_t* info, void* k);
int already_added(process_credit_data pcd);
int fs_register_handler(int signum);
int fs_start_scheduler();
int fs_add_queue(pid_t process_id, int unsigned gpuid, unsigned long app_type, int share);
int fs_rem_queue(pid_t process_id, int gpuid);
void fs_notify_scheduler(struct timeval *before, struct timeval *after, int gpuid);
int fs_get_RTsignal(pid_t process_id);
#endif
