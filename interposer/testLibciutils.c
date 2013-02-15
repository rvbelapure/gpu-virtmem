/**
 * @file testLibciutils.c
 * @brief
 *
 * @date Mar 24, 2011
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

#include <__cudaFatFormat.h> // for __cudaFatPtxEntry, and others
#include "libciutils.h"	     // for cache_num_entries_t
#include "method_id.h"		// for ids of the cuda calls


extern inline int l_getStringPktSize(const char const * string);
extern int l_getSize__cudaFatPtxEntry(const __cudaFatPtxEntry * pEntry, int * pCounter);
extern int l_getSize__cudaFatCubinEntry(const __cudaFatCubinEntry * pEntry, int * pCounter);
extern int l_getSize__cudaFatDebugEntry(__cudaFatDebugEntry * pEntry, int * pCounter);
extern int l_getSize__cudaFatElfEntry(__cudaFatElfEntry * pEntry, int * pCounter);
extern int l_getSize__cudaFatSymbolEntry(const __cudaFatSymbol * pEntry, int * pCounter);
extern int l_getSize__cudaFatBinaryEntry(__cudaFatCudaBinary * pEntry, cache_num_entries_t * pEntriesCache);

extern int packFatBinary(char * pFatPack, __cudaFatCudaBinary * const pSrcFatC,
		cache_num_entries_t * const pEntriesCache);
extern int unpackFatBinary(__cudaFatCudaBinary *pFatC, char * pFatPack);
extern inline int l_packStr(char * pDst, const char *pSrc);
extern inline char * l_unpackStr(const char *pSrc, int * pOffset);

extern int l_packPtx(char * pDst, const __cudaFatPtxEntry * pEntry, int n);
extern __cudaFatPtxEntry * l_unpackPtx(char * pSrc, int * pOffset);

extern int l_packCubin(char * pDst, const __cudaFatCubinEntry * pEntry, int n);
extern __cudaFatCubinEntry * l_unpackCubin(char * pSrc, int * pOffset);

extern int l_packDebug(char * pDst, __cudaFatDebugEntry * pEntry, int n);
extern __cudaFatDebugEntry * l_unpackDebug(char * pSrc, int * pOffset);

extern int l_packElf(char * pDst, __cudaFatElfEntry * pEntry, int n);
extern __cudaFatElfEntry * l_unpackElf(char * pSrc, int * pOffset);

extern int l_packSymbol(char * pDst, const __cudaFatSymbol * pEntry, int n);
extern __cudaFatSymbol * l_unpackSymbol(char * pSrc, int * pOffset);

extern int l_packDep(char * pDst, __cudaFatCudaBinary * pEntry, int n);
extern __cudaFatCudaBinary * l_unpackDep(char * pSrc, int * pOffset);


// ----------------------------- Reg Func Args
extern int l_getSize_regFuncArgs(void** fatCubinHandle, const char* hostFun,
        char* deviceFun, const char* deviceName, int thread_limit, uint3* tid,
        uint3* bid, dim3* bDim, dim3* gDim, int* wSize);
extern inline int l_getUint3PtrPktSize(uint3 * p);
extern inline int l_getDim3PtrPktSize(dim3 * p);
extern inline int l_getIntPtrPktSize(int * p);

extern inline int l_packUint3Ptr(char * pDst, const uint3 *pSrc);
extern inline uint3 * l_unpackUint3Ptr(const char *pSrc, int * pOffset);

extern inline int l_packDim3Ptr(char * pDst, const dim3 *pSrc);
extern inline dim3 * l_unpackDim3Ptr(const char *pSrc, int * pOffset);

extern inline int l_packIntPtr(char * pDst, const int *pSrc);
extern inline int * l_unpackIntPtr(const char *pSrc, int * pOffset);

extern char * packRegFuncArgs( void** fatCubinHandle, const char* hostFun,
        char* deviceFun, const char* deviceName, int thread_limit,
        uint3* tid, uint3* bid, dim3* bDim, dim3* gDim, int* wSize,
	int *pSize);
extern int unpackRegFuncArgs(reg_func_args_t * pRegFuncArgs, char * pPacket);

// -----  RegVar
extern int l_getSize_regVar(void **fatCubinHandle, char *hostVar, char *deviceAddress,
		const char *deviceName, int ext, int vsize,int constant, int global);
extern char * packRegVar( void **fatCubinHandle, char *hostVar,
		char *deviceAddress, const char *deviceName, int ext, int vsize,
		int constant, int global, int * pSize );
extern int unpackRegVar(reg_var_args_t * pRegVar, char *pPacket);


extern int freeRegFunc(reg_func_args_t *args);
extern int freeFatBinary(__cudaFatCudaBinary *fatCubin);

// -------------------
// misc
// ------------------
extern char * methodIdToString(const int method_id);
extern inline char * freeBuffer(char * pBuffer);

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
 * tests if the packet for a string is correctly counted
 */
void test_l_getStringPktSize(void){
	char * s;
	int size;

	// 0. null string NULL + NULL
	s = NULL;
	size = sizeof(size_pkt_field_t);
	CU_ASSERT_EQUAL( l_getStringPktSize(s), size );

	// 1. zero length string
	s = "";
	// "" + NULL
	size = sizeof(size_pkt_field_t);
	CU_ASSERT( l_getStringPktSize(s) == size );

	// 2. regular string
	s = "1323";
	size = sizeof(size_pkt_field_t) + 4 * sizeof(char);
	CU_ASSERT( l_getStringPktSize(s) == size );
}

/**
 * tests if the packet for the ptxEntry is correctly counted
 */
void test_l_getSize__cudaFatPtxEntry(void){

	__cudaFatPtxEntry e1[] = { {NULL, NULL} };
	int cache;
	int size = 0;

	// 0a. null entry
	size = sizeof(size_pkt_field_t);
	CU_ASSERT( l_getSize__cudaFatPtxEntry(NULL, &cache) == size);
	CU_ASSERT( 0 ==  cache);

	// 0b. null values
	size = sizeof(size_pkt_field_t);
	cache = 0;
	CU_ASSERT( l_getSize__cudaFatPtxEntry(e1, &cache) == size);
	CU_ASSERT( 0 == cache);

	// 1. count the size of the empty structure
	__cudaFatPtxEntry e2[] = { {"", ""}, {NULL, NULL}};
	cache = 0;
	size = sizeof(size_pkt_field_t)
			+ sizeof(size_pkt_field_t)
			+ sizeof(size_pkt_field_t);
	CU_ASSERT( l_getSize__cudaFatPtxEntry(e2, &cache) ==  size);
	CU_ASSERT( 1 == cache);

	// 2. put some not empty things
	__cudaFatPtxEntry e3[] = { {"1", "12"}, {"3", "7"}, {NULL, NULL} };
	cache = 0;
	size = sizeof(size_pkt_field_t) + 4*sizeof(size_pkt_field_t) + 5 * sizeof(char);
	CU_ASSERT( l_getSize__cudaFatPtxEntry(e3, &cache) ==  size);
	CU_ASSERT( 2 == cache);
}

/**
 * tests if the packet for the cubinEntry is correctly counted
 * Should be almost identical to @see test_l_getSize__cudaFatPtxEntry()
 */
void test_l_getSize__cudaFatCubinEntry(void){

	__cudaFatCubinEntry e1[] = { {NULL, NULL} };
	int cache = 0;
	int size = 0;

	// 0a. null entry
	size = sizeof(size_pkt_field_t);
	CU_ASSERT( l_getSize__cudaFatCubinEntry(NULL, &cache) == size);
	CU_ASSERT( 0 ==  cache);

	// 0b. null values
	size = sizeof(size_pkt_field_t);
	cache = 0;
	CU_ASSERT( l_getSize__cudaFatCubinEntry(e1, &cache) == size);
	CU_ASSERT( 0 == cache);

	// 1. count the size of the empty structure
	__cudaFatCubinEntry e2[] = { {"", ""}, {NULL, NULL}};
	cache = 0;
	size = sizeof(size_pkt_field_t)
			+ sizeof(size_pkt_field_t)
			+ sizeof(size_pkt_field_t);
	CU_ASSERT( l_getSize__cudaFatCubinEntry(e2, &cache) ==  size);
	CU_ASSERT( 1 == cache);


	// 3. put some not empty things |ncubs|(len|str|NULL|)*4
	__cudaFatCubinEntry e3[] = { {"1", "12"}, {"3", "7"}, {NULL, NULL} };
	// 5 chars
	cache = 0;
	size = sizeof(size_pkt_field_t)  		// helding size
			+ 4 * sizeof(size_pkt_field_t)  // sizes for particular strings
			+ 5 * sizeof(char);             // total string length
	CU_ASSERT( l_getSize__cudaFatCubinEntry(e3, &cache) ==  size);
	CU_ASSERT( cache == 2);
}
/**
 * tests if the packet for the debugEntry is correctly counted
 *
 */
void test_l_getSize__cudaFatDebugEntry(void){
	__cudaFatDebugEntry e[] = { {NULL, NULL, NULL, 0} };
	__cudaFatDebugEntry e2[] = { {"","", NULL, 12}, {NULL, NULL, NULL, 0} };
	__cudaFatDebugEntry terminator = {NULL, NULL, NULL, 0};
	int cache;
	int size;

	// 0. null entry
	size = sizeof(size_pkt_field_t);
	CU_ASSERT( l_getSize__cudaFatDebugEntry(NULL, &cache) == size);
	CU_ASSERT( 0 == cache);

	// 1a. next null, the strings null
	cache = 0;
	size = sizeof(size_pkt_field_t);
	CU_ASSERT( l_getSize__cudaFatDebugEntry(e, &cache) == size);
	CU_ASSERT( 0 == cache);

	// 1b. next is null, the strings are empty
	e2[0].next = &e2[1];
	cache = 0;
	size = sizeof(size_pkt_field_t);
	CU_ASSERT( l_getSize__cudaFatDebugEntry(e, &cache) == size);
	CU_ASSERT( 0 == cache);

	// 2. now normal situation
	__cudaFatDebugEntry e4 = {"prof", "deb", NULL, 13};
	__cudaFatDebugEntry e1[] = { {"profile", "debug", &e4, 0}};
	e4.next = &terminator;

	size =  sizeof(size_pkt_field_t) +
			sizeof(size_pkt_field_t) + 7 +
			sizeof(size_pkt_field_t) + 5 +
			sizeof(e[1].size) +
			sizeof(size_pkt_field_t) + 4 +
			sizeof(size_pkt_field_t) + 3 +
			sizeof(e[0].size);
	cache = 0;
	CU_ASSERT( l_getSize__cudaFatDebugEntry(e1, &cache) == size);
	CU_ASSERT( 2 == cache);
}
/**
 * tests if the packet size for the elfEntry is correctly counted
 *
 */
