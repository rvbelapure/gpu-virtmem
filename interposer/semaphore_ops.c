#include "semaphore_ops.h"
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>

static int P(int semID) { 
  struct sembuf buff ;
  buff.sem_num = 0 ;
  buff.sem_op = -1 ;
  buff.sem_flg = 0 ;
  printf("CFSCHED In P operation\n");
  if(semop(semID, &buff, 1) == -1) 
    { 
      perror("CFSCHED semop P operation error") ; 
      return 0 ;
    }
  return -1 ; 
}

static int V(int semID) { 
  struct sembuf buff ;
  buff.sem_num = 0 ;
  buff.sem_op = 1 ;
  buff.sem_flg = 0 ;
  if(semop(semID, &buff, 1) == -1) 
    { 
      perror("CFSCHED semop V operation error") ; 
      return 0 ;
    }
  return -1 ; 
}

int get_semaphore(key_t id)
{
	int semid;
  if((semid = semget(id, 1, 0666)) == -1){
    perror("semget failed");
    return -1;
  }
  return semid;
}
