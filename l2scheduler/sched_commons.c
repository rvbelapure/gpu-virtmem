#include <stdio.h>
#include <pthread.h>
#include "sched_commons.h"

scheduler_data Scheduler_Data;
pthread_mutex_t map_mut = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t mut = PTHREAD_MUTEX_INITIALIZER;
pthread_rwlock_t las_lock = PTHREAD_RWLOCK_INITIALIZER;
int semid;
FILE *map_file;

int node_id = IFRIT_ID;

