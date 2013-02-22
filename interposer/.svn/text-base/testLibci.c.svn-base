/**
 * @file testLibci.c
 * @brief
 *
 * @date Mar 10, 2011
 * @author Magda Slawinska, magg __at_ gatech __dot_ edu
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <CUnit/CUnit.h>
#include <CUnit/Basic.h>

#include "packetheader.h"
#include "debug.h"	// ERROR, OK
#include <pthread.h>

extern int l_setMetThrReq(cuda_packet_t ** const pPacket, const uint16_t methodId);


/* The suite initialization function.
 * Opens the temporary file used by the tests.
 * Returns zero on success, non-zero otherwise.
 */
int init_suite1(void)
{
  /* if (NULL == (temp_file = fopen("temp.txt", "w+"))) {
      return -1;
   }
   else {
      return 0;
   }*/
   return 0;
}

/* The suite cleanup function.
 * Closes the temporary file used by the tests.
 * Returns zero on success, non-zero otherwise.
 */
int clean_suite1(void)
{
   /*if (0 != fclose(temp_file)) {
      return -1;
   }
   else {
      temp_file = NULL;
      return 0;
   }*/
  return 0;
}

/**
 * tests if the packet is correctly initialized
 */
void test_l_setMetThrReq(void){
	cuda_packet_t packet;
	cuda_packet_t * pPacket = &packet;
	uint16_t methodId = 10;

	// check if we really can set the content of the packet
	CU_ASSERT( OK == l_setMetThrReq(&pPacket, methodId));
	// now check the values
	CU_ASSERT( methodId == pPacket->method_id );
	CU_ASSERT( methodId == packet.method_id );
	CU_ASSERT( pthread_self() == pPacket->thr_id);
	CU_ASSERT( pthread_self() == packet.thr_id);
	CU_ASSERT( CUDA_request == pPacket->flags );
	CU_ASSERT( CUDA_request == packet.flags );
}



/* The main() function for setting up and running the tests.
 * Returns a CUE_SUCCESS on successful running, another
 * CUnit error code on failure.
 */
int main()
{
   CU_pSuite pSuite = NULL;

   /* initialize the CUnit test registry */
   if (CUE_SUCCESS != CU_initialize_registry())
      return CU_get_error();

   /* add a suite to the registry */
   pSuite = CU_add_suite("Suite_1", init_suite1, clean_suite1);
   if (NULL == pSuite) {
      CU_cleanup_registry();
      return CU_get_error();
   }

   /* add the tests to the suite */
   /* NOTE - ORDER IS IMPORTANT - MUST TEST fread() AFTER fprintf() */
   if (
	   //(NULL == CU_add_test(pSuite, "test of fprintf()", testFPRINTF)) ||
       //(NULL == CU_add_test(pSuite, "test of fread()", testFREAD)) ||
       (NULL == CU_add_test(pSuite, "test of test_l_setMetThrReq", test_l_setMetThrReq))){
      CU_cleanup_registry();
      return CU_get_error();
   }

   /* Run all tests using the CUnit Basic interface */
   CU_basic_set_mode(CU_BRM_VERBOSE);
   CU_basic_run_tests();
   CU_cleanup_registry();
   return CU_get_error();
}