void test_l_getSize__cudaFatElfEntry(void){
	// this is the terminator for the elf entry
	// as empirically observed
	__cudaFatElfEntry TERM = {NULL, NULL, NULL, 0};

	__cudaFatElfEntry e[] = { {NULL, NULL, NULL, 0} };
	int cache = 0;
	int size;

	// 1. null entry
	size = sizeof(size_pkt_field_t);
	CU_ASSERT( l_getSize__cudaFatElfEntry(NULL, &cache) == size);
	CU_ASSERT( 0 == cache);

	// 2. one element
	e[0].elf = "file1";
	// the size corresponds to the number of characters
	// in the elf field
	e[0].size = 5;
	e[0].gpuProfileName = "name";
	e[0].next = &TERM;
	cache = 0;
	size = sizeof(size_pkt_field_t)
		+ sizeof(size_pkt_field_t) + 4  // gpuProfileName
		+ sizeof(e[0].size) // size
		+ e[0].size ; // elf length in bytes (provided by size)

	CU_ASSERT( l_getSize__cudaFatElfEntry(e, &cache) == size);
	CU_ASSERT( 1 == cache);

	// 3. two another normal situation
	__cudaFatElfEntry e1[] = { {"profile", "elffil", &e[0], 6}};

	size =  sizeof(size_pkt_field_t) +
			sizeof(size_pkt_field_t) + 7  +
			6 +
			sizeof(e[1].size) +
			sizeof(size_pkt_field_t) + 4  +
			5 +
			sizeof(e[0].size);
	cache = 0;
	CU_ASSERT( l_getSize__cudaFatElfEntry(e1, &cache) == size);
	CU_ASSERT( 2 == cache);
}

void test_l_getSize__cudaFatSymbolEntry(void){
	int counter = 0;
	int size = 0;

	// 0. start with NULL
	counter = 0;
	size =  sizeof(size_pkt_field_t)
			+ sizeof(size_pkt_field_t);
	CU_ASSERT(l_getSize__cudaFatSymbolEntry(NULL, &counter) == size);
	CU_ASSERT(0 == counter);

	// arr[4]
	__cudaFatSymbol * arr = malloc(sizeof(__cudaFatSymbol) * 4);

	// 1a. now not null, but null string
	arr[0].name = NULL;
	arr[1].name = NULL;

	counter = 0;
	size = sizeof(size_pkt_field_t)   // counter
			+ sizeof(size_pkt_field_t) ; // length
	CU_ASSERT(l_getSize__cudaFatSymbolEntry(arr, &counter) == size);
	CU_ASSERT(0 == counter);

	// 1b. now not null, but empty
	arr[0].name = "";
	arr[1].name = NULL;
	counter = 0;
	size = sizeof(size_pkt_field_t)
			+ sizeof(size_pkt_field_t) ;

	CU_ASSERT(l_getSize__cudaFatSymbolEntry(arr, &counter) == size);
	CU_ASSERT(1 == counter);

	// 2. now three elements
	arr[0].name = "1";
	arr[1].name = "123";
	arr[2].name = "a";
	arr[3].name = NULL;

	counter = 0;
	size = sizeof(size_pkt_field_t)
			+ sizeof(size_pkt_field_t) + 1
			+ sizeof(size_pkt_field_t) + 3
			+ sizeof(size_pkt_field_t) + 1 ;
	CU_ASSERT(l_getSize__cudaFatSymbolEntry(arr, &counter) == size);
	CU_ASSERT(3 == counter);

	free(arr);
}

void test_l_getSize__cudaFatBinaryEntry(void){
	cache_num_entries_t cache = {0, 0, 0, 0, 0, 0, 0};
		int size;
	__cudaFatCudaBinary b[2];

	__cudaFatDebugEntry DEB_TERM = {NULL, NULL, NULL, 0};
	__cudaFatElfEntry ELF_TERM = {NULL, NULL, NULL, 0};

	__cudaFatPtxEntry ptx1[] = { { "1", "p" }, { NULL, NULL } }; // 1s + 2s + 2
	__cudaFatCubinEntry cubin1[] = { { "p", "c" }, { NULL, NULL } }; // 1s + 2s + 2
	__cudaFatDebugEntry debug1[] = { { "p", "d", &DEB_TERM, 1 } }; // 1s + 2s + 2 + int
	__cudaFatElfEntry elf1[] = { { "p", "ef", &ELF_TERM, 2 } }; // 1s + (1s + 1) + 2 + int
	__cudaFatSymbol sym1[] = { { "s" }, { NULL } }; // 1s + 1s + 1

	__cudaFatPtxEntry ptx2[] = { { "2", "2" }, { NULL, NULL } };
	__cudaFatCubinEntry cubin2[] = { { "2", "2" }, { NULL, NULL } };
	__cudaFatDebugEntry debug2[] = { { "2", "2", &DEB_TERM, 1 } };
	__cudaFatElfEntry elf2[] = { { "2", "2", &ELF_TERM, 1 } };
	__cudaFatSymbol sym2[] = { { "s" }, { NULL } };

	// 0
	b[0].magic = 1;
	b[0].version = 2;
	b[0].gpuInfoVersion = 3;
	b[0].flags = 1;
	b[0].characteristic = 2;
	b[0].key = "key";
	b[0].ident = "ident";
	b[0].usageMode = "usageMode";
	b[0].debugInfo = &cache;
	b[0].ptx = ptx1;
	b[0].cubin = cubin1;
	b[0].debug = debug1;
	b[0].elf = elf1;
	b[0].exported = sym1;
	b[0].imported = sym1;
	b[0].dependends = &b[1];

	// 1
	b[1].magic = 1;
	b[1].version = 2;
	b[1].gpuInfoVersion = 3;
	b[1].flags = 1;
	b[1].characteristic = 2;
	b[1].key = "key";
	b[1].ident = "ident";
	b[1].usageMode = "usageMode";
	b[1].debugInfo = &cache;
	b[1].ptx = ptx2;
	b[1].cubin = cubin2;
	b[1].debug = debug2;
	b[1].elf = elf2;
	b[1].exported = sym2;
	b[1].imported = sym2;
	b[1].dependends = NULL;

	size = l_getSize__cudaFatBinaryEntry(&b[0], &cache);

	int expected = 3 * sizeof(unsigned long) +  // magic, version, gpuversion
			2 * sizeof(unsigned int) + // flags, characteristic
			3 * sizeof(size_pkt_field_t) + 17 + // key, indent, usageMode
			sizeof(void*) + // debugInfo
			sizeof(size_pkt_field_t) + 2 * sizeof(size_pkt_field_t) + 2 // ptx
			+ sizeof(size_pkt_field_t) + 2 * sizeof(size_pkt_field_t) + 2 // cubin
			+ sizeof(size_pkt_field_t) + 2 * sizeof(size_pkt_field_t) + 2  + sizeof(unsigned int) // debug
			+ sizeof(size_pkt_field_t) + (sizeof(size_pkt_field_t) +1) + 2  + sizeof(unsigned int) // elf
			+ sizeof(size_pkt_field_t) + sizeof(size_pkt_field_t) + 1 // exported
			+ sizeof(size_pkt_field_t) + sizeof(size_pkt_field_t) + 1 // imported

			+ sizeof(size_pkt_field_t)  // how many dependends
			+ 3 * sizeof(unsigned long)   // magic, version, gpuversion
			+ 2 * sizeof(unsigned int)  // flags, characteristic
			+ 3 * sizeof(size_pkt_field_t) + 17  // key, indent, usageMode
			+ sizeof(void*)  // debugInfo
			+ sizeof(size_pkt_field_t) + 2 * sizeof(size_pkt_field_t) + 2 // ptx
			+ sizeof(size_pkt_field_t) + 2 * sizeof(size_pkt_field_t) + 2 // cubin
			+ sizeof(size_pkt_field_t) + 2 * sizeof(size_pkt_field_t) + 2  + sizeof(unsigned int) // debug
			+ sizeof(size_pkt_field_t) + (sizeof(size_pkt_field_t) + 1) + 1 + sizeof(unsigned int) // elf
			+ sizeof(size_pkt_field_t) + sizeof(size_pkt_field_t) + 1 // exported
			+ sizeof(size_pkt_field_t) + sizeof(size_pkt_field_t) + 1 // imported
			;

	CU_ASSERT_EQUAL(size, expected);
}


void test_l_packUnpackStr(void){
	char arr[20];
	char * str;
	char * unpack;
	int offset;
	int unpack_offset;

	// 1a. test packing the NULL string
	offset = sizeof(size_pkt_field_t);
	CU_ASSERT(l_packStr(arr, NULL) == offset);
	// @todo you might want to check what contains arr, but
	// we won't do that
	unpack = l_unpackStr(arr, &offset);
	CU_ASSERT(unpack == NULL);
	CU_ASSERT(sizeof(size_pkt_field_t) == offset);
	free(unpack);

	// 1b. test empty string
	offset = sizeof(size_pkt_field_t);
	CU_ASSERT(l_packStr(arr, "") == offset);
	// @todo you might want to check what contains arr, but
	// we won't do that
	unpack = l_unpackStr(arr, &offset);
	CU_ASSERT(unpack == NULL);
	CU_ASSERT(sizeof(size_pkt_field_t) == offset);
	free(unpack);

	// 2. test normal string
	str = "hej";
	offset = sizeof(size_pkt_field_t) + strlen(str);
	CU_ASSERT(l_packStr(arr, str) == offset);
	unpack = l_unpackStr(arr, &offset);
	CU_ASSERT(unpack != NULL);
	CU_ASSERT(strcmp(str, "hej") == 0);
	unpack_offset = sizeof(size_pkt_field_t) + strlen(str);
	CU_ASSERT_EQUAL(unpack_offset, offset);
	free(unpack);
}

void test_l_packUnpackPtx(void){
	__cudaFatPtxEntry ptx[] = { {"gpuProf", "ptx"}, {NULL, NULL}};
	char arr[100];
	int offset;
	int unpack_offset;
	__cudaFatPtxEntry * unpack;

	// 1. NULL dst
	CU_ASSERT_EQUAL(l_packPtx(NULL, ptx, 2), ERROR);

	// 2. NULL entry
	offset = sizeof(size_pkt_field_t);
	CU_ASSERT_EQUAL(l_packPtx(arr, NULL, 0), offset);

	// 3. regular thing
	offset = sizeof(size_pkt_field_t)
			+ sizeof(size_pkt_field_t) + strlen(ptx[0].gpuProfileName) +
			+ sizeof(size_pkt_field_t) + strlen(ptx[0].ptx);
	CU_ASSERT_EQUAL(l_packPtx(arr, ptx, 1), offset);

	// now unpack it
	unpack = l_unpackPtx(arr, &unpack_offset);
	CU_ASSERT_EQUAL(unpack_offset, offset);
	CU_ASSERT_NSTRING_EQUAL(unpack[0].gpuProfileName, "gpuProf", 7);
	CU_ASSERT_NSTRING_EQUAL(unpack[0].ptx, "ptx", 3);
	CU_ASSERT_EQUAL(unpack[1].gpuProfileName, NULL);
	CU_ASSERT_EQUAL(unpack[1].ptx, NULL);

	free(unpack[0].gpuProfileName);
	free(unpack[0].ptx);
	free(unpack);
}

