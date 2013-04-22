#ifndef SCHED_COMMONS_H
#define SCHED_COMMONS_H

//#define SCHED_FAIR_SHARE 
//#define SCHED_LAS 
//#define L2_FEEDBACK_ENABLED

#define PAGER

#define L2_FEEDBACK_TYPE_NONE	 100
#define L2_FEEDBACK_TYPE_UTIL 	 101
#define L2_FEEDBACK_TYPE_EX_TIME 102


#include <stdio.h>
#include <pthread.h>
#include <sys/time.h>
#include <signal.h>

#define MAX_CONTROLLER_COUNT 500
#define SIGSCHED SIGRTMIN
#define SIGPAGE  (SIGRTMAX-1)

#define LISTEN_PATH 	 "/tmp/gpu-dipanjan/GPU_LISTEN_"
#define CLIENT_WRITE_PATH "/tmp/gpu-dipanjan/GPU_CWRITE_"
#define CLIENT_READ_PATH  "/tmp/gpu-dipanjan/GPU_CREAD_"
#define CLIENT_SIGGET_PATH  "/tmp/gpu-dipanjan/GPU_SIGNUM_"
#define SCHED_DEF_FILE_PATH "/tmp/gpu-dipanjan/l2sched_mapping.txt"
#define SCHED_PID_FILE_PATH "/tmp/gpu-dipanjan/l2sched_pid.txt"
#define PAGER_LISTEN_PATH   "/tmp/gpu-dipanjan/GPU_PAGER_LISTEN"
#define PCLIENT_FIFO  "/tmp/gpu-dipanjan/GPU_PCLIENT_"

#define SEMKEYPATH "/dev/null"  /* Path used on ftok for semget key  */
#define SEMKEYID 1              /* Id used on ftok for semget key    */
#define GMT_KEYID 2		/* Id for sem on GMT */
#define GMT_SHM_KEY 3
#define GMT_SHM_INDEX_KEY 4
#define PAGER_FIFO_SEM_KEY 5	/* key used to get sem for writing in pager fifo */

#define ADD_Q 10
#define REM_Q 11
#define NOTIFY_SCHED 12
#define GET_SIGNUM 13
#define GET_PRIORITY 14
#define GET_L2_DATA 15

#define INVALID_PROCEESS 0

#define EPOCH_LENGTH 100	/* in milliseconds */

// XXX : Do not change the values application id's - array index is calculated from them
#define APP_TYPE_A 0
#define APP_TYPE_B 1

// XXX : Do not change the values node id's - array index is calculated from them
#define IFRIT_ID 0
#define SHIVA_ID 1


/* Application states in scheduler */

#define PROC_ACTIVE 0
#define PROC_INACTIVE 1
#define PROC_PAGING 2
#define PROC_WAITING 3


extern pthread_t thIDs[10];
extern pthread_t pager_tid[2];

typedef struct _process_credit_data{
	pid_t pid;
	unsigned long share_unit;
	int action;
	int app_type;
	int gpuid;
	struct timeval execution_time;
}process_credit_data;

typedef struct _scheduler_datastructure{
	pid_t process_list[MAX_CONTROLLER_COUNT];
	unsigned long share_unit[MAX_CONTROLLER_COUNT];
	int signal_num[MAX_CONTROLLER_COUNT];
	int state[MAX_CONTROLLER_COUNT];
	unsigned polling_thread_count;
	unsigned RT_signal_indx;
	int app_type[MAX_CONTROLLER_COUNT];
	struct timeval allocated_time[MAX_CONTROLLER_COUNT];
	struct timeval execution_time[MAX_CONTROLLER_COUNT];
	int penalty_epochs[MAX_CONTROLLER_COUNT];
	int gpu_binding[MAX_CONTROLLER_COUNT];
	int priority[MAX_CONTROLLER_COUNT];
	int sends_l2_feedback[MAX_CONTROLLER_COUNT];
}scheduler_data;


extern scheduler_data Scheduler_Data;
extern pthread_mutex_t map_mut;
extern pthread_mutex_t mut;
extern pthread_mutex_t sched_index_mut;
extern pthread_rwlock_t las_lock;
extern int semid, gmt_semid;
extern FILE *map_file;

extern int node_id;
extern int gpu_binding;

void sem_cleanup_and_exit(int signo);
void signal_block_all();
#endif
