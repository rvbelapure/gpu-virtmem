#ifndef __SEM_OPS
#define __SEM_OPS

#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>

int P(int semID); 
int V(int semID);
int get_semaphore(key_t id);
#endif