void test_l_packUnpackCubin(void){
	__cudaFatCubinEntry cubin[] = { {"gpuProf", "cubin"}, {NULL, NULL}};
	char arr[100];
	int offset;
	int unpack_offset;
	__cudaFatCubinEntry * unpack;

	// 1. NULL dst
	CU_ASSERT_EQUAL(l_packCubin(NULL, cubin, 2), ERROR);

	// 2. NULL entry
	offset = sizeof(size_pkt_field_t);
	CU_ASSERT_EQUAL(l_packCubin(arr, NULL, 0), offset);

	// 3. regular thing
	offset = sizeof(size_pkt_field_t)
			+ sizeof(size_pkt_field_t) + strlen(cubin[0].gpuProfileName) +
			+ sizeof(size_pkt_field_t) + strlen(cubin[0].cubin);
	CU_ASSERT_EQUAL(l_packCubin(arr, cubin, 1), offset);

	// now unpack it
	unpack = l_unpackCubin(arr, &unpack_offset);
	CU_ASSERT_EQUAL(unpack_offset, offset);
	CU_ASSERT_NSTRING_EQUAL(unpack[0].gpuProfileName, "gpuProf", 7);
	CU_ASSERT_NSTRING_EQUAL(unpack[0].cubin, "cubin", 3);
	CU_ASSERT_EQUAL(unpack[1].gpuProfileName, NULL);
	CU_ASSERT_EQUAL(unpack[1].cubin, NULL);

	free(unpack[0].gpuProfileName);
	free(unpack[0].cubin);
	free(unpack);
}

void test_l_packUnpackDebug(void){
	__cudaFatDebugEntry debug1 = { "prof1", "deb1", NULL, 3 };
	__cudaFatDebugEntry debug2 = { "prof2", "deb2", NULL, 13 };
	__cudaFatDebugEntry debug3 = { NULL, NULL, NULL, 0 };

	debug2.next = &debug3;
	debug1.next = &debug2;

	char arr[100];
	int offset;
	int unpack_offset;
	__cudaFatDebugEntry * unpack;

	// 1. NULL dst
	CU_ASSERT_EQUAL(l_packDebug(NULL, &debug1, 2), ERROR);

	// 2. NULL entry
	offset = sizeof(size_pkt_field_t);
	CU_ASSERT_EQUAL(l_packDebug(arr, NULL, 0), offset);

	// 3. regular thing
	offset = sizeof(size_pkt_field_t)
			+ sizeof(size_pkt_field_t) + strlen(debug1.gpuProfileName) +
			+ sizeof(size_pkt_field_t) + strlen(debug1.debug) +
			+ sizeof(unsigned int)
			+ sizeof(size_pkt_field_t) + strlen(debug2.gpuProfileName) +
			+ sizeof(size_pkt_field_t) + strlen(debug2.debug) +
			+ sizeof(unsigned int);
	CU_ASSERT_EQUAL(l_packDebug(arr, &debug1, 2), offset);

	// now unpack it
	unpack = l_unpackDebug(arr, &unpack_offset);
	CU_ASSERT_EQUAL(unpack_offset, offset);
	CU_ASSERT_NSTRING_EQUAL(unpack[0].gpuProfileName, "prof1", 5);
	CU_ASSERT_NSTRING_EQUAL(unpack[0].debug, "deb1", 4);
	CU_ASSERT_EQUAL(unpack[0].size, 3);
	CU_ASSERT_PTR_EQUAL(unpack[0].next, &unpack[1]);

	CU_ASSERT_NSTRING_EQUAL(unpack[1].gpuProfileName, "prof2", 5);
	CU_ASSERT_NSTRING_EQUAL(unpack[1].debug, "deb2", 4);
	CU_ASSERT_EQUAL(unpack[1].size, 13);
	CU_ASSERT_PTR_EQUAL(unpack[1].next, &unpack[2]);

	CU_ASSERT_PTR_EQUAL(unpack[2].gpuProfileName, NULL);
	CU_ASSERT_PTR_EQUAL(unpack[2].debug, NULL);
	CU_ASSERT_PTR_EQUAL(unpack[2].next, NULL);

	free(unpack[0].gpuProfileName);
	free(unpack[0].debug);
	free(unpack[1].gpuProfileName);
	free(unpack[1].debug);

	free(unpack);
}

void test_l_packUnpackElf(void){
	__cudaFatElfEntry TERM = {NULL, NULL, NULL, 0};

	__cudaFatElfEntry entry1 = { "prof1", "elf1", &TERM, 4 };
	__cudaFatElfEntry entry2 = { "prof2", "elf24", &TERM, 5 };

	entry1.next = &entry2;

	char arr[100];
	int offset;
	int unpack_offset;
	__cudaFatElfEntry * unpack;

	// 1. NULL dst
	CU_ASSERT_EQUAL(l_packElf(NULL, &entry1, 2), ERROR);

	// 2. NULL entry
	offset = sizeof(size_pkt_field_t);
	CU_ASSERT_EQUAL(l_packElf(arr, NULL, 0), offset);

	// 3. regular thing
	offset = sizeof(size_pkt_field_t)
			+ sizeof(size_pkt_field_t) + strlen(entry1.gpuProfileName) +
			+ strlen(entry1.elf) +
			+ sizeof(unsigned int)
			+ sizeof(size_pkt_field_t) + strlen(entry2.gpuProfileName) +
			+ strlen(entry2.elf) +
			+ sizeof(unsigned int);
	CU_ASSERT_EQUAL(l_packElf(arr, &entry1, 2), offset);

	// now unpack it
	unpack = l_unpackElf(arr, &unpack_offset);
	CU_ASSERT_EQUAL(unpack_offset, offset);
	CU_ASSERT_NSTRING_EQUAL(unpack[0].gpuProfileName, "prof1", 5);
	CU_ASSERT_NSTRING_EQUAL(unpack[0].elf, "elf1", 4);
	CU_ASSERT_EQUAL(unpack[0].size, 4);
	CU_ASSERT_PTR_EQUAL(unpack[0].next, &unpack[1]);

	CU_ASSERT_NSTRING_EQUAL(unpack[1].gpuProfileName, "prof2", 5);
	CU_ASSERT_NSTRING_EQUAL(unpack[1].elf, "elf24", 5);
	CU_ASSERT_EQUAL(unpack[1].size, 5);
	CU_ASSERT_PTR_NOT_NULL(unpack[1].next);

	CU_ASSERT_PTR_NULL(unpack[1].next->elf);
	CU_ASSERT_PTR_NULL(unpack[1].next->gpuProfileName);
	CU_ASSERT_PTR_NULL(unpack[1].next->next);
	CU_ASSERT_EQUAL(unpack[1].next->size, 0);


	free(unpack[0].gpuProfileName);
	free(unpack[0].elf);
	free(unpack[1].gpuProfileName);
	free(unpack[1].elf);

	free(unpack);
}

void test_l_packUnpackSymbol(void){
	__cudaFatSymbol sym[] = { {"sym1"}, {"sym2"},  {NULL}};
	char arr[100];
	int offset;
	int unpack_offset;
	__cudaFatSymbol * unpack;

	// 1. NULL dst
	CU_ASSERT_EQUAL(l_packSymbol(NULL, sym, 2), ERROR);

	// 2. NULL entry - this is a very typical thing
	offset = sizeof(size_pkt_field_t);
	CU_ASSERT_EQUAL(l_packSymbol(arr, NULL, 0), offset);
	offset = 0;
	unpack = l_unpackSymbol(arr, &offset);
	CU_ASSERT_EQUAL(offset, sizeof(size_pkt_field_t));
	CU_ASSERT_PTR_NULL(unpack);


	// 3. regular thing
	offset = sizeof(size_pkt_field_t)
			+ sizeof(size_pkt_field_t) + strlen(sym[0].name) +
			+ sizeof(size_pkt_field_t) + strlen(sym[0].name);
	CU_ASSERT_EQUAL(l_packSymbol(arr, sym, 2), offset);

	// now unpack it
	unpack = l_unpackSymbol(arr, &unpack_offset);
	CU_ASSERT_EQUAL(unpack_offset, offset);
	CU_ASSERT_NSTRING_EQUAL(unpack[0].name, "sym1", 4);
	CU_ASSERT_NSTRING_EQUAL(unpack[1].name, "sym2", 4);
	CU_ASSERT_EQUAL(unpack[2].name, NULL);

	free(unpack[0].name);
	free(unpack[1].name);
	free(unpack);
}

