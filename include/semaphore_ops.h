#ifndef __SEM_OPS
#define __SEM_OPS

#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>

static int P(int semID); 
static int V(int semID);
int get_semaphore(key_t id);
#endif
