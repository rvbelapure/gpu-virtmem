#ifndef __CFS_SCHED
#define __CFS_SCHED 1

#define MAX_CONTROLLER_COUNT 500

#define LISTEN_PATH 	 "/tmp/GPU_LISTEN"
#define CLIENT_WRITE_PATH "/tmp/GPU_CWRITE_"
#define CLIENT_READ_PATH  "/tmp/GPU_CREAD_"
//#define FIFO_PATH_0 "/tmp/GPU_A0"
//#define FIFO_PATH_1 "/tmp/GPU_A1"

#define SEMKEYPATH "/dev/null"  /* Path used on ftok for semget key  */
#define SEMKEYID 1              /* Id used on ftok for semget key    */

#define ADD_Q 10
#define REM_Q 11

#define INVALID_PROCEESS 0


typedef struct _process_credit_data{
	pid_t pid;
	unsigned long share_unit;
	int action;
}process_credit_data;

typedef struct _scheduler_datastructure{
	pid_t process_list[MAX_CONTROLLER_COUNT];
	unsigned long share_unit[MAX_CONTROLLER_COUNT];
	int signal_num[MAX_CONTROLLER_COUNT];
	int valid[MAX_CONTROLLER_COUNT];
	unsigned polling_thread_count;
	unsigned RT_signal_indx;
}scheduler_data;

void register_process(pid_t process_id, int signum, unsigned long share_unit);
void* listen_thread(void *thid);
void* control_thread(void *thid_arr);
int cpu_bind(const unsigned short cpu); 
void sem_cleanup_and_exit(int signo);

void mysignalhandler1(int n, siginfo_t* info, void* k);
int already_added(process_credit_data pcd);
int register_handler(int signum);
void signal_block_all();
int start_scheduler();
int add_queue(pid_t process_id, /*int unsigned GPU_id,*/ unsigned long share_unit);
int rem_queue(pid_t process_id);

#endif