void test_l_packUnpackDep(){
	cache_num_entries_t cache = {0, 0, 0, 0, 0, 0, 0};
	int size;
	__cudaFatCudaBinary b[2];
	__cudaFatCudaBinary u;

	__cudaFatDebugEntry DEB_TERM = { NULL, NULL, NULL, 0};
	__cudaFatElfEntry ELF_TERM = { NULL, NULL, NULL, 0};

	__cudaFatPtxEntry ptx1[] = { {"p1", "ptx1"},{NULL, NULL}};
	__cudaFatCubinEntry cubin1[] = { {"p1", "cubin1"}, {NULL, NULL}};
	__cudaFatDebugEntry debug1[] = { {"p1", "debug1", &DEB_TERM, 1} };
	__cudaFatElfEntry elf1[] = { {"p1", "elf1", &ELF_TERM, 4}};
	__cudaFatSymbol sym1[] = {{"s1"}, {"sym1"}, {NULL}};

/*	__cudaFatPtxEntry ptx2[] = { {"p2", "ptx2"},{NULL, NULL}};
	__cudaFatCubinEntry cubin2[] = { {"p2", "cubin2"}, {NULL, NULL}};
	__cudaFatDebugEntry debug2[] = { {"p2", "debug2", NULL, 1} };
	__cudaFatElfEntry elf2[] = { {"p2", "elf2", NULL, 1}};
	__cudaFatSymbol sym2[] = {{"s2"}, {"sym2"}, {NULL}};
*/
	// 0
	b[0].magic = 1;
	b[0].version = 2;
	b[0].gpuInfoVersion = 3;
	b[0].flags =1;
	b[0].characteristic = 2;
	b[0].key = "key";
	b[0].ident = "ident";
	b[0].usageMode = "usageMode";

	b[0].debugInfo = &cache;

	b[0].ptx = ptx1;
	b[0].cubin = cubin1;
	b[0].debug = debug1;
	b[0].elf = elf1;
	b[0].exported = sym1;
	b[0].imported = sym1;
	b[0].dependends = &b[1];

	// @todo right now only NULL dependends supported
	b[0].dependends = NULL;

/* @todo uncomment when dependends will be supported
	// 1
	b[1].magic = 1;
	b[1].version = 2;
	b[1].gpuInfoVersion = 3;
	b[1].flags =1;
	b[1].characteristic = 2;
	b[1].key = "key";
	b[1].ident = "ident";
	b[1].usageMode = "usageMode";

	b[1].debugInfo = &cache;

	b[1].ptx = ptx2;
	b[1].cubin = cubin2;
	b[1].debug = debug2;
	b[1].elf = elf2;
	b[1].exported = sym2;
	b[1].imported = sym2;
	b[1].dependends = NULL;
*/
	// reserve the right amount of memory
	size = getFatRecPktSize(&b[0], &cache);
	char * pPacket = malloc(size);

	CU_ASSERT_NOT_EQUAL(packFatBinary(pPacket, &b[0], &cache), ERROR);

	CU_ASSERT_NOT_EQUAL(unpackFatBinary(&u,pPacket), ERROR );

	CU_ASSERT_EQUAL(u.magic, b[0].magic);
	CU_ASSERT_EQUAL(u.version, b[0].version);
	CU_ASSERT_EQUAL(u.gpuInfoVersion, b[0].gpuInfoVersion);
	CU_ASSERT_EQUAL(u.flags,  b[0].flags);
	CU_ASSERT_EQUAL(u.characteristic, b[0].characteristic);
	CU_ASSERT_NSTRING_EQUAL(u.key, "key", 3);
	CU_ASSERT_NSTRING_EQUAL(u.ident, "ident", 5);
	CU_ASSERT_NSTRING_EQUAL(u.usageMode, "usageMode", 9);

	// ptx
	CU_ASSERT_NSTRING_EQUAL(u.ptx->gpuProfileName, "p1", 2);
	CU_ASSERT_NSTRING_EQUAL(u.ptx->ptx, "ptx1", 4);
	CU_ASSERT( u.ptx[1].gpuProfileName == NULL);
	CU_ASSERT( u.ptx[1].ptx == NULL);

	// cubin
	CU_ASSERT_NSTRING_EQUAL(u.cubin->gpuProfileName, "p1", 2);
	CU_ASSERT_NSTRING_EQUAL(u.cubin->cubin, "cubin1", 6);
	CU_ASSERT( u.cubin[1].gpuProfileName == NULL);
	CU_ASSERT( u.cubin[1].cubin == NULL);

	// debug
	CU_ASSERT_NSTRING_EQUAL(u.debug->gpuProfileName, "p1", 2);
	CU_ASSERT_NSTRING_EQUAL(u.debug->debug, "debug1", 6);
	CU_ASSERT_EQUAL(u.debug->size, 1);
	CU_ASSERT_PTR_NOT_EQUAL(u.debug->next, NULL);
	// debug terminator
	CU_ASSERT_PTR_NULL(u.debug->next->gpuProfileName);
	CU_ASSERT_PTR_NULL(u.debug->next->debug);
	CU_ASSERT_PTR_NULL(u.debug->next->next);
	CU_ASSERT_EQUAL(u.debug->next->size, 0);

	// elf
	CU_ASSERT_NSTRING_EQUAL(u.elf->gpuProfileName, "p1", 2);
	CU_ASSERT_NSTRING_EQUAL(u.elf->elf, "elf1", 4);
	CU_ASSERT_EQUAL(u.elf->size, 4);
	CU_ASSERT_PTR_NOT_NULL(u.elf->next);
	// elf terminator
	CU_ASSERT_PTR_NULL(u.elf->next->gpuProfileName);
	CU_ASSERT_PTR_NULL(u.elf->next->elf);
	CU_ASSERT_PTR_NULL(u.elf->next->next);
	CU_ASSERT_EQUAL(u.elf->next->size, 0);


	// exported
	CU_ASSERT_NSTRING_EQUAL(u.exported->name, "s1", 2);
	CU_ASSERT_NSTRING_EQUAL(u.exported[1].name, "sym1", 4);
	CU_ASSERT( u.exported[2].name == NULL);

	// imported
	CU_ASSERT_NSTRING_EQUAL(u.imported->name, "s1", 7);
	CU_ASSERT_NSTRING_EQUAL(u.imported[1].name, "sym1", 4);
	CU_ASSERT( u.imported[2].name == NULL);

	CU_ASSERT_PTR_EQUAL(u.dependends, NULL);
/* @todo uncomment when dependent implemented
 	// now the second dependent
	CU_ASSERT_PTR_NOT_EQUAL(u.dependends, NULL);

	CU_ASSERT_EQUAL(u.dependends->magic, b[1].magic);
	CU_ASSERT_EQUAL(u.dependends->version, b[1].version);
	CU_ASSERT_EQUAL(u.dependends->gpuInfoVersion, b[1].gpuInfoVersion);
	CU_ASSERT_EQUAL(u.dependends->flags, b[1].flags);
	CU_ASSERT_EQUAL(u.dependends->characteristic, b[1].characteristic);
	CU_ASSERT_NSTRING_EQUAL(u.dependends->key, "key", 3);
	CU_ASSERT_NSTRING_EQUAL(u.dependends->ident, "ident", 5);
	CU_ASSERT_NSTRING_EQUAL(u.dependends->usageMode, "usageMode", 9);

	// ptx
	CU_ASSERT_NSTRING_EQUAL(u.dependends->ptx->gpuProfileName, "p2", 2);
	CU_ASSERT_NSTRING_EQUAL(u.dependends->ptx->ptx, "ptx2", 4);
	CU_ASSERT( u.dependends->ptx[1].gpuProfileName == NULL);
	CU_ASSERT( u.dependends->ptx[1].ptx == NULL);

	// cubin
	CU_ASSERT_NSTRING_EQUAL(u.dependends->cubin->gpuProfileName, "p2", 2);
	CU_ASSERT_NSTRING_EQUAL(u.dependends->cubin->cubin, "cubin2", 6);
	CU_ASSERT( u.dependends->cubin[1].gpuProfileName == NULL);
	CU_ASSERT( u.dependends->cubin[1].cubin == NULL);

	// debug
	CU_ASSERT_NSTRING_EQUAL(u.dependends->debug->gpuProfileName, "p2", 2);
	CU_ASSERT_NSTRING_EQUAL(u.dependends->debug->debug, "debug2", 6);
	CU_ASSERT_EQUAL(u.dependends->debug->size, 1);
	CU_ASSERT_PTR_EQUAL(u.dependends->debug->next, NULL);

	// elf
	CU_ASSERT_NSTRING_EQUAL(u.dependends->elf->gpuProfileName, "p2", 2);
	CU_ASSERT_NSTRING_EQUAL(u.dependends->elf->elf, "elf2", 4);
	CU_ASSERT_EQUAL(u.dependends->elf->size, 1);
	CU_ASSERT_PTR_EQUAL(u.dependends->elf->next, NULL);

	// exported
	CU_ASSERT_NSTRING_EQUAL(u.dependends->exported->name, "s2", 2);
	CU_ASSERT_NSTRING_EQUAL(u.dependends->exported[1].name, "sym2", 4);
	CU_ASSERT( u.dependends->exported[2].name == NULL);

	// imported
	CU_ASSERT_NSTRING_EQUAL(u.dependends->imported->name, "s2", 7);
	CU_ASSERT_NSTRING_EQUAL(u.dependends->imported[1].name, "sym2", 4);
	CU_ASSERT( u.dependends->imported[2].name == NULL);

	CU_ASSERT_PTR_EQUAL(u.dependends->dependends, NULL); */


	free(u.key);
	free(u.ident);
	free(u.usageMode);

	free(u.ptx->gpuProfileName);
	free(u.ptx->ptx);
	free(u.ptx);

	free(u.cubin->gpuProfileName);
	free(u.cubin->cubin);
	free(u.cubin);

	free(u.debug->gpuProfileName);
	free(u.debug->debug);
	free(u.debug);

	free(u.elf->gpuProfileName);
	free(u.elf->elf);
	free(u.elf);

	free(u.exported[0].name);
	free(u.exported[1].name);
	free(u.exported);

	free(u.imported[1].name);
	free(u.imported[0].name);
	free(u.imported);

	free(pPacket);

}

void test_packunpack(void){
	__cudaFatCudaBinary b, u;
	cache_num_entries_t cache = {0, 0, 0, 0, 0, 0, 0};
	int size = 0;

	__cudaFatDebugEntry deb_term = {NULL, NULL, NULL, 0};
	__cudaFatElfEntry ELF_TERM = { NULL, NULL, NULL, 0};

	__cudaFatPtxEntry ptx[] = { {"gpuProf", "ptx"},{NULL, NULL}};
	__cudaFatCubinEntry cubin[] = { {"profiler", "cubin"}, {NULL, NULL}};
	__cudaFatDebugEntry debug[] = { {"prof", "debug", &deb_term, 1} };
	__cudaFatElfEntry elf[] = { {"prof", "elf", &ELF_TERM, 3}};
	__cudaFatSymbol sym[] = {{"symbol1"}, {"sym2"}, {NULL}};

	b.magic = 10;
	b.version = 20;
	b.gpuInfoVersion = 30;
	b.flags = 38;
	b.characteristic = 2;
	b.key = "key";
	b.ident = "ident";
	b.usageMode = "usageMode";

	b.debugInfo = &cache;

	b.ptx = ptx;
	b.cubin = cubin;
	b.debug = debug;
	b.elf = elf;
	b.exported = sym;
	b.imported = sym;
	b.dependends = NULL;

	// reserve the right amount of memory
	size = getFatRecPktSize(&b, &cache);
	char * pPacket = malloc(size);

	CU_ASSERT_EQUAL(cache.nptxs, 1);
	CU_ASSERT_EQUAL(cache.ncubs, 1);
	CU_ASSERT_EQUAL(cache.ndebs, 1);
	CU_ASSERT_EQUAL(cache.nexps, 2);
	CU_ASSERT_EQUAL(cache.nimps, 2);
	CU_ASSERT_EQUAL(cache.ndeps, 0);
	CU_ASSERT_EQUAL(cache.nelves, 1);


	CU_ASSERT_NOT_EQUAL(packFatBinary(pPacket, &b, &cache), ERROR);

	CU_ASSERT_NOT_EQUAL(unpackFatBinary(&u,pPacket), ERROR );

	CU_ASSERT_EQUAL(u.magic, b.magic);
	CU_ASSERT_EQUAL(u.version, b.version);
	CU_ASSERT_EQUAL(u.gpuInfoVersion, b.gpuInfoVersion);
	CU_ASSERT_EQUAL(u.flags,  b.flags);
	CU_ASSERT_EQUAL( b.characteristic, u.characteristic);

	CU_ASSERT( strcmp("key", u.key) == 0);
	CU_ASSERT( strcmp("ident", u.ident) == 0);
	CU_ASSERT( strcmp("usageMode", u.usageMode) == 0);

	CU_ASSERT( u.debugInfo == &cache);

	// ptx
	CU_ASSERT_NSTRING_EQUAL(u.ptx->gpuProfileName, "gpuProf", 7);
	CU_ASSERT_NSTRING_EQUAL(u.ptx->ptx, "ptx", 3);
	CU_ASSERT( u.ptx[1].gpuProfileName == NULL);
	CU_ASSERT( u.ptx[1].ptx == NULL);

	// cubin
	CU_ASSERT_NSTRING_EQUAL(u.cubin->gpuProfileName, "profiler", 8);
	CU_ASSERT_NSTRING_EQUAL(u.cubin->cubin, "cubin", 5);
	CU_ASSERT( u.cubin[1].gpuProfileName == NULL);
	CU_ASSERT( u.cubin[1].cubin == NULL);

	// debug
	CU_ASSERT_NSTRING_EQUAL(u.debug->gpuProfileName, "prof", 4);
	CU_ASSERT_NSTRING_EQUAL(u.debug->debug, "debug", 5);
	CU_ASSERT_EQUAL(u.debug->size, 1);
	CU_ASSERT_PTR_NOT_NULL(u.debug->next);
	// debug terminator
	CU_ASSERT_PTR_NULL(u.debug->next->gpuProfileName);
	CU_ASSERT_PTR_NULL(u.debug->next->debug);
	CU_ASSERT_PTR_NULL(u.debug->next->next);
	CU_ASSERT_EQUAL(u.debug->next->size, 0);

	// elf
	CU_ASSERT_NSTRING_EQUAL(u.elf->gpuProfileName, "prof", 4);
	CU_ASSERT_NSTRING_EQUAL(u.elf->elf, "elf", 3);
	CU_ASSERT_EQUAL(u.elf->size, 3);
	CU_ASSERT_PTR_NOT_NULL(u.elf->next);
	// elf terminator
	CU_ASSERT_PTR_NULL(u.elf->next->gpuProfileName);
	CU_ASSERT_PTR_NULL(u.elf->next->elf);
	CU_ASSERT_PTR_NULL(u.elf->next->next);
	CU_ASSERT_EQUAL(u.elf->next->size, 0);


	// exported
	CU_ASSERT_NSTRING_EQUAL(u.exported->name, "symbol1", 7);
	CU_ASSERT_NSTRING_EQUAL(u.exported[1].name, "sym2", 4);
	CU_ASSERT( u.exported[2].name == NULL);

	// imported
	CU_ASSERT_NSTRING_EQUAL(u.imported->name, "symbol1", 7);
	CU_ASSERT_NSTRING_EQUAL(u.imported[1].name, "sym2", 4);
	CU_ASSERT( u.imported[2].name == NULL);

	// dependends
	CU_ASSERT(NULL == u.dependends);

	//cleaning the memory mess
 	free(u.key);
	free(u.ident);
	free(u.usageMode);

	free(u.ptx->gpuProfileName);
	free(u.ptx->ptx);
	free(u.ptx);

	free(u.cubin->gpuProfileName);
	free(u.cubin->cubin);
	free(u.cubin);

	free(u.debug->gpuProfileName);
	free(u.debug->debug);
	free(u.debug);

	free(u.elf->gpuProfileName);
	free(u.elf->elf);
	free(u.elf);

	free(u.exported[0].name);
	free(u.exported[1].name);
	free(u.exported);

	free(u.imported[1].name);
	free(u.imported[0].name);
	free(u.imported);


	free(pPacket);
}
// ----------------- regFuncArgs tests
void test_l_getPtrPktSize(void){
	uint3 u;
	dim3 d;
	int i;

	// first uint3
	CU_ASSERT_EQUAL(l_getUint3PtrPktSize(NULL), sizeof(void*));
	CU_ASSERT_EQUAL(l_getUint3PtrPktSize(&u), sizeof(void*)+3*sizeof(u.x));

	// dim3
	CU_ASSERT_EQUAL(l_getDim3PtrPktSize(NULL), sizeof(void*));
	CU_ASSERT_EQUAL(l_getDim3PtrPktSize(&d), sizeof(void*)+3*sizeof(d.x));

	// int
	CU_ASSERT_EQUAL(l_getIntPtrPktSize(NULL), sizeof(void*));
	CU_ASSERT_EQUAL(l_getIntPtrPktSize(&i), sizeof(void*)+sizeof(int));
}

void test_l_getSize_regFuncArgs(void){
	int size;
	int expected;
	// what fields are expected
	int core_expected = sizeof(void*) // pointer
		+ 3* sizeof(size_pkt_field_t)	// three headers for strings (length field)
		+ sizeof(void*) // one for storing a pointer to the string
		+ sizeof(int) // thread
		+ 5 * sizeof(void*); // pointers

	// 1.
	size = l_getSize_regFuncArgs((void**)0x14b1d490, "123", "_Z12square_arrayPfi", "_Z12square_arrayPfi", -1,
				NULL, NULL, NULL, NULL, NULL);
	expected = strlen("123")
			+ strlen("_Z12square_arrayPfi")
			+ strlen("_Z12square_arrayPfi")
			+ core_expected;

	CU_ASSERT_EQUAL(size, expected);

	// 2. null things
	size = l_getSize_regFuncArgs(NULL, NULL, NULL, NULL, -1,
					NULL, NULL, NULL, NULL, NULL);
	expected = core_expected;
	CU_ASSERT_EQUAL(size, expected);

	// 3. not null things
	uint3 i1 = {1,2,2};
	uint3 i2 = {1,3,2};
	dim3 d1 = {3,3,3};
	dim3 d2  = {2,3,4};
	int i = 1341;

	size = l_getSize_regFuncArgs(NULL, "123", "a", "b", -1, &i1, &i2, &d1, &d2, &i);
	expected = core_expected
			+ 5 // string length
			+ 6 * sizeof(i1.x) + 6 * sizeof(d1.x) + sizeof(int);
	CU_ASSERT_EQUAL(size, expected);
}

void test_l_getSize_regVar(void){
	int size;
	int expected;
	// what fields are expected
	int core_expected = sizeof(void*) // pointer
			+ 2* sizeof(size_pkt_field_t)	// three headers for strings (length field)
			+ sizeof(void*) // one for storing a pointer to the string
			+ 4*sizeof(int); // ext, vsize, constant, global

	// 1.
	size = l_getSize_regVar((void**)0x14b1d490, (char*)0x134, "d_OptionData", "d_OptionData", 0,
			40960, 1, 0);
	expected = strlen("d_OptionData")
				+ strlen("d_OptionData")
				+ core_expected;
	CU_ASSERT_EQUAL(size, expected);

	// 2. null things
	size = l_getSize_regVar(NULL, NULL, NULL, NULL, 1, 2, 3, 13);
	expected = core_expected;
	CU_ASSERT_EQUAL(size, expected);
}

void test_l_packUnpackUint3Ptr(void){
	char arr[100];
	int offset;
	uint3 * pU;

	// 0. pack from NULL src
	offset = l_packUint3Ptr(NULL, NULL);
	CU_ASSERT_EQUAL(offset, ERROR);

	// 1. pack/unpack NULL pointer
	offset = l_packUint3Ptr(arr, NULL);
	CU_ASSERT_EQUAL(offset, sizeof(void*));
	offset = 0;
	pU = l_unpackUint3Ptr(arr, &offset);
	CU_ASSERT_EQUAL(offset, sizeof(void*));
	CU_ASSERT_PTR_NULL(pU);

	// 2. unpack NULL
	offset = 4;
	pU = l_unpackUint3Ptr(NULL, &offset);
	CU_ASSERT_PTR_NULL(pU);
	CU_ASSERT_EQUAL(offset, ERROR);

	// 3. pack/unpack normal non-NULL
	uint3 u = { 1, 13, 5};
	offset = l_packUint3Ptr(arr, &u);
	CU_ASSERT_EQUAL(offset, sizeof(void*) + 3*sizeof(u.x));
	offset = 0;
	pU = l_unpackUint3Ptr(arr, &offset);
	CU_ASSERT_EQUAL(offset, sizeof(void*) + 3*sizeof(u.x));
	CU_ASSERT_PTR_NOT_NULL(pU);
	CU_ASSERT_EQUAL(pU->x, 1);
	CU_ASSERT_EQUAL(pU->y, 13);
	CU_ASSERT_EQUAL(pU->z, 5);

	free(pU);
}

void test_l_packUnpackDim3Ptr(void){
	char arr[100];
	int offset;
	dim3 * pU;

	// 0. pack from NULL src
	offset = l_packDim3Ptr(NULL, NULL);
	CU_ASSERT_EQUAL(offset, ERROR);

	// 1. pack/unpack NULL pointer
	offset = l_packDim3Ptr(arr, NULL);
	CU_ASSERT_EQUAL(offset, sizeof(void*));
	offset = 0;
	pU = l_unpackDim3Ptr(arr, &offset);
	CU_ASSERT_EQUAL(offset, sizeof(void*));
	CU_ASSERT_PTR_NULL(pU);

	// 2. unpack NULL
	offset = 4;
	pU = l_unpackDim3Ptr(NULL, &offset);
	CU_ASSERT_PTR_NULL(pU);
	CU_ASSERT_EQUAL(offset, ERROR);

	// 3. pack/unpack normal non-NULL
	dim3 u = { 1, 13, 5};
	offset = l_packDim3Ptr(arr, &u);
	CU_ASSERT_EQUAL(offset, sizeof(void*) + 3*sizeof(u.x));
	offset = 0;
	pU = l_unpackDim3Ptr(arr, &offset);
	CU_ASSERT_EQUAL(offset, sizeof(void*) + 3*sizeof(u.x));
	CU_ASSERT_PTR_NOT_NULL(pU);
	CU_ASSERT_EQUAL(pU->x, 1);
	CU_ASSERT_EQUAL(pU->y, 13);
	CU_ASSERT_EQUAL(pU->z, 5);

	free(pU);
}

void test_l_packUnpackIntPtr(void){
	char arr[100];
	int offset;
	int * pU;

	// 0. pack from NULL src
	offset = l_packIntPtr(NULL, NULL);
	CU_ASSERT_EQUAL(offset, ERROR);

	// 1. pack/unpack NULL pointer
	offset = l_packIntPtr(arr, NULL);
	CU_ASSERT_EQUAL(offset, sizeof(void*));
	offset = 0;
	pU = l_unpackIntPtr(arr, &offset);
	CU_ASSERT_EQUAL(offset, sizeof(void*));
	CU_ASSERT_PTR_NULL(pU);

	// 2. unpack NULL
	offset = 4;
	pU = l_unpackIntPtr(NULL, &offset);
	CU_ASSERT_PTR_NULL(pU);
	CU_ASSERT_EQUAL(offset, ERROR);

	// 3. pack/unpack normal non-NULL
	int u = 13;
	offset = l_packIntPtr(arr, &u);
	CU_ASSERT_EQUAL(offset, sizeof(int*) + sizeof(int));
	offset = 0;
	pU = l_unpackIntPtr(arr, &offset);
	CU_ASSERT_EQUAL(offset, sizeof(int*) + sizeof(int));
	CU_ASSERT_PTR_NOT_NULL(pU);
	CU_ASSERT_EQUAL(*pU, 13);
}

void test_l_packUnpackRegFuncArgs(void){
   reg_func_args_t a;
   char * pack;
   const char * str1 = "hej1";
   char * str2 = "h";
   const char * str3 = "a";
   uint3 u1 = {1, 3,3};
   uint3 u2 = {1, 13, 10};
   dim3 d1 = {1,4, 5};
   dim3 d2 = {2, 30, 10};
   int wsize = 13;
   int size;
   int all_size;
   void ** v = (void**)&pack;

   // pack the pack
   pack = packRegFuncArgs(v, str1, str2, str3, -1, &u1, &u2, &d1, &d2, &wsize, &size );

   all_size = sizeof(void*)
		   + sizeof(size_pkt_field_t) + strlen(str1)
		   + sizeof(void*)
		   + sizeof(size_pkt_field_t) + strlen(str2)
		   + sizeof(size_pkt_field_t) + strlen(str3)
		   + sizeof(int)
		   + sizeof(void*) + sizeof(uint3)
		   + sizeof(void*) + sizeof(uint3)
		   + sizeof(void*) + sizeof(dim3)
		   + sizeof(void*) + sizeof(dim3)
		   + sizeof(int*) + sizeof(int);

   CU_ASSERT_EQUAL(size, all_size);
   CU_ASSERT_EQUAL( unpackRegFuncArgs(&a, pack), OK);
   CU_ASSERT_PTR_EQUAL(a.fatCubinHandle, v);
   CU_ASSERT_NSTRING_EQUAL(a.hostFun, str1, strlen(str1));
   CU_ASSERT_PTR_EQUAL(a.hostFEaddr, str1);
   CU_ASSERT_NSTRING_EQUAL(a.deviceFun, str2, strlen(str2));
   CU_ASSERT_NSTRING_EQUAL(a.deviceName, str3, strlen(str3));
   CU_ASSERT_EQUAL(a.thread_limit, -1);
   CU_ASSERT_EQUAL(a.tid->x, u1.x );
   CU_ASSERT_EQUAL(a.tid->y, u1.y );
   CU_ASSERT_EQUAL(a.tid->z, u1.z );
   CU_ASSERT_EQUAL(a.bid->x, u2.x );
   CU_ASSERT_EQUAL(a.bid->y, u2.y );
   CU_ASSERT_EQUAL(a.bid->z, u2.z );
   CU_ASSERT_EQUAL(a.bDim->x, d1.x );
   CU_ASSERT_EQUAL(a.bDim->y, d1.y );
   CU_ASSERT_EQUAL(a.bDim->z, d1.z );
   CU_ASSERT_EQUAL(a.gDim->x, d2.x );
   CU_ASSERT_EQUAL(a.gDim->y, d2.y );
   CU_ASSERT_EQUAL(a.gDim->z, d2.z );
   CU_ASSERT_EQUAL(*a.wSize, wsize)

   free(a.hostFun);
   free(a.deviceFun);
   free(a.deviceName);
   free(a.tid);
   free(a.bid);
   free(a.bDim);
   free(a.gDim);
   free(a.wSize);

   free(pack);
}

void test_freeRegVar(void){
	//@todo to be implemented
}

void test_freeRegFunc(void){
	//@todo to be implemented
}

void test_freeFatBinary(void){
	// @todo to be implemented
}

void test_l_packUnpackRegVar(void){
	reg_var_args_t a;
	char * pack;
	char * str1 = (char*) 0x123;
	char * str2 = "h";
	const char * str3 = "a";

	int size;
	int all_size;
	void ** v = (void**) &pack;

	// 0. hostVar is a real string
	pack = packRegVar(v,str1, str2, str3, 1, 2, 3, 4, &size );
	all_size = sizeof(void*)
				   + sizeof(void*)
				   + sizeof(size_pkt_field_t) + strlen(str2)
				   + sizeof(size_pkt_field_t) + strlen(str3)
				   + sizeof(int) * 4;
	CU_ASSERT_EQUAL(size, all_size);
	CU_ASSERT_EQUAL(unpackRegVar(&a, pack), OK);
	CU_ASSERT_PTR_EQUAL(a.fatCubinHandle, v);
	CU_ASSERT_PTR_EQUAL(a.hostVar, 0x123);
	CU_ASSERT_PTR_NOT_NULL(a.dom0HostAddr);
	CU_ASSERT_NSTRING_EQUAL(a.deviceAddress, str2, strlen(str2));
	CU_ASSERT_NSTRING_EQUAL(a.deviceName, str3, strlen(str3));
	CU_ASSERT_EQUAL(a.ext, 1);
	CU_ASSERT_EQUAL(a.size, 2);
	CU_ASSERT_EQUAL(a.constant, 3);
	CU_ASSERT_EQUAL(a.global, 4);

	free(a.deviceAddress);
	free(a.deviceName);
	free(a.dom0HostAddr);

	free(pack);
}


// -------------------------
// misc

void test_methodIdToString(void){
	char * str;
	char * refStr[] = {"cudaConfigureCall", "cudaUnbindTexture", "__cudaUnregisterFatBinary"};
	int ids[] = {CUDA_CONFIGURE_CALL, CUDA_UNBIND_TEXTURE, __CUDA_UNREGISTER_FAT_BINARY };
	unsigned int i;

	// 1. non existing
	str = methodIdToString(-3);
	CU_ASSERT_PTR_NULL(str);

	// 2. normal situation
	for(i = 0; i < sizeof(ids)/sizeof(int); i++){
		str = methodIdToString(ids[i]);
		CU_ASSERT_NSTRING_EQUAL(str, refStr[i], strlen(refStr[i]));
	}
}

void test_freeBuffer(void){
	char * buffer=NULL;

	buffer = malloc(10);
	CU_ASSERT_PTR_NOT_NULL(buffer);
	buffer = freeBuffer(buffer);
	CU_ASSERT_PTR_NULL(buffer);
}

void test_g_fcia_idx(void){
	GArray * pFcArr = g_array_new(FALSE, FALSE, sizeof(fatcubin_info_t));

	fatcubin_info_t p1, p2;
	fatcubin_info_t *p;
	void ** pV1 = (void**) 0x2;
	void ** pV2 = (void**) 0x3;
	void ** pV3 = (void**) 0x4;

	CU_ASSERT_PTR_NOT_NULL(pFcArr);

	p1.fatCubinHandle = pV1;
	p1.num_reg_fns = 3;
	g_array_append_val(pFcArr, p1);

	CU_ASSERT_EQUAL(pFcArr->len, 1);

	p2.fatCubinHandle = pV2;
	p2.num_reg_fns = 2;
	g_array_append_val(pFcArr, p2);
	CU_ASSERT_EQUAL(pFcArr->len, 2);

	int idx = -2;
	// 0. check what happens with NULL array
	idx = g_fcia_idx(NULL, pV3);
	CU_ASSERT_EQUAL(idx, -1);

	// 1. now not null array and not existing fatcubin
	idx = -2;
	idx = g_fcia_idx(pFcArr, pV3);
	CU_ASSERT_EQUAL(idx, -1);

	// 2. now not null array and NULL pointer to find (not existing)
	idx = -2;
	idx = g_fcia_idx(pFcArr, NULL);
	CU_ASSERT_EQUAL(idx, -1);

	// 3. now try to find the existing value
	idx = -2;
	idx = g_fcia_idx(pFcArr, pV1);
	CU_ASSERT_NOT_EQUAL(idx, -1);
	p = &g_array_index(pFcArr, fatcubin_info_t, idx);
	CU_ASSERT_PTR_EQUAL(p->fatCubinHandle, pV1);
	CU_ASSERT_EQUAL(p->num_reg_fns, 3);


	// 4. another value
	idx = -2;
	idx = g_fcia_idx(pFcArr, pV2);
	CU_ASSERT_NOT_EQUAL(idx, -1);
	p = &g_array_index(pFcArr, fatcubin_info_t, idx);
	CU_ASSERT_PTR_EQUAL(p->fatCubinHandle, pV2);
	CU_ASSERT_EQUAL(p->num_reg_fns, 2);


	// it should free the elements as well

	g_array_free(pFcArr, TRUE);
}

void test_g_fcia_elem(void){
	GArray * pFcArr = g_array_new(FALSE, FALSE, sizeof(fatcubin_info_t));
	void ** pV1 = (void **) 0x1;
	void ** pV2 = (void **) 0x2;
	void ** pV3 = (void **) 0x3;
	fatcubin_info_t * p = NULL;

	CU_ASSERT_PTR_NOT_NULL(pFcArr);

	// feed our array
	fatcubin_info_t * pFatCInfo1 = malloc(sizeof(fatcubin_info_t));
	CU_ASSERT_PTR_NOT_NULL(pFatCInfo1);
	pFatCInfo1->fatCubinHandle = pV1;
	pFatCInfo1->num_reg_fns = 3;
	g_array_append_val(pFcArr, *pFatCInfo1);

	CU_ASSERT_EQUAL(pFcArr->len, 1);

	fatcubin_info_t * pFatCInfo2 = malloc(sizeof(fatcubin_info_t));
	CU_ASSERT_PTR_NOT_NULL(pFatCInfo2);
	pFatCInfo2->fatCubinHandle = pV2;
	pFatCInfo2->num_reg_fns = 2;
	g_array_append_val(pFcArr, *pFatCInfo2);
	CU_ASSERT_EQUAL(pFcArr->len, 2);


	// 0. check what happens with NULL array
	p = g_fcia_elem(NULL, pV3);
	CU_ASSERT_PTR_NULL(p);

	// 1. now not null array and not existing fatcubin
	p = NULL;
	p = g_fcia_elem(pFcArr, pV3);
	CU_ASSERT_PTR_NULL(p);

	// 2. now not null array and NULL pointer to find (not existing)
	p = g_fcia_elem(pFcArr, NULL);
	CU_ASSERT_PTR_NULL(p);

	// 3. now try to find the existing value
	p = g_fcia_elem(pFcArr, pV1);
	CU_ASSERT_PTR_NOT_NULL(p);
	CU_ASSERT_PTR_EQUAL(p->fatCubinHandle, pV1);
	CU_ASSERT_EQUAL(p->num_reg_fns, 3);

	// 4. another existing
	p = g_fcia_elem(pFcArr, pV2);
	CU_ASSERT_PTR_NOT_NULL(p);
	CU_ASSERT_PTR_EQUAL(p->fatCubinHandle, pV2);
	CU_ASSERT_EQUAL(p->num_reg_fns, 2);

	free(pFatCInfo1);
	free(pFatCInfo2);
	// it should free the elements as well
	g_array_free(pFcArr, TRUE);
}

void test_g_fcia_elidx(void){
	GArray * pFcArr = g_array_new(FALSE, FALSE, sizeof(fatcubin_info_t));

	fatcubin_info_t p1, p2;
	fatcubin_info_t *p;
	int idx = -2;
	void ** pV1 = (void**) 0x2;
	void ** pV2 = (void**) 0x3;
	void ** pV3 = (void**) 0x4;

	CU_ASSERT_PTR_NOT_NULL(pFcArr);

	p1.fatCubinHandle = pV1;
	p1.num_reg_fns = 3;
	g_array_append_val(pFcArr, p1);

	CU_ASSERT_EQUAL(pFcArr->len, 1);

	p2.fatCubinHandle = pV2;
	p2.num_reg_fns = 2;
	g_array_append_val(pFcArr, p2);
	CU_ASSERT_EQUAL(pFcArr->len, 2);

	// 0. check what happens with NULL array
	p = g_fcia_elidx(NULL, pV3, &idx);
	CU_ASSERT_EQUAL(idx, -1);
	CU_ASSERT_PTR_NULL(p);

	// 1. now not null array and not existing fatcubin
	idx = -2;
	p = g_fcia_elidx(pFcArr, pV3, &idx);
	CU_ASSERT_PTR_NULL(p);
	CU_ASSERT_EQUAL(idx, -1);

	// 2. now not null array and NULL pointer to find (not existing)
	idx = -2;
	p = g_fcia_elidx(pFcArr, NULL, &idx);
	CU_ASSERT_EQUAL(idx, -1);
	CU_ASSERT_PTR_NULL(p);

	// 3. now try to find the existing value
	idx = -2;
	p = g_fcia_elidx(pFcArr, pV1, &idx);
	CU_ASSERT_NOT_EQUAL(idx, -1);
	p = &g_array_index(pFcArr, fatcubin_info_t, idx);
	CU_ASSERT_PTR_EQUAL(p->fatCubinHandle, pV1);
	CU_ASSERT_EQUAL(p->num_reg_fns, 3);


	// 4. another value
	idx = -2;
	p = g_fcia_elidx(pFcArr, pV2, &idx);
	CU_ASSERT_NOT_EQUAL(idx, -1);
	p = &g_array_index(pFcArr, fatcubin_info_t, idx);
	CU_ASSERT_PTR_EQUAL(p->fatCubinHandle, pV2);
	CU_ASSERT_EQUAL(p->num_reg_fns, 2);

	g_array_free(pFcArr, TRUE);
}

void test_g_fcia_host_var(void){
	GArray * pFcArr = g_array_new(FALSE, FALSE, sizeof(fatcubin_info_t));

	fatcubin_info_t p1, p2;
	fatcubin_info_t *p;
	int idx = -2;
	void ** pV1 = (void**) 0x2;
	void ** pV2 = (void**) 0x3;
	char *hostVar1 = (char *) 0x1;
	char *hostVar2 = (char *) 0x2;

	reg_var_args_t v1, v2;


	v1.hostVar = hostVar1;
	v1.fatCubinHandle = pV1;

	v2.hostVar = hostVar2;
	v2.fatCubinHandle = pV1;


	CU_ASSERT_PTR_NOT_NULL(pFcArr);

	p1.fatCubinHandle = pV1;
	p1.num_reg_fns = 3;
	p1.num_reg_vars = 2;
	p1.variables[0] = &v1;
	p1.variables[1] = &v2;

	g_array_append_val(pFcArr, p1);

	CU_ASSERT_EQUAL(pFcArr->len, 1);

	p2.fatCubinHandle = pV2;
	p2.num_reg_fns = 2;
	p2.num_reg_vars = 0;
	g_array_append_val(pFcArr, p2);
	CU_ASSERT_EQUAL(pFcArr->len, 2);

	// 0a. start with NULL pFcArr
	CU_ASSERT_PTR_NULL(g_fcia_host_var(NULL, (char*) 0x23, &idx ));

	// 0b. check NULL hostVar
	CU_ASSERT_PTR_NULL(g_fcia_host_var(pFcArr, NULL,&idx));

	// 1. ask about not existing hostVar
	CU_ASSERT_PTR_NULL(g_fcia_host_var(pFcArr, (char*) 0x13, &idx));

	// 2. ask about correct values
	p = g_fcia_host_var(pFcArr, hostVar1, &idx);
	CU_ASSERT_PTR_NOT_NULL(p);
	CU_ASSERT_EQUAL(p->variables[0]->hostVar,hostVar1);

	p = g_fcia_host_var(pFcArr, hostVar2, &idx);
	CU_ASSERT_PTR_NOT_NULL(p);
	CU_ASSERT_EQUAL(p->variables[1]->hostVar, (char*)0x2);


	g_array_free(pFcArr, TRUE);
}

void test_g_vars_insert(void){
	GHashTable * table;

	void ** h1 = (void**) 0x1;
	void ** h2 = (void**) 0x13;

	vars_val_t vars[] = { {(void*) 0x23, "v1"}, {(void *) 0x333, "v2"},
			{(void*) 0x1234, "v3"}};

	vars_val_t * v;

	// create a table
	table = g_hash_table_new(g_direct_hash, g_direct_equal);
	CU_ASSERT_EQUAL(g_hash_table_size(table), 0);

	// 0a. try to add a NULL handler
	CU_ASSERT_PTR_NULL(g_vars_insert(table, NULL, &vars[0]));
	CU_ASSERT_EQUAL(g_hash_table_size(table), 0);

	// 0a. try to add a NULL var
	CU_ASSERT_PTR_NULL(g_vars_insert(table, h1, NULL));
	CU_ASSERT_EQUAL(g_hash_table_size(table), 0);

	// 1. try to add a regular handler
	CU_ASSERT_PTR_NOT_NULL(g_vars_insert(table, h1, &vars[0]));
	CU_ASSERT_EQUAL(g_hash_table_size(table), 1);

	GPtrArray * p = NULL;

	p = g_hash_table_lookup(table, h1);
	v = g_ptr_array_index(p, 0);
	CU_ASSERT_EQUAL(v, &vars[0]);
	CU_ASSERT_EQUAL(v->deviceName, vars[0].deviceName);
	CU_ASSERT_EQUAL(v->hostVar, (void*)0x23)

	// 2. try to add another value
	CU_ASSERT_PTR_NOT_NULL(g_vars_insert(table, h1, &vars[1]));
	CU_ASSERT_EQUAL(g_hash_table_size(table), 1);

	p = g_hash_table_lookup(table, h1);
	v = g_ptr_array_index(p, 1);
	CU_ASSERT_EQUAL(v, &vars[1]);
	CU_ASSERT_EQUAL(v->deviceName, vars[1].deviceName);
	CU_ASSERT_EQUAL(v->hostVar, vars[1].hostVar);

	// 3. now add a new value to a new handler
	CU_ASSERT_PTR_NOT_NULL(g_vars_insert(table, h2, &vars[1]));
	CU_ASSERT_EQUAL(g_hash_table_size(table), 2);

	p = g_hash_table_lookup(table, h2);
	v = g_ptr_array_index(p, 0);
	CU_ASSERT_EQUAL(v, &vars[1]);
	CU_ASSERT_EQUAL(v->deviceName, vars[1].deviceName);
	CU_ASSERT_EQUAL(v->hostVar, vars[1].hostVar);

	// 3. now add a new value to a new handler
	CU_ASSERT_PTR_NOT_NULL(g_vars_insert(table, h2, &vars[2]));
	CU_ASSERT_EQUAL(g_hash_table_size(table), 2);

	p = g_hash_table_lookup(table, h2);

	v = g_ptr_array_index(p, 1);
	CU_ASSERT_EQUAL(v, &vars[2]);
	CU_ASSERT_EQUAL(v->deviceName, vars[2].deviceName);
	CU_ASSERT_EQUAL(v->hostVar, vars[2].hostVar);

	// free the table
	g_ptr_array_free(g_hash_table_lookup(table, h1), TRUE);
	g_ptr_array_free(g_hash_table_lookup(table, h2), TRUE);
	g_hash_table_destroy(table);
}

void test_g_vars_find(void){
	GHashTable * table;
	void ** h[] = {(void**) 0x1, (void**) 0x13 };
	vars_val_t vars1[] = { {(void *) 0x23, "v1"}, { (void*) 0x234, "v2"}, {(void*) 0x2345, "v3"} };
	vars_val_t vars2[] = { {(void*) 0x13, "a1"}, {(void*) 0x56, "a2"} };
	vars_val_t vars3[] = { {(void*) 0x11, "x"} };
	const int A_SIZE = 2;
	GPtrArray * a[A_SIZE];
	int i;

	// create a table
	table = g_hash_table_new(g_direct_hash, g_direct_equal);
	for(i = 0; i < A_SIZE; i ++)
		a[i] = g_ptr_array_new();
	for(i = 0; i < 3; i ++)
		g_ptr_array_add(a[0], &vars1[i]);

	CU_ASSERT_EQUAL( a[0]->len, 3);

	for(i = 0; i < 2; i ++)
		g_ptr_array_add(a[1], &vars2[i]);

	CU_ASSERT_EQUAL( a[1]->len, 2);

	g_hash_table_insert(table, h[0], a[0]);
	g_hash_table_insert(table, h[1], a[1]);

	printRegVarTab(table);

	CU_ASSERT_EQUAL(g_hash_table_size(table), 2);

	// 0a. try to find something in a NULL regHostVarsTab
	CU_ASSERT_PTR_NULL( g_vars_find(NULL, vars1[0].deviceName ));

	// 0b. try to find a NULL hostVar in a non-null table
	CU_ASSERT_PTR_NULL( g_vars_find(table, NULL ));

	// 1a. try to find not existing pointer; @todo issues with this test
	//CU_ASSERT_PTR_NULL( g_vars_find(table, vars3[0].hostVar ));

	// 1b. try to find non existing string
	CU_ASSERT_PTR_NULL( g_vars_find(table, "hej" ));

	// 2. try to find all existing existing
	for(i = 0; i < 3; i++){
		// check against fields hostVar
		CU_ASSERT_PTR_EQUAL( g_vars_find(table, vars1[i].hostVar ), vars1[i].hostVar);
		// check against deviceName
		CU_ASSERT_PTR_EQUAL( g_vars_find(table, vars1[i].deviceName ), vars1[i].hostVar);
	}

	for(i = 0; i < 2; i++){
		// check against fields hostVar
		CU_ASSERT_PTR_EQUAL( g_vars_find(table, vars2[i].hostVar ), vars2[i].hostVar);
		// check against deviceName
		CU_ASSERT_PTR_EQUAL( g_vars_find(table, vars2[i].deviceName ), vars2[i].hostVar);
	}

	// free the memory
	g_ptr_array_free(a[0], TRUE);
	g_ptr_array_free(a[1], TRUE);

	g_hash_table_destroy(table);
}

void test_g_vars_remove(void){
	GHashTable * table;
	const int HANDLERS = 10;
	void ** h[HANDLERS];
	vars_val_t vars1[] = { {(void *) 0x23, "v1"}, { (void*) 0x234, "v2"}, {(void*) 0x2345, "v3"} };

	GPtrArray * a[HANDLERS];
	int i, j;

	// create a table
	table = g_hash_table_new(g_direct_hash, g_direct_equal);

	for(i = 0; i < HANDLERS; i ++){
		a[i] = g_ptr_array_new();
		for(j = 0; j < 3; j ++)
			g_ptr_array_add(a[i], &vars1[j]);
		CU_ASSERT_EQUAL( a[i]->len, 3);
	}

	for( i = 0; i < HANDLERS; i ++)
		h[i] = (void **) GINT_TO_POINTER(i * 2 + 3);

	for( i = 0; i < HANDLERS; i ++ )
		g_hash_table_insert(table, h[i], a);

	CU_ASSERT_EQUAL(g_hash_table_size(table), 10);


	// 0. test NULL values; write now skip
	CU_ASSERT_EQUAL(g_vars_remove(table, NULL), OK);
	CU_ASSERT_EQUAL(g_hash_table_size(table), 10);
	CU_ASSERT_EQUAL(g_vars_remove(NULL, h[0]), OK);
	CU_ASSERT_EQUAL(g_hash_table_size(table), 10);

	// 1. remove all handlers
	for( i = 0; i < HANDLERS; i++){
		g_vars_remove(table, h[i]);
		CU_ASSERT_EQUAL(g_hash_table_size(table), (unsigned int) HANDLERS - i - 1);
		//CU_ASSERT_EQUAL(g_hash_table_size(table), (unsigned int) HANDLERS - i);
	}

	g_hash_table_destroy(table);
}



void test_g_vars_remove_val(void){
	const guint HANDLERS = 3;
	GPtrArray * a;
	vars_val_t vars1[] = { {(void *) 0x23, "v1"}, { (void*) 0x234, "v2"}, {(void*) 0x2345, "v3"} };
	guint j;

	// create tables
	a= g_ptr_array_new();
	for(j = 0; j < HANDLERS; j ++)
		g_ptr_array_add(a, g_vars_val_new((char *)&HANDLERS, "hey") );
	CU_ASSERT_EQUAL( a->len, HANDLERS);

	// 0. test with a null pointer
	g_vars_remove_val(NULL);
	CU_ASSERT_EQUAL( a->len, HANDLERS);

	// 1. test removing the array - whatever
	// @todo you should test it better, partially it is tested in g_vars_remove_val
	g_vars_remove_val((gpointer) a);
}

void test_g_vars_val_newdel(void){
	vars_val_t * v;

	// 0. add NULL hostVar
	v = g_vars_val_new(NULL, "hej");
	CU_ASSERT_PTR_NOT_NULL(v);
	CU_ASSERT_PTR_NULL(v->hostVar);
	CU_ASSERT_STRING_EQUAL(v->deviceName, "hej");
	v = g_vars_val_delete(v);
	CU_ASSERT_PTR_NULL(v);

	// 1. add NULL deviceName
	v = g_vars_val_new((void*)0x1, NULL);
	CU_ASSERT_PTR_NOT_NULL(v);
	CU_ASSERT_PTR_NULL(v->deviceName);
	CU_ASSERT_PTR_EQUAL(v->hostVar, (void*)0x1);
	v = g_vars_val_delete(v);
	CU_ASSERT_PTR_NULL(v);

	// 2. add non-Null things
	char * devName = "deviceName";
	char * p;

	v = g_vars_val_new(p, devName);
	CU_ASSERT_PTR_NOT_NULL(v);
	CU_ASSERT_STRING_EQUAL(v->deviceName, devName);
	CU_ASSERT_PTR_EQUAL(v->hostVar, p);
	v = g_vars_val_delete(v);
	CU_ASSERT_PTR_NULL(v);
	CU_ASSERT_STRING_EQUAL(devName, "deviceName");
}

/* The main() function for setting up and running the tests.
 * Returns a CUE_SUCCESS on successful running, another
 * CUnit error code on failure.
 */
int main()
{
   CU_pSuite pSuite = NULL;
   CU_pSuite pSuitePack = NULL;
   CU_pSuite pSuiteRegFuncArgs = NULL;
   CU_pSuite pSuiteRegVar = NULL;
   CU_pSuite pSuiteFcia = NULL;
   CU_pSuite pSuiteMisc = NULL;

   /* initialize the CUnit test registry */
   if (CUE_SUCCESS != CU_initialize_registry())
      return CU_get_error();

   /* add a suite to the registry */
   pSuite = CU_add_suite("FatBinary: GetSizeTest_Suite", init_suite1, clean_suite1);
   if (NULL == pSuite) {
      CU_cleanup_registry();
      return CU_get_error();
   }

   /* add the tests to the suite */
   if ( (NULL == CU_add_test(pSuite, "test of test_l_getStringPktSize", test_l_getStringPktSize)) ||
		(NULL == CU_add_test(pSuite, "test of test_l_getSize__cudaFatPtxEntry", test_l_getSize__cudaFatPtxEntry)) ||
        (NULL == CU_add_test(pSuite, "test of test_l_getSize__cudaFatCubinEntry", test_l_getSize__cudaFatCubinEntry)) ||
        (NULL == CU_add_test(pSuite, "test of test_l_getSize__cudaFatDebugEntry", test_l_getSize__cudaFatDebugEntry)) ||
        (NULL == CU_add_test(pSuite, "test of test_l_getSize__cudaFatElfEntry", test_l_getSize__cudaFatElfEntry)) ||
        (NULL == CU_add_test(pSuite, "test of test_l_getSize__cudaFatSymbolEntry", test_l_getSize__cudaFatSymbolEntry)) ||
        (NULL == CU_add_test(pSuite, "test of test_l_getSize__cudaFatBinaryEntry", test_l_getSize__cudaFatBinaryEntry)) ){
      CU_cleanup_registry();
      return CU_get_error();
   }

   pSuitePack = CU_add_suite("FatBinary PackUnpackTest_Suite", init_suite1, clean_suite1);
   if(NULL == pSuitePack){
	   CU_cleanup_registry();
	   return CU_get_error();
   }
   /* add the tests to the suite */
   if ( (NULL == CU_add_test(pSuitePack, "test of test_packUnpackStr", test_l_packUnpackStr)) ||
		(NULL == CU_add_test(pSuitePack, "test of test_packUnpackPtx", test_l_packUnpackPtx)) ||
		(NULL == CU_add_test(pSuitePack, "test of test_packUnpackCubin", test_l_packUnpackCubin)) ||
		(NULL == CU_add_test(pSuitePack, "test of test_packUnpackDebug", test_l_packUnpackDebug)) ||
		(NULL == CU_add_test(pSuitePack, "test of test_packUnpackElf", test_l_packUnpackElf)) ||
		(NULL == CU_add_test(pSuitePack, "test of test_packUnpackSymbol", test_l_packUnpackSymbol)) ||
		(NULL == CU_add_test(pSuitePack, "test of test_packUnpackDep", test_l_packUnpackDep)) ||
		(NULL == CU_add_test(pSuitePack, "test of test_packunpack", test_packunpack))
		){
      CU_cleanup_registry();
      return CU_get_error();
   }

   pSuiteRegFuncArgs = CU_add_suite("RegFuncArgs Test_Suite", NULL, NULL);
   if(NULL == pSuiteRegFuncArgs){
	   CU_cleanup_registry();
	   return CU_get_error();
   }
   /* add the tests to the suite */
   if ((NULL == CU_add_test(pSuiteRegFuncArgs, "test of test_l_getPtrPktSize", test_l_getPtrPktSize)) ||
	   (NULL == CU_add_test(pSuiteRegFuncArgs, "test of test_l_getSize_regFuncArgs", test_l_getSize_regFuncArgs)) ||
	   (NULL == CU_add_test(pSuiteRegFuncArgs, "test of test_l_packUnpackUint3Ptr", test_l_packUnpackUint3Ptr)) ||
	   (NULL == CU_add_test(pSuiteRegFuncArgs, "test of test_l_packUnpackDim3Ptr", test_l_packUnpackDim3Ptr)) ||
	   (NULL == CU_add_test(pSuiteRegFuncArgs, "test of test_l_packUnpackRegFuncArgs", test_l_packUnpackRegFuncArgs))
   ){
      CU_cleanup_registry();
      return CU_get_error();
   }

   pSuiteRegVar = CU_add_suite("RegVar Test_Suite", NULL, NULL);
   if(NULL == pSuiteRegVar){
	   CU_cleanup_registry();
	   return CU_get_error();
   }
   /* add the tests to the suite */
   if (
	   (NULL == CU_add_test(pSuiteRegVar, "test of test_l_getSize_regVar", test_l_getSize_regVar)) ||
	   (NULL == CU_add_test(pSuiteRegVar, "test of test_l_packUnpackRegVar", test_l_packUnpackRegVar)) ||
	   (NULL == CU_add_test(pSuiteRegVar, "test of test_g_vars_insert", test_g_vars_insert)) ||
	   (NULL == CU_add_test(pSuiteRegVar, "test of test_g_vars_find", test_g_vars_find)) ||
	   (NULL == CU_add_test(pSuiteRegVar, "test of test_g_vars_remove", test_g_vars_remove)) ||
	   (NULL == CU_add_test(pSuiteRegVar, "test of test_g_vars_remove_val", test_g_vars_remove_val)) ||
	   (NULL == CU_add_test(pSuiteRegVar, "test of test_g_vars_val_newdel", test_g_vars_val_newdel))
   ){
      CU_cleanup_registry();
      return CU_get_error();
   }

   pSuiteFcia = CU_add_suite("Fcia Test_Suite", NULL, NULL);
   if(NULL == pSuitePack){
   	   CU_cleanup_registry();
   	   return CU_get_error();
   }

   if (
	   (NULL == CU_add_test(pSuiteFcia, "test_g_fcia_idx", test_g_fcia_idx)) ||
	   (NULL == CU_add_test(pSuiteFcia, "test_g_fcia_elem", test_g_fcia_elem)) ||
	   (NULL == CU_add_test(pSuiteFcia, "test_g_fcia_elidx", test_g_fcia_elidx)) ||
	   (NULL == CU_add_test(pSuiteFcia, "test_g_fcia_host_var", test_g_fcia_host_var))
      ){
	   CU_cleanup_registry();
	   return CU_get_error();
   }


   pSuiteMisc = CU_add_suite("Misc Test_Suite", NULL, NULL);
   if(NULL == pSuitePack){
   	   CU_cleanup_registry();
   	   return CU_get_error();
   }

   if ((NULL == CU_add_test(pSuiteMisc, "test_methodIdToString", test_methodIdToString)) ||
	   (NULL == CU_add_test(pSuiteMisc, "test_freeBuffer", test_freeBuffer))
      ){
	   CU_cleanup_registry();
	   return CU_get_error();
   }

   /* Run all tests using the CUnit Basic interface */
   CU_basic_set_mode(CU_BRM_VERBOSE);
   CU_basic_run_tests();
   CU_cleanup_registry();
   return CU_get_error();
}
