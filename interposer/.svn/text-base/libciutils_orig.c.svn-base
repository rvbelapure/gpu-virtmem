/**
 * @file libciutils.c
 * @brief Have some utils functions copied from cudart.c; but some of them
 * refactored by Magic (MS)
 *
 * @date Mar 1, 2011
 * @author Magda Slawinska, magg __at_ gatech __dot_ edu
 */

#include <__cudaFatFormat.h>
#include <string.h>
#include "libciutils.h"
#include <stdio.h>
#include <stdlib.h>
#include "debug.h"
#include <assert.h>

#include "method_id.h"   // for method identifiers
#include "config.h"		 // for the KIDRON_INI
#include "iniparser.h"   // for dictionary, iniparser_load, etc



/**
 * checks if the memory has been appropriately allocated
 * @todo this function should go to a separate library
 * @param p (in) a pointer to a memory to be verified
 * @param pFuncName the name of the function when the problem occurred
 * @param pExtraMsg if you need to add an extra message
 *
 * @return 0 - pointer ok, -1 pointer not ok
 */
int mallocCheck(const void * const p, const char * const pFuncName,
		const char * pExtraMsg){
	if( NULL == p ){
		printd(DBG_ERROR, "%s: Problems with memory allocation. %s\n", pFuncName, pExtraMsg);
		return ERROR;
	}
	return OK;
}

/**
 * releases the buffer
 *
 * @param pBuffer the buffer to be released
 * @return NULL (always)
 */
inline char * freeBuffer(char * pBuffer){
	free(pBuffer);
	return NULL;
}

/**
 * Reads the interposer:local value from the KIDRON_INI file and returns
 * the numerical value
 *
 * @return 1 - Local GPU will be invoked (means interposer:local is yes)
 *         0 - remote GPU will be invoked (means interposer:local is set no)
 */
inline int l_getLocalFromConfig(void){

	dictionary * d;
	int b;

	d = iniparser_load(KIDRON_INI);
	if(NULL == d){
		printd(DBG_ERROR, "Can't parse the config file. Quitting ... ");
		exit(ERROR);
	}
	b = iniparser_getboolean(d, "interposer:local", -1);

	iniparser_freedict(d);
	if( b == 1 )
		printd(DBG_INFO, "Local GPU will be invoked\n");
	else
		printd(DBG_INFO, "Remote GPU will be invoked\n");

	return b;
	//return 1;
}

/**
 * cleans the structure, frees the allocated memory, sets values to zeros,
 * nulls, etc; intended to be used in __unregisterCudaFatBinary
 */
int cleanFatCubinInfo(fatcubin_info_t * pFatCInfo){
	int i;

	// we assume that the pFatCInfo is not a null pointer
	assert(NULL != pFatCInfo);
	for (i = 0; i < pFatCInfo->num_reg_vars; ++i)
		freeRegVar(pFatCInfo->variables[i]);
	/*	for (i = 0; i < dfi->num_reg_texs; ++i)
					freeRegTex(dfi->textures[i]); */
	for (i = 0; i < pFatCInfo->num_reg_fns; ++i)
		freeRegFunc(pFatCInfo->reg_fns[i]);
		/*for (i = 0; i < dfi->num_reg_shared; ++i) {
		   if (dfi->shared_vars[i] != NULL)
			   free(dfi->shared_vars[i]);
		   else
			   break;
		} */
	freeFatBinary(pFatCInfo->fatCubin);

	pFatCInfo->num_reg_fns = 0;
	pFatCInfo->num_reg_vars = 0;
	pFatCInfo->num_reg_texs = 0;
	pFatCInfo->num_reg_shared = 0;
	pFatCInfo->fatCubinHandle = NULL;
	pFatCInfo->fatCubin = NULL;

	return OK;
}

/**
 * returns the size of the packet for the string
 * |string_length|string|
 *
 * Specific situations:
 * |0|NULL|  indicates string==NULL
 * |0|''|    indicates string=""
 * |2|"12"|  indicates string="12"
 *
 * @param string
 * @return size of the packet for the string
 */
inline int l_getStringPktSize(const char const * string){
	int size = sizeof(size_pkt_field_t);

	if( string == NULL || strlen(string) == 0)
		return size;
	else
		size += strlen(string) * sizeof(char);

	return size;
}

/**
 * gets the size of packeting the __cudaFatCudaBinary -> __cudaFatPtxEntry;
 *
 * @param pEntry (in) the entry we want to count
 * @oaram pEntriesCache (out) the cache for storing entries about FatEntries structures
 * @return the size of the entry (including the size of the pointer to the structure)
 */
int l_getSize__cudaFatPtxEntry(const __cudaFatPtxEntry * pEntry, int * pCounter){
	// the __cudaFatPtxEntry is an array and is terminated with entries
	// that have NULL elements
	int size = 0;
	int i = 0;

	// to store the number of ptx entries
	size += sizeof(size_pkt_field_t);

	*pCounter = 0;

	// size of the string, string, plus NULL terminator
	if (pEntry != NULL) {
		while (pEntry[i].gpuProfileName != NULL && pEntry[i].ptx != NULL) {
			size += l_getStringPktSize(pEntry[i].gpuProfileName);
			size += l_getStringPktSize(pEntry[i].ptx);
			i++;
		}
		*pCounter = i;
	}

	return size;
}

/**
 * gets the size of the packet for the __cudaFatCudaBinary -> __cudaFatCubinEntry
 *
 * @param pEntry (in) the entry we want to count the size of
 * @oaram pEntriesCache (out) the cache for storing entries about FatEntries structures
 * @return the size of the entry (including the size of the pointer to the structure)
 */
int l_getSize__cudaFatCubinEntry(const __cudaFatCubinEntry * pEntry, int * pCounter){
	// the __cudaFatCubinEntry is an array and is terminated with entries
	// that have NULL elements
	int size = 0;
	int i = 0;

	// to store the number of entries
	size += sizeof(size_pkt_field_t);

	*pCounter = 0;

	// size of the string, string, plus NULL terminator
	if (pEntry != NULL) {
		while (pEntry[i].gpuProfileName != NULL && pEntry[i].cubin != NULL) {
			size += l_getStringPktSize(pEntry[i].gpuProfileName) +
					l_getStringPktSize(pEntry[i].cubin);
			i++;
		}
	}
	*pCounter = i;

	return size;
}

/**
 * gets the size of the packet of __cudaFatCudaBinary -> __cudaFatDebugEntry
 *
 * numofdebentries|
 * sizeof string|gpuProfileName|Null|sizeofstring |debug|NULL|size(uint)|
 * sizeof string|gpuProfileName|Null|sizeofstring |debug|NULL|size(uint)|
 * ....
 * as many as numofdebentries
 *
 * @todo new stuff added in comparison to 1.1; need to be tested if this
 * is an array or a list
 *
 * @param pEntry (in) the entry we want to count the size of
 * @oaram pEntriesCache (out) the cache for storing entries about FatEntries structures
 * @return the size packet entry
 */
int l_getSize__cudaFatDebugEntry(__cudaFatDebugEntry * pEntry, int * pCounter){

	// apparently the __cudaFatDebugEntry might be an array
	// that's why we want to iterate through all this elements
	int size = 0;
	__cudaFatDebugEntry * p = pEntry;

	// to store the number of entries
	size += sizeof(size_pkt_field_t);

	*pCounter = 0;

	// Empirical experiments show that the
	// end shows gpuProfileName and debug are NULL
	// and it likely is an array not a list
	while( p && p->gpuProfileName && p->debug ){
		size += l_getStringPktSize(p->gpuProfileName);
		size += l_getStringPktSize(p->debug);
		size += sizeof(p->size);

		(*pCounter) ++;

		p = p->next;
	}

	return size;
}

/**
 * gets the size of the packet of the __cudaFatCudaBinary -> __cudaFatSymbol
 * exported/imported;
 *
 * Again let's assume this is an array that ends with NULL symbol name
 *
 * |0|0|NULL|'1'| might indicate pEntry==NULL
 * |1|0|NULL|NULL| might indicate pEntry!=NULL && pEntry->name == NULL
 * |1|0|''|NULL| might indicate pEntry!=NULL && pEntry->name == ""
 * ....
 *
 * @param pEntry (in) the entry we want to count the size of
 * @param counter (out) a counter to count the entry symbols (zeroed)
 * @return the size of the entry (including the size of the pointer to the structure)
 */
int l_getSize__cudaFatSymbolEntry(const __cudaFatSymbol * pEntry, int * pCounter){
	int size = 0;

	// to store the number of entries
	size += sizeof(size_pkt_field_t);     // counter

	*pCounter = 0;

	if( pEntry == NULL || pEntry->name == NULL){
		size += l_getStringPktSize(NULL);
	} else {
		// let's assume this is an array of symbol names ended with NULL
		// and it is allowable that a name is NULL; but I may be wrong
		while( pEntry->name != NULL ){
			size += l_getStringPktSize(pEntry->name);
			(*pCounter)++;
			pEntry++;
		}
	}

	return size;
}

int l_getFatRecPktSize(const __cudaFatCudaBinary *pFatCubin, cache_num_entries_t * pEntriesCache);

/**
 * gets the size of the __cudaFatCudaBinary -> __cudaFatCubinEntry; includes the
 * size of the pointer to the structure
 *
 * @todo new stuff added in comparison to 1.1
 * @see comment to l_getSize__cudaFatEntryExported(__cudaFatSymbol*)
 *
 * @param pEntry (in) the entry we want to count the size of
 * @oaram pCounter (out) the counter for the number of dependants
 * @return the size of the entry (including the size of the pointer to the structure)
 */
int l_getSize__cudaFatBinaryEntry(__cudaFatCudaBinary * pEntry, cache_num_entries_t * pEntriesCache){

	// do not understand this implementation, and I am following the
	// original implementation
	int size = sizeof(size_pkt_field_t);   // for the counter
	__cudaFatCudaBinary * p = pEntry;

	// @todo clear the pCacheEntries?
	// *pCacheEntries = {0} or whatever
	while( p != NULL ){
		cache_num_entries_t nent = { 0, 0, 0, 0, 0, 0, 0 };
		size += l_getFatRecPktSize(p, &nent);
		pEntriesCache->ndeps++;
		p = p->dependends;
	}

	return size;
}

/**
 * gets the size of the __cudaFatCudaBinary -> __cudaFatCubinEntry; includes the
 * size of the pointer to the structure
 *
 * @todo new stuff added in comparison to cuda 1.1
 * This is almost identical to @see l_getSize__cudaFatDebugEntry()
 *
 * @param pEntry (in) the entry we want to count the size of
 * @oaram pCounter (out) the cache for storing number of elves (first zeroed)
 * @return the size of the entry (including the size of the pointer to the structure)
 */
int l_getSize__cudaFatElfEntry(__cudaFatElfEntry * pEntry, int * pCounter){

	// apparently the __cudaFatElfEntry might be an array
	// that's why we want to iterate through all this elements
	int size = 0;
	__cudaFatElfEntry * p = pEntry;

	// clear the counter
	*pCounter = 0;

	// to store the number of entries
	size += sizeof(size_pkt_field_t);

	// it looks that this is an array, with a terminator
	// with fields NULL (that is from empirical experiments
	while (p && p->gpuProfileName && p->elf && p->size) {
		size += l_getStringPktSize(p->gpuProfileName);
		assert(p->size != 0 );
		size += p->size;        // for the elf file
		// apparently this indicates the size of the elf file
		size += sizeof(p->size);

		(*pCounter)++;

		p = p->next;
	}

	return size;
}

/**
 * @brief gets the size of the packet that will contain a fatcubin
 *
 * This is based on cuda 3.2 api /opt/cuda/include/__cudaFatFormat.h (the added
 * some fields in comparison to cuda 1.1, so you need it check it out when
 * you upgrade to the other version of cuda
 *
 * originally this function was implemented as
 * int get_fat_rec_size(__cudaFatCudaBinary *fatCubin, cache_num_entries_t *num)
 * and serialization/deserialization was based on offsets, so I guess
 * in particular fields they stored the offsets in the packet that is
 * sent over somewhere. My approach is different:
 * |magic|version|gpuInfoVersion|flags|characteristics|
 * size_of_key|key ....|size_of_indent|indent ...|
 * size_of_usageMode|usageMode ....|
 * debugInfo|
 * num_of_ptx|ptx_entry1|ptx_entry2|...|ptx_entry_n|
 * num_of_cubin|cubin_entry1|cubin_entry2|cubin_entry_n|
 * ....
 * num_of_deps|dep_entry1|dep_entry2|... |dep_entry_n|
 *
 * @todo update accordingly if you change cuda version you work with
 *
 * @param pFatCubin (in) this structure we want to compute the size
 * @param pEntriesCache (out) contains the sizes of entry structures in __cudaFatCudaBinary
 * @return the size of the fatcubin
 *
 */
int l_getFatRecPktSize(const __cudaFatCudaBinary *pFatCubin, cache_num_entries_t * pEntriesCache){

	int size = 0;

	// so here is the story with the sizeof operator: sizeof(__cudaFatCudaBinary)
	// might not equal the sum of its members, counted individually
	// it might be greater because it may include internal and trailing
	// padding used to align the members of the structure or union on memory boundaries.
	// that's why I will not take sizeof(__cudaFatCudaBinary), besides I do not
	// want to send pointers, but the data there, so I need to prepare the structure
	// for containing the data not pointers to the data (since they are
	// meaningless on the remote machine)
	// 32bit vs. 64bit should not be a concern since I am sending a message
	// to the remote machine, and I need appropriate amount of space available
	// counting size algorithm to some extent determines the serialization
	// algorithm

	// first pack numbers (longs and ints), we will pack it as
	size += sizeof(pFatCubin->magic);
	size += sizeof(pFatCubin->version);
	size += sizeof(pFatCubin->gpuInfoVersion);
	size += sizeof(pFatCubin->flags);
	size += sizeof(pFatCubin->characteristic);

	// now deal with strings;strlen() doesn't include NULL terminator
	// we will store those characters as the size as returned by strlen
	// then the string terminated plus NULL included (it will make simpler
	// deserializing by strcpy

	size += l_getStringPktSize(pFatCubin->key);
	size += l_getStringPktSize(pFatCubin->ident);
	size += l_getStringPktSize(pFatCubin->usageMode);

	p_debug("Here!!!!!!!\n");
	// this probably means the information where the debug information
	// can be found (eg. the name of the file with debug, or something)
	// @todo don't know what to do with this member, originally a size of the
	// pointer has been counted; doing the same; but this doesn't make
	// much sense to me anyway
	size += sizeof(pFatCubin->debugInfo);

	// ptx is an array
	size += l_getSize__cudaFatPtxEntry(pFatCubin->ptx, &pEntriesCache->nptxs);

	// cubin is an array, actually we will treat it the same as ptx entry
	size += l_getSize__cudaFatCubinEntry(pFatCubin->cubin, &pEntriesCache->ncubs);

	// it looks as it can be a list, but in the past version it was an array
	// a new fields were added in the comparison to the previous versions
	size += l_getSize__cudaFatDebugEntry(pFatCubin->debug, &pEntriesCache->ndebs);

	// it looks as it is a list, but it was added (it was absent in the past v.)
	// it is very similar to the debug.
	size += l_getSize__cudaFatElfEntry(pFatCubin->elf, &pEntriesCache->nelves);

	// symbol descriptor exported/imported, needed for __cudaFat binary linking
	size += l_getSize__cudaFatSymbolEntry(pFatCubin->exported, &pEntriesCache->nexps);
	size += l_getSize__cudaFatSymbolEntry(pFatCubin->imported, &pEntriesCache->nimps);

	return size;
}

int getFatRecPktSize(const __cudaFatCudaBinary *pFatCubin, cache_num_entries_t * pEntriesCache){
	int size = 0;
	// clear cache - this is again cleaned in particular l_getSize__cudaFat...
	// functions
	pEntriesCache->ncubs = 0;
	pEntriesCache->ndebs = 0;
	pEntriesCache->ndeps = 0;
	pEntriesCache->nelves = 0;
	pEntriesCache->nexps = 0;
	pEntriesCache->nimps = 0;
	pEntriesCache->nptxs = 0;

	size = l_getFatRecPktSize(pFatCubin, pEntriesCache);
	size += l_getSize__cudaFatBinaryEntry(pFatCubin->dependends, pEntriesCache);

	return size;
}

/**
 * allocates the cuda packet
 *
 * @param pFunctionName (in) the name of the function that called this allocation
 * @param pCudaError (out) sets cudaErrorMemoryAllocation if problems with allocating
 *        the packet appeared
 * @return pointer to the newly allocated cuda packet, NULL if memory allocation occurred
 */
cuda_packet_t * callocCudaPacket(const char * pFunctionName, cudaError_t * pCudaError){
	cuda_packet_t * packet = (cuda_packet_t *) calloc(1, sizeof(cuda_packet_t));
	if (packet == NULL) {
		printd(DBG_DEBUG, "%s, Problems with memory allocation for a cuda packet\n", pFunctionName);
		*pCudaError = cudaErrorMemoryAllocation;
	}
	return packet;
}

// -------------------------------
// print functions
// ------------------------------
void l_printPtxE(__cudaFatPtxEntry * p){
	int i = 0;
	p_debug( "__cudaFatPtxEntry: %p\n", p);

	while(1){
		p_debug( "p[%d] (gpuProfileName, ptx): %s, %s\n",
						i, p[i].gpuProfileName, p[i].ptx);

		if( !(p+i) || !p[i].gpuProfileName || !p[i].ptx )
			break;

		i++;
	}
}

void l_printCubinE(__cudaFatCubinEntry * p){
	int i = 0;
	p_debug( "__cudaFatCubinEntry: %p\n", p);

	while(1){
		p_debug( "p[%d] (gpuProfileName, cubin): %s, %s\n",
				i, p[i].gpuProfileName, p[i].cubin);

		if( !(p+i) || !p[i].gpuProfileName || !p[i].cubin )
			break;

		i++;
	}
}

void l_printSymbolE(__cudaFatSymbol * p, char * name){
	int i = 0;
	p_debug( "__cudaFatSymbol: %s,  %p\n", name, p);

	while(p && p->name ){
		p_debug( "p[%d] (name): %s\n",
				i, p[i].name);
		i++;
	}
}

void l_printDebugE(__cudaFatDebugEntry * p){
	int i = 0;
	p_debug( "__cudaFatDebugEntry: %p\n", p);
	while( p ){
		p_debug( "p[%d] (gpuProfileName, debug, next, size): %s, %s, %p, %d\n",
				i, p->gpuProfileName, p->debug, p->next, p->size);
		p = p->next;
		i++;
	}
}

void l_printDepE(__cudaFatCudaBinary * p){
	int i = 0;

	p_debug( "__cudaFatCudaBinary: %p\n", p);

	while( p && p->ident){

		p_debug( "p[%i]\n", i);
		i++;
		p = p->dependends;
	}
}

void l_printElfE(__cudaFatElfEntry * p){

	int i = 0;
	p_debug( "__cudaFatElfEntry: %p\n", p);

	while( p ){
		p_debug( "p[%d] (gpuProfileName, elf, next, size): %s, %p, %p, %d\n",
				i, p->gpuProfileName,  p->elf, p->next, p->size);
		p = p->next;
		i++;
	}
}

void l_printFatBinary(__cudaFatCudaBinary * pFatBin){
	if( pFatBin == NULL ){
		p_info( "~~~~~~~~ FatBinary  = %p\n", pFatBin);
	} else {
		p_debug( "\tmagic: %ld, version: %ld , gpuInfoVersion: %ld\n",
				pFatBin->magic, pFatBin->version, pFatBin->gpuInfoVersion);
		p_debug( "\tkey: %s, ident: %s, usageMode: %s\n",
				pFatBin->key, pFatBin->ident, pFatBin->usageMode);
		l_printPtxE(pFatBin->ptx);
		l_printCubinE(pFatBin->cubin);
		l_printDebugE(pFatBin->debug);

		p_debug( "\tdebugInfo (pointer, char*): %p, %s\n", pFatBin->debugInfo, (char*) pFatBin->debugInfo);
		p_debug( "\tflags: %u\n", pFatBin->flags);
		l_printSymbolE(pFatBin->exported, "exported");
		l_printSymbolE(pFatBin->imported, "imported");
		l_printDepE(pFatBin->dependends);
		p_debug( "\tcharacteristics: %u\n", pFatBin->characteristic);
		l_printElfE(pFatBin->elf);
	}
}

void l_printRegFunArgs(void** fatCubinHandle, const char* hostFun,
		char* deviceFun, const char* deviceName, int thread_limit, uint3* tid,
		uint3* bid, dim3* bDim, dim3* gDim, int* wSize){
	printd(DBG_DEBUG, "\t REG FUN ARGS:\n");
	printd(DBG_DEBUG, "fatCubinHandle: %p\n", fatCubinHandle);
	printd(DBG_DEBUG, "hostFun: %p\n", hostFun);
	printd(DBG_DEBUG, "deviceFun: %s\n", deviceFun);
	printd(DBG_DEBUG, "deviceName: %s\n", deviceName);
	printd(DBG_DEBUG, "thread_limit: %d\n", thread_limit);
	printd(DBG_DEBUG, "tid: %p\n", tid);
	if( tid )
		printd(DBG_DEBUG, "tid: (%ud, %ud, %ud)\n", tid->x, tid->y, tid->z );
	printd(DBG_DEBUG, "bid: %p\n", bid);
	if( bid )
		printd(DBG_DEBUG, "bid: (%ud, %ud, %ud)\n", bid->x, bid->y, bid->z);
	printd(DBG_DEBUG, "bDim: %p\n", bDim);
	if( bDim )
		printd(DBG_DEBUG, "bDim: (%ud, %ud, %ud)\n", bDim->x, bDim->y, bDim->z);
	printd(DBG_DEBUG, "gDim: %p\n", gDim);
	if( gDim )
		printd(DBG_DEBUG, "gDim: (%ud, %ud, %ud)\n", gDim->x, gDim->y, gDim->z);

	printd(DBG_DEBUG, "wSize: %p\n", wSize);
}

void l_printRegVar(void **fatCubinHandle, char *hostVar,
		char *deviceAddress, const char *deviceName, int ext, int vsize,
		int constant, int global){
	p_debug( "\t REG VAR:\n");
	p_debug( "fatCubinHandle: %p\n", fatCubinHandle);
	//p_debug( "hostVar: %p, (%s)\n", hostVar, hostVar);
	p_debug( "hostVar: %p\n", hostVar);
	p_debug( "deviceAddress: %s\n", deviceAddress);
	p_debug( "deviceName: %s\n", deviceName);
	p_debug( "ext: %d\n", ext);
	p_debug( "vsize: %d\n", vsize);
	p_debug( "constant: %d\n", constant);
	p_debug( "global: %d\n", global);
}

/**
 * Prints the device properties
 */
int l_printCudaDeviceProp(const struct cudaDeviceProp * const pProp){
	printd(DBG_INFO, "\nDevice \"%s\"\n",  pProp->name);
	printd(DBG_INFO, "  CUDA Capability Major/Minor version number:    %d.%d\n", pProp->major, pProp->minor);
	printd(DBG_INFO, "  Total amount of global memory:                 %llu bytes\n", (unsigned long long) pProp->totalGlobalMem);
	printd(DBG_INFO, "  Multiprocessors: %d (MP) \n", pProp->multiProcessorCount);
    printd(DBG_INFO, "  Total amount of constant memory:               %lu bytes\n", pProp->totalConstMem);
    printd(DBG_INFO, "  Total amount of shared memory per block:       %lu bytes\n", pProp->sharedMemPerBlock);
    printd(DBG_INFO, "  Total number of registers available per block: %d\n", pProp->regsPerBlock);
    printd(DBG_INFO, "  Warp size:                                     %d\n", pProp->warpSize);
    printd(DBG_INFO, "  Maximum number of threads per block:           %d\n", pProp->maxThreadsPerBlock);
    printd(DBG_INFO, "  Maximum sizes of each dimension of a block:    %d x %d x %d\n",
           pProp->maxThreadsDim[0],
           pProp->maxThreadsDim[1],
           pProp->maxThreadsDim[2]);
    printd(DBG_INFO, "  Maximum sizes of each dimension of a grid:     %d x %d x %d\n",
           pProp->maxGridSize[0],
           pProp->maxGridSize[1],
           pProp->maxGridSize[2]);
    return OK;
}

/**
 * prints the fatcubin_info array
 */

int printFatCIArray(GArray * fcia){
	guint i;

	if( NULL == fcia)
		return OK;

	printd(DBG_INFO, "\n -------- FatCubin_info array: length = %u -----------\n", fcia->len);

	for (i = 0; i < fcia->len; i++) {
		fatcubin_info_t * p =
				&g_array_index(fcia, fatcubin_info_t, i);

		printd(DBG_INFO, "\t FAT Cubin Handle: %p, Fat Cubin: %p", p->fatCubinHandle, p->fatCubin);
	}

	return OK;
}

/**
 * prints the hash table of handlers and vars
 */
void  l_printGPtrArr(gpointer key, gpointer value, gpointer user_data){

	GPtrArray* varArr = (GPtrArray*) value;
	guint i;

	p_debug("Key (FatCubinHandler)=%p: Value [\n", key);

//	g_ptr_array_foreach(varArr, (GFunc)printf, NULL);
	for(i = 0; i < varArr->len; i++){
		vars_val_t * v = g_ptr_array_index(varArr, i);
		if( v != NULL )
			p_debug("[%d] = hostVar: %p, deviceName: %s\n",
					i, v->hostVar, v->deviceName);
	}
	p_debug("]\n");
}

int printRegVarTab(GHashTable * tab){


	if( tab != NULL )
		g_hash_table_foreach(tab,l_printGPtrArr, NULL );

	return OK;
}

/**
 * writes the string with the information about its
 * size to the pDst address
 *
 * |size_pkt_field_t|char*|
 * |string_length|pSrc|
 *
 * @param pDst (out) where the information
 * @param pSrc (in) what string we will write
 * @return number of char (bytes) written so, you can
 *         update the pDst pointer
 *         ERROR if pDst is NULL
 */
inline int l_packStr(char * pDst, const char *pSrc){
	int offset;
	int length;

	if( pDst == NULL )
		return ERROR;

	// first determine the size of the string
	if( pSrc == NULL || strlen(pSrc) == 0){
		length = 0;		// we will send nothing
	} else {
		length = strlen(pSrc);
	}

	// write the size
	memcpy(pDst,&length, sizeof(size_pkt_field_t) );
	pDst += sizeof(size_pkt_field_t);
	offset = sizeof(size_pkt_field_t);

	// now copy the string
	if( length > 0){
		memcpy(pDst, pSrc, length);
		offset += length;
	}

	return offset;
}


/**
 * unpacks what was packed with l_packStr;
 * allocates the memory
 *
 * @param pSrc (in) from where the string will be read
 * @param pOffset (out) indicates how many bytes we unpacked
 *        starting from pSrc
 *
 * @return NULL if problem with memory allocation or
 *         pSrc is NULL
 *         the pointer to the allocated string
 */
inline char * l_unpackStr(const char *pSrc, int * pOffset){
	size_pkt_field_t length;
	char * pDst;

	if( pSrc == NULL )
		return NULL;

	// read the length
	size_pkt_field_t * p = (size_pkt_field_t *) pSrc;
	length = p[0];
	pSrc += sizeof(size_pkt_field_t);
	*pOffset = sizeof(size_pkt_field_t);

	if ( 0 == length ){
		return NULL;
	}

	// since we have the >0 length string to copy, so copy it
	// now allocate enough memory for the string and the NULL
	// terminator
	pDst = malloc(length + 1);
	if( mallocCheck(pDst, __FUNCTION__, NULL) == ERROR )
		return NULL;

	if( length > 0){
		memcpy(pDst, pSrc, length);
		*pOffset += length;
		// add NULL
		pDst[length] = '\0';
	}


	return pDst;
}

/**
 * unpacks the given size of characters
 * @param pSrc (in) from where we will copy the characters
 * @param size (in) the number of characters (bytes) we need to copy
 * @return the pointer to the allocated memory to hold what
 *         was copied from pSrc
 *         NULL if (1) pSrc is NULL or (2) problems with memory
 *              or (3) size == 0;
 */
inline char * l_unpackChars(char * pSrc, int size){
	char * pDst;

	if ( NULL == pSrc || 0 == size )
		return NULL;

	pDst = malloc(size);
	if( mallocCheck(pDst, __FUNCTION__, NULL ) == ERROR )
		return NULL;

	assert( pDst != NULL );
	memcpy(pDst, pSrc, size);

	return pDst;
}

/**
 * writes the entry to the pDst address and returns the
 * number of bytes written.
 *
 * |size_pkt_field_t|char*|
 * |string_length|pSrc|
 *
 * @param pDst (out) where the information
 * @param pEntry (in) the entry we want to serialize
 * @param n how many entries
 * @return number of char (bytes) written so, you can
 *         update the pDst pointer
 *         ERROR if pDst is NULL
 *
 */
int l_packPtx(char * pDst, const __cudaFatPtxEntry * pEntry, int n){
	int offset;
	int tmp;
	int i;

	if( NULL == pDst )
		return ERROR;

	// write the number of ptx entries
	memcpy(pDst,&n, sizeof(size_pkt_field_t) );
	pDst += sizeof(size_pkt_field_t);
	offset = sizeof(size_pkt_field_t);

	if( 0 == n || NULL == pEntry ){
		return offset;
	}

	// now write the entries
	for( i = 0; i < n; i++){
		tmp = l_packStr(pDst, pEntry[i].gpuProfileName);
		pDst += tmp;
		offset += tmp;
		tmp = l_packStr(pDst, pEntry[i].ptx);
		pDst +=tmp;
		offset += tmp;
	}

	return offset;
}

/**
 * unpacks the ptx entry
 * @param pSrc from what we unpack the entry
 * @param pOffset how many bytes we have read, from
 *        the begining of pSrc
 * @return the ptx entry or NULL if pDst is NULL
 */
__cudaFatPtxEntry * l_unpackPtx(char * pSrc, int * pOffset){
	size_pkt_field_t n; 		// the number of entries
	__cudaFatPtxEntry * pEntry;
	unsigned int i;
	int offset;
	// to remember the start position to allow to say
	// how many bytes we have read
	char * pSrcOrig = pSrc;

	if( NULL == pSrc )
		return NULL;

	// find out how many ptx entries do we have
	memcpy(&n, pSrc, sizeof(size_pkt_field_t) );
	pSrc += sizeof(size_pkt_field_t);

	// make place for the terminating NULL entry
	pEntry = (__cudaFatPtxEntry *) malloc(n * sizeof(__cudaFatPtxEntry ) + sizeof(__cudaFatPtxEntry));

	for(i = 0; i < n; i++){
		pEntry[i].gpuProfileName =  l_unpackStr(pSrc, &offset);
		pSrc += offset;

		pEntry[i].ptx =  l_unpackStr(pSrc, &offset);
		pSrc += offset;
	}

	// add null terminators
	assert(i == n);

	pEntry[i].gpuProfileName = NULL;
	pEntry[i].ptx = NULL;

	// count the offset
	*pOffset = pSrc - pSrcOrig;

	return pEntry;
}

/**
 * writes the entry to the pDst address and returns the
 * number of bytes written.
 *
 * @todo This function is identical to ptx
 * so maybe it should be without this redundancy
 *
 * |size_pkt_field_t|char*|
 * |string_length|pSrc|
 *
 * @param pDst (out) where the information
 * @param pEntry (in) the entry we want to serialize
 * @param n how many entries
 * @return number of char (bytes) written so, you can
 *         update the pDst pointer
 *         ERROR if pDst is NULL
 *
 */
int l_packCubin(char * pDst, const __cudaFatCubinEntry * pEntry, int n){
	int offset;
	int tmp;
	int i;

	if( NULL == pDst )
		return ERROR;

	// write the number of ptx entries
	memcpy(pDst,&n, sizeof(size_pkt_field_t) );
	pDst += sizeof(size_pkt_field_t);
	offset = sizeof(size_pkt_field_t);

	if( 0 == n || NULL == pEntry ){
		return offset;
	}

	// now write the entries
	for( i = 0; i < n; i++){
		tmp = l_packStr(pDst, pEntry[i].gpuProfileName);
		pDst += tmp;
		offset += tmp;
		tmp = l_packStr(pDst, pEntry[i].cubin);
		pDst +=tmp;
		offset += tmp;
	}

	return offset;
}


/**
 * unpacks the cubin entry
 *
 * See a note to @see l_packCubin()
 *
 * @param pSrc from what we unpack the entry
 * @param pOffset how many bytes we have read, from
 *        the begining of pSrc
 * @return the cubin entry or NULL if pDst is NULL
 */
__cudaFatCubinEntry * l_unpackCubin(char * pSrc, int * pOffset){
	size_pkt_field_t n; 		// the number of entries
	__cudaFatCubinEntry * pEntry;
	unsigned int i;
	int offset;
	// to remember the start position to allow to say
	// how many bytes we have read
	char * pSrcOrig = pSrc;

	if( NULL == pSrc )
		return NULL;

	// find out how many ptx entries do we have
	memcpy(&n, pSrc, sizeof(size_pkt_field_t) );
	pSrc += sizeof(size_pkt_field_t);

	// make place for the terminating NULL entry
	pEntry = (__cudaFatCubinEntry *) malloc( (n + 1) * sizeof(__cudaFatCubinEntry ));

	for(i = 0; i < n; i++){
		pEntry[i].gpuProfileName =  l_unpackStr(pSrc, &offset);
		pSrc += offset;

		pEntry[i].cubin =  l_unpackStr(pSrc, &offset);
		pSrc += offset;
	}

	// add null terminators
	assert(i == n);

	pEntry[i].gpuProfileName = NULL;
	pEntry[i].cubin = NULL;

	// count the offset
	*pOffset = pSrc - pSrcOrig;

	return pEntry;
}

/**
 * writes the entry to the pDst address and returns the
 * number of bytes written.
 *
 * |size_pkt_field_t|size_pkt_field_t|char*|size_pkt_field_t|char*|unsigned int|
 * |how_many_records|string_length|gpuProfileName|string_len|debug|size|
 *                  |string_length|gpuProfileName|string_len|debug|size| ....
 *
 * @param pDst (out) where the information
 * @param pEntry (in) the entry we want to serialize
 * @param n how many entries
 * @return number of char (bytes) written so, you can
 *         update the pDst pointer
 *         ERROR if pDst is NULL
 *
 */
int l_packDebug(char * pDst, __cudaFatDebugEntry * pEntry, int n){
	int tmp;
	int i = 0;
	char * pDstOrig = pDst;
	__cudaFatDebugEntry *p = pEntry;

	if( NULL == pDst )
		return ERROR;

	// write the number of debug entries
	memcpy(pDst,&n, sizeof(size_pkt_field_t) );
	pDst += sizeof(size_pkt_field_t);

	if( 0 == n || NULL == pEntry){
		return pDst - pDstOrig;
	}

	// now write the entries
	// those p->gpuProfile and p->debug are NULL are
	// empirically determined
	while(p && p->gpuProfileName && p->debug ){
		tmp = l_packStr(pDst, p->gpuProfileName);
		pDst += tmp;
		tmp = l_packStr(pDst, p->debug);
		pDst += tmp;
		// copy the size
		memcpy(pDst, &p->size, sizeof(unsigned int));
		pDst += sizeof(unsigned int);

		p = p->next;
		i++;
	}

	assert( i == n );

	return pDst - pDstOrig ;
}

/**
 * unpacks the entry
 *
 * @param pSrc from what we unpack the entry
 * @param pOffset how many bytes we have read, from
 *        the begining of pSrc
 * @return the debug entry or NULL if pDst is NULL or the size is NULL
 *         @todo should be done something with that
 */
__cudaFatDebugEntry * l_unpackDebug(char * pSrc, int * pOffset){
	size_pkt_field_t n; 		// the number of entries
	__cudaFatDebugEntry * pEntry;
	unsigned int i;
	int offset;
	// to remember the start position to allow to say
	// how many bytes we have read
	char * pSrcOrig = pSrc;

	if( NULL == pSrc )
		return NULL;

	// find out how many debug entries do we have
	size_pkt_field_t * p = (size_pkt_field_t *) pSrc;
	n = p[0];
	//memcpy(&n, pSrc, sizeof(size_pkt_field_t) );
	pSrc += sizeof(size_pkt_field_t);

	if( 0 == n ){
		*pOffset = sizeof(size_pkt_field_t);
		return NULL;
	}

	pEntry = (__cudaFatDebugEntry *) malloc((n+1) * sizeof(__cudaFatDebugEntry ));

	for(i = 0; i < n; i++){
		pEntry[i].gpuProfileName =  l_unpackStr(pSrc, &offset);
		pSrc += offset;

		pEntry[i].debug =  l_unpackStr(pSrc, &offset);
		pSrc += offset;

		memcpy(&pEntry[i].size, pSrc, sizeof(unsigned int));
		pSrc += sizeof(unsigned int);

		// update the pointer to the next
		pEntry[i].next = &pEntry[i+1];
	}

	// add null terminators
	assert( n == i );

	pEntry[i].next = NULL;
	pEntry[i].gpuProfileName = NULL;
	pEntry[i].debug = NULL;
	pEntry[i].size = 0;

	// count the offset
	*pOffset = pSrc - pSrcOrig;

	return pEntry;
}

/**
 * writes the entry to the pDst address and returns the
 * number of bytes written.
 *
 * |size_pkt_field_t|size_pkt_field_t|char*|size_pkt_field_t|char*|unsigned int|
 * |how_many_records|string_length|gpuProfileName|string_len|debug|size|
 *                  |string_length|gpuProfileName|string_len|debug|size| ....
 *
 * @param pDst (out) where the information
 * @param pEntry (in) the entry we want to serialize
 * @param n how many entries
 * @return number of char (bytes) written so, you can
 *         update the pDst pointer
 *         ERROR if pDst is NULL
 *
 *  You should always check if the return thing is an error or not
 *
 */
int l_packElf(char * pDst, __cudaFatElfEntry * pEntry, int n){

	int tmp;
	int i = 0;
	char * pDstOrig = pDst;
	__cudaFatElfEntry *p = pEntry;

	if( NULL == pDst )
		return ERROR;

	// write the number of debug entries
	memcpy(pDst,&n, sizeof(size_pkt_field_t) );
	pDst += sizeof(size_pkt_field_t);

	if( 0 == n || NULL == pEntry){
		return pDst - pDstOrig;
	}

	// now write the entries
	// those p->gpuProfile and p->elf are NULL are
	// empirically determined
	while(p && p->gpuProfileName && p->elf ){
		tmp = l_packStr(pDst, p->gpuProfileName);
		pDst += tmp;
		// copy the size
		memcpy(pDst, &p->size, sizeof(unsigned int));
		pDst += sizeof(unsigned int);
		// it looks that the size is the size of the elf code
		// pointed by the p->elf (I guess the same is with
		// the debugEntry), not the string
		if( p->size > 0 ){
			assert(p->elf != NULL);
			memcpy(pDst, p->elf, p->size);
			pDst += p->size;
		}

		p = p->next;
		i++;
	}

	assert( i == n );

	return pDst - pDstOrig ;
}

/**
 * unpacks the entry
 *
 * @param pSrc from what we unpack the entry
 * @param pOffset how many bytes we have read, from
 *        the begining of pSrc
 * @return the debug entry or NULL if pDst is NULL or the size is NULL
 *         @todo should be done something with that
 */
__cudaFatElfEntry * l_unpackElf(char * pSrc, int * pOffset){
	size_pkt_field_t n; 		// the number of entries
	__cudaFatElfEntry * pEntry;
	unsigned int i;
	int offset;
	// to remember the start position to allow to say
	// how many bytes we have read
	char * pSrcOrig = pSrc;

	if( NULL == pSrc )
		return NULL;

	// find out how many debug entries do we have
	size_pkt_field_t * p = (size_pkt_field_t *) pSrc;
	n = p[0];
	//memcpy(&n, pSrc, sizeof(size_pkt_field_t) );
	pSrc += sizeof(size_pkt_field_t);

	if( 0 == n ){
		*pOffset = sizeof(size_pkt_field_t);
		return NULL;
	}

	pEntry = (__cudaFatElfEntry *) malloc((n+1) * sizeof(__cudaFatElfEntry ));

	for(i = 0; i < n; i++){
		pEntry[i].gpuProfileName =  l_unpackStr(pSrc, &offset);
		pSrc += offset;

		memcpy(&pEntry[i].size, pSrc, sizeof(unsigned int));
		pSrc += sizeof(unsigned int);

		// unpack the elf binary
		if( 0 == pEntry[i].size)
			pEntry[i].elf = NULL;
		else{
			assert( pEntry[i].size > 0);
			pEntry[i].elf = l_unpackChars(pSrc, pEntry[i].size);
			if( pEntry[i].elf == NULL )
				exit(ERROR);
			pSrc += pEntry[i].size;
		}

		// update the pointer to the next
		pEntry[i].next = &pEntry[i+1];
	}

	// add null terminators
	assert( n == i );

	pEntry[i].next = NULL;
	pEntry[i].gpuProfileName = NULL;
	pEntry[i].elf = NULL;
	pEntry[i].size = 0;

	// count the offset
	*pOffset = pSrc - pSrcOrig;

	return pEntry;
}

/**
 * writes the entry to the pDst address and returns the
 * number of bytes written.
 *
 * |size_pkt_field_t|char*|
 * |string_length|pSrc|
 *
 * @param pDst (out) where the information
 * @param pEntry (in) the entry we want to serialize
 * @param n how many entries
 * @return number of char (bytes) written so, you can
 *         update the pDst pointer
 *         ERROR if pDst is NULL
 *
 */
int l_packSymbol(char * pDst, const __cudaFatSymbol * pEntry, int n){
	int offset = 0;
	int tmp;
	int i;

	if( NULL == pDst )
		return ERROR;

	// write the number of entries
	size_pkt_field_t * p = (size_pkt_field_t * ) pDst;
	p[0] = n;
	pDst += sizeof(size_pkt_field_t);
	offset = sizeof(size_pkt_field_t);

	if( 0 == n || NULL == pEntry ){
		return offset;
	}

	// now write the entries
	for( i = 0; i < n; i++){
		tmp = l_packStr(pDst, pEntry[i].name);
		pDst += tmp;
		offset += tmp;
	}

	return offset;
}

/**
 * unpacks the symbol entry
 *
 *
 * @param pSrc from what we unpack the entry
 * @param pOffset how many bytes we have read, from
 *        the begining of pSrc
 * @return the cubin entry or NULL if pDst is NULL
 */
__cudaFatSymbol * l_unpackSymbol(char * pSrc, int * pOffset){
	size_pkt_field_t n; 		// the number of entries
	__cudaFatSymbol * pEntry;
	unsigned int i;
	int offset;
	// to remember the start position to allow to say
	// how many bytes we have read
	char * pSrcOrig = pSrc;

	if( NULL == pSrc )
		return NULL;

	// find out how many entries do we have
	size_pkt_field_t * p = (size_pkt_field_t*) pSrc;
	n = p[0];
	pSrc += sizeof(size_pkt_field_t);

	if (0 == n) {
		pEntry = NULL;
	} else {
		// create the place and unpack the stuff
		// make place for the terminating NULL entry
		pEntry = (__cudaFatSymbol *) malloc((n + 1) * sizeof(__cudaFatSymbol ));

		for (i = 0; i < n; i++) {
			pEntry[i].name = l_unpackStr(pSrc, &offset);
			pSrc += offset;
		}

		// add null terminators
		assert(i == n);

		pEntry[i].name = NULL;
	}
	// count the offset
	*pOffset = pSrc - pSrcOrig;

	return pEntry;
}

int l_packFatBinary(char * pFatPack, __cudaFatCudaBinary * const pSrcFatC,
		cache_num_entries_t * const pEntriesCache);

/**
 * writes the entry to the pDst address and returns the
 * number of bytes written.
 *
 * |size_pkt_field_t|char*|
 * |string_length|pSrc|
 *
 * @param pDst (out) where the information
 * @param pEntry (in) the entry we want to serialize
 * @param n how many entries
 * @return number of char (bytes) written so, you can
 *         update the pDst pointer
 *         ERROR if pDst is NULL
 * @todo Right now we do not support the dependends - dependends should
 * be NULL.
 */
int l_packDep(char * pDst, __cudaFatCudaBinary * pEntry, int n){
	// to remember the offset
	char * pDstOrig = pDst;
	// for iterations
	__cudaFatCudaBinary * p;
	int offset;
	int i = 0;

	if( NULL == pDst )
		return ERROR;

	// write the number of deb entries
	memcpy(pDst, &n, sizeof(size_pkt_field_t) );
	pDst += sizeof(size_pkt_field_t);

	if( 0 == n || NULL == pEntry ){
		return pDst - pDstOrig;
	} else {
		printd(DBG_ERROR, "%s: Not implemented\n", __FUNCTION__);
		assert(2==1);   // always complain
		// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		// @todo should be addressed appropriately
		// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		return ERROR;
	}

	// now write the entries
	p = pEntry;
	while( p ){
		// @todo actually you have to have an array of caches for
		// each dependend otherwise you need to do it differently here
		// so let's assume that there is no dependendants right now
		cache_num_entries_t cache = { 0, 0, 0, 0, 0, 0, 0 };
		offset = l_packFatBinary(pDst,  p, &cache);
		if( ERROR == offset )
			return ERROR;
		pDst += offset;
		p = p->dependends;
		i++;
	}

	assert( i == n );

	return pDst - pDstOrig;
}

// forward declaration
int unpackFatBinary(__cudaFatCudaBinary *pFatC, char * pFatPack);

/**
 * Unpacks dependends
 * @param pSrc
 * @param pOffset
 *
 * @return the offset
 */
__cudaFatCudaBinary * l_unpackDep(char * pSrc, int * pOffset){
	size_pkt_field_t n; 		// the number of entries
	__cudaFatCudaBinary * pEntry;
	unsigned int i;
	int offset;
	// to remember the start position to allow to say
	// how many bytes we have read
	char * pSrcOrig = pSrc;

	if( NULL == pSrc )
		return NULL;

	// find out how many entries do we have
	memcpy(&n, pSrc, sizeof(size_pkt_field_t) );
	pSrc += sizeof(size_pkt_field_t);

	if( 0 == n )
		return NULL;

	// make place for the terminating NULL entry
	pEntry = (__cudaFatCudaBinary *) malloc( n  * sizeof(__cudaFatCudaBinary ));

	for(i = 0; i < n; i++){
		offset = unpackFatBinary(pEntry[i].dependends, pSrc);
		if(ERROR == offset){
			*pOffset = ERROR;
			return NULL;
		}
		pSrc += offset;
		pEntry[i].dependends = &pEntry[i+1];
	}

	// add null terminators
	assert(n >= 1);

	pEntry[n-1].dependends = NULL;

	// count the offset
	*pOffset = pSrc - pSrcOrig;

	return pEntry;
}


/**
 * pack the fat cubin into a packet that can be transmitted
 * over the network
 *
 * @param pFatPack where to pack
 * @param pSrcFatC from what we will be packing
 * @param pEntriesCache the remembered numbers of elements
 * @return OK if everything went smoothly
 *         ERROR if there was an error
 */
int packFatBinary(char * pFatPack, __cudaFatCudaBinary * const pSrcFatC,
		cache_num_entries_t * const pEntriesCache){
	// to enabling counting the offset
	char * pFatPackOrig = pFatPack;
	int offset = 0;

	// pack everything apart from dependends
	offset = l_packFatBinary(pFatPack, pSrcFatC, pEntriesCache);
	if ( ERROR == offset ) return ERROR; else pFatPack += offset;

	// pack dependends
	offset = l_packDep(pFatPack, pSrcFatC->dependends, pEntriesCache->ndeps);
	if ( ERROR == offset ) return ERROR; else pFatPack += offset;

	return pFatPack - pFatPackOrig;
}

int l_packFatBinary(char * pFatPack, __cudaFatCudaBinary * const pSrcFatC,
		cache_num_entries_t * const pEntriesCache){

	// to enabling counting the offset
	char * pFatPackOrig = pFatPack;
	int offset = 0;

	memcpy(pFatPack, (unsigned long*)&pSrcFatC->magic, sizeof(pSrcFatC->magic));
	pFatPack += sizeof(pSrcFatC->magic);
	memcpy(pFatPack, (unsigned long*)&pSrcFatC->version, sizeof(pSrcFatC->version));
	pFatPack += sizeof(pSrcFatC->version);
	memcpy(pFatPack, (unsigned long*)&pSrcFatC->gpuInfoVersion, sizeof(pSrcFatC->gpuInfoVersion));
	pFatPack += sizeof(pSrcFatC->gpuInfoVersion);
	memcpy(pFatPack, (unsigned int*)&pSrcFatC->flags, sizeof(pSrcFatC->flags));
	pFatPack += sizeof(pSrcFatC->flags);
	memcpy(pFatPack, (unsigned int*)&pSrcFatC->characteristic, sizeof(pSrcFatC->characteristic));
	pFatPack += sizeof(pSrcFatC->characteristic);
	// now strings
	offset = l_packStr(pFatPack, pSrcFatC->key);
	if ( ERROR == offset ) return ERROR; else pFatPack += offset;

	offset = l_packStr(pFatPack, pSrcFatC->ident);
	if ( ERROR == offset ) return ERROR; else pFatPack += offset;

	offset = l_packStr(pFatPack, pSrcFatC->usageMode);
	if ( ERROR == offset ) return ERROR; else pFatPack += offset;

	// copy a pointer (as originally pFatPack->debugInfo = pSrcFatC->debugInfo)
	// don't know to what points debugInfo
	memcpy(pFatPack, &pSrcFatC->debugInfo, sizeof(pSrcFatC->debugInfo));
	pFatPack += sizeof(pSrcFatC->debugInfo);

	// pack ptx
	offset = l_packPtx(pFatPack, pSrcFatC->ptx, pEntriesCache->nptxs);
	if ( ERROR == offset ) return ERROR; else pFatPack += offset;

	// pack cubin
	offset = l_packCubin(pFatPack, pSrcFatC->cubin, pEntriesCache->ncubs);
	if ( ERROR == offset ) return ERROR; else pFatPack += offset;

//	// pack debug
	offset = l_packDebug(pFatPack, pSrcFatC->debug, pEntriesCache->ndebs);
	if ( ERROR == offset ) return ERROR; else pFatPack += offset;

	// pack elf
	offset = l_packElf(pFatPack, pSrcFatC->elf, pEntriesCache->nelves);
	if ( ERROR == offset ) return ERROR; else pFatPack += offset;

	// exported / imported
	offset = l_packSymbol(pFatPack, pSrcFatC->exported, pEntriesCache->nexps);
	if ( ERROR == offset ) return ERROR; else pFatPack += offset;

	offset = l_packSymbol(pFatPack, pSrcFatC->imported, pEntriesCache->nimps);
	if ( ERROR == offset ) return ERROR; else pFatPack += offset;

	return pFatPack - pFatPackOrig;
}

/**
 * Unpacks the binary
 * @param pFatC the destination
 * @param pFatPack our source
 *
 * @return OK everything went smoothly
 *         ERROR there were some errors
 */
int unpackFatBinary(__cudaFatCudaBinary *pFatC, char * pFatPack){
	// to remember how many bytes we have read
	char * pFatPackOrig = pFatPack;
	// how many bytes we have read
	int offset;

	memcpy(&pFatC->magic, (unsigned long*)pFatPack, sizeof(pFatC->magic));
	pFatPack += sizeof(pFatC->magic);
	memcpy(&pFatC->version, (unsigned long*) pFatPack, sizeof(pFatC->version));
	pFatPack += sizeof(pFatC->version);
	memcpy(&pFatC->gpuInfoVersion, (unsigned long*) pFatPack, sizeof(pFatC->gpuInfoVersion));
	pFatPack += sizeof(pFatC->gpuInfoVersion);
	memcpy(&pFatC->flags, (unsigned int *) pFatPack, sizeof(pFatC->flags));
	pFatPack += sizeof(pFatC->flags);
	memcpy(&pFatC->characteristic, (unsigned int*) pFatPack, sizeof(pFatC->characteristic));
	pFatPack += sizeof(pFatC->characteristic);

	// now unpack strings
	pFatC->key = l_unpackStr(pFatPack, &offset);
	if( ERROR == offset ) return ERROR; else pFatPack += offset;
	pFatC->ident = l_unpackStr(pFatPack, &offset);
	if( ERROR == offset ) return ERROR; else pFatPack += offset;
	pFatC->usageMode = l_unpackStr(pFatPack, &offset);
	if( ERROR == offset ) return ERROR; else pFatPack += offset;

	// unpack debugInfo
	memcpy(&pFatC->debugInfo, pFatPack, sizeof(pFatC->debugInfo) );
	pFatPack += sizeof(pFatC->debugInfo);

	// unpack ptx
	pFatC->ptx = l_unpackPtx(pFatPack, &offset);
	if( ERROR == offset ) return ERROR; else pFatPack += offset;

	// unpack cubin
	pFatC->cubin = l_unpackCubin(pFatPack, &offset);
	if( ERROR == offset ) return ERROR; else pFatPack += offset;

	// unpack debug
	pFatC->debug = l_unpackDebug(pFatPack, &offset);
	if( ERROR == offset ) return ERROR; else pFatPack += offset;

	// unpack elf
	pFatC->elf = l_unpackElf(pFatPack, &offset);
	if( ERROR == offset ) return ERROR; else pFatPack += offset;

	pFatC->exported = l_unpackSymbol(pFatPack, &offset);
	if( ERROR == offset ) return ERROR; else pFatPack += offset;

	pFatC->imported = l_unpackSymbol(pFatPack, &offset);
	if( ERROR == offset ) return ERROR; else pFatPack += offset;

	pFatC->dependends = l_unpackDep(pFatPack, &offset);
	if( ERROR == offset ) return ERROR; else pFatPack += offset;

	return pFatPack - pFatPackOrig;
}

/**
 * Gets the size of teh packetized pointer to Uint3
 */
inline int l_getUint3PtrPktSize(uint3 * p){
	if( p )
		return sizeof(void*) + sizeof(uint3);
	else
		return sizeof(void*);		// p is NULL
}

/**
 * Returns the size of the packetized pointer to Dim3
 */
inline int l_getDim3PtrPktSize(dim3 * p){
	if( p )
		return sizeof(void*) + sizeof(dim3);
	else
		return sizeof(void*);  // p is NULL
}

/**
 * returns the size of the packetized pointer to int
 */
inline int l_getIntPtrPktSize(int * p){
	if( p )
		return sizeof(void*) + sizeof(int);
	else
		return sizeof(void*);	// p is NULL

}

/**
 * counts the size of the reg func arguments
 * I follow the original implementation which is also initially verified
 * with the 3.2 execution
 *
 * @return total size in bytes
 */
int l_getSize_regFuncArgs(void** fatCubinHandle, const char* hostFun,
        char* deviceFun, const char* deviceName, int thread_limit, uint3* tid,
        uint3* bid, dim3* bDim, dim3* gDim, int* wSize){

	int size = 0;

	size = sizeof(fatCubinHandle); 					// fatCubinHandle
	size += l_getStringPktSize(hostFun);
	// for storing the local pointer to hostFun; this pointer is
	// translated and compared with a remote pointer when cudaLaunch is
	// invoked; the translation is taken care on the server side
	size += sizeof(char*);
	size += l_getStringPktSize(deviceFun);
	size += l_getStringPktSize(deviceName);
	size += sizeof(thread_limit);		 			// thread_limit
	size += l_getUint3PtrPktSize(tid);  			// pointer to tid + tid
	size += l_getUint3PtrPktSize(bid);				// pointer to bid + bid
	size += l_getDim3PtrPktSize(bDim);				// bDim
	size += l_getDim3PtrPktSize(gDim); 				// gDim
	size += l_getIntPtrPktSize(wSize);				// wSize

	return size;
}

/**
 * counts the size of memory to store all those arguments and transfer it over
 * the network
 *
 * @return total size of bytes required to create a packet from all those arguments
 */
int l_getSize_regVar(void **fatCubinHandle, char *hostVar, char *deviceAddress,
		const char *deviceName, int ext, int vsize,int constant, int global){
	int size = 0;

	size = sizeof(fatCubinHandle);
	// @todo so far I assume that hostVar is a pointer not a string as such
	//size += l_getStringPktSize(hostVar);
	// for storing the local pointer to hostVar; this pointer is
	// translated and compared with a remote pointer when cudaLaunch is
	// invoked; the translation is taken care on the server side - this
	// is the explanation from l_getSize_regFuncArgs - I hope it holds here
	// as well; on the server side during registering variables we will
	// provide a remoteHost
	size += sizeof(hostVar);
	size += l_getStringPktSize(deviceAddress);
	size += l_getStringPktSize(deviceName);
	size += sizeof(ext);
	size += sizeof(vsize);
	size += sizeof(constant);
	size += sizeof(global);

	return size;
}

/**
 * packetizes the pointer to uint3 and writes it pDst
 * @param pDst (in/out) when we right our packet
 * @param pSrc (in) from where we are copying the uint3 (our uint3 pointer)
 * @return offset we need to add to pDst later
 *         ERROR if pDst is NULL
 */
inline int l_packUint3Ptr(char * pDst, const uint3 *pSrc){
	// to allow to count the offset
	char * pDstOrig = pDst;

	if( !pDst )
		return ERROR;

	// copy the value of the pointer, use the trick with
	// different views; now we treat our pDst as an array
	// of uint3

	uint3 ** pUint3 = (uint3**) pDst;
	pDst += sizeof(void*);
	pUint3[0] = (uint3*) pSrc;

	// copy the values if any
	if( pSrc ){
		// now we treat our pDst as an array of unsigned int
		unsigned int * pU = (unsigned int*) pDst;
		pU[0] = pSrc->x;
		pU[1] = pSrc->y;
		pU[2] = pSrc->z;

		pDst += 3 * sizeof(pSrc->x);
	}

	return pDst - pDstOrig;
}

/**
 * unpacks the pointer to the Uint; tries to zero the *pOffset
 * @param pSrc (in) from where we recreate the pointer to the uint3
 * @param pOffset (out) changes the offset to enable us to update the pSrc
 *        if < 0 then indicates some errors with memory allocation
 *        or pSrc is NULL
 * @return a pointer to a new uint3
 *         NULL if problems with memory allocation or pSrc is NULL
 */
inline uint3 * l_unpackUint3Ptr(const char *pSrc, int * pOffset){

	uint3 * p;

	if( !pSrc ){
		*pOffset = ERROR;
		return NULL;
	}

	*pOffset = 0;		// cleans the counter

	// pSrc
	uint3 ** pUint3 = (uint3**) pSrc;
	pSrc += sizeof(void*);
	*pOffset = sizeof(void*);

	if( pUint3[0]){
		// not null
		p = (uint3 *) malloc(sizeof(uint3));
		if( mallocCheck(p, __FUNCTION__, NULL ) == ERROR ){
			*pOffset = ERROR;
			return NULL;
		}
		// now we want to view the pSrc as an array of 3 unsigned int
		unsigned int * pU = (unsigned int*) pSrc;
		p->x = pU[0];
		p->y = pU[1];
		p->z = pU[2];

		*pOffset += 3 * sizeof(p->x);
	} else {
		assert(*pOffset == sizeof(void*));
		return NULL;
	}

	return p;
}

/**
 * packetizes the pointer to dim3 and writes it pDst
 * identical to the uint3
 *
 * @param pDst (in) when we right our packet
 * @param pSrc (in) from where we are copying the uint3 (our uint3 pointer)
 * @return offset we need to add to pDst later
 *         ERROR if pDst is NULL
 */
inline int l_packDim3Ptr(char * pDst, const dim3 *pSrc){
	// to allow to count the offset
	char * pDstOrig = pDst;

	if( !pDst )
		return ERROR;

	// copy the value of the pointer, use the trick with
	// different views; now we treat our pDst as an array
	// of dim3

	dim3 ** pDim3 = (dim3**) pDst;
	pDst += sizeof(void*);
	pDim3[0] = (dim3*) pSrc;

	// copy the values if any
	if( pSrc ){
		// now we treat our pDst as an array of unsigned int
		unsigned int * pU = (unsigned int*) pDst;
		pU[0] = pSrc->x;
		pU[1] = pSrc->y;
		pU[2] = pSrc->z;

		pDst += 3 * sizeof(pSrc->x);
	}

	return pDst - pDstOrig;
}

/**
 * unpacks the pointer to the Uint; tries to zero the *pOffset
 * @param pSrc (in) from where we recreate the pointer to the uint3
 * @param pOffset (out) changes the offset to enable us to update the pSrc
 *        if < 0 then indicates some errors with memory allocation
 *        or pSrc is NULL
 * @return a pointer to a new uint3
 *         NULL if problems with memory allocation or pSrc is NULL
 */
inline dim3 * l_unpackDim3Ptr(const char *pSrc, int * pOffset){

	dim3 * p;

	if( !pSrc ){
		*pOffset = ERROR;
		return NULL;
	}

	*pOffset = 0;		// cleans the counter

	// pSrc
	dim3 ** pDim3 = (dim3**) pSrc;
	pSrc += sizeof(void*);
	*pOffset = sizeof(void*);

	if( pDim3[0]){
		// not null
		p = (dim3 *) malloc(sizeof(dim3));
		if( mallocCheck(p, __FUNCTION__, NULL ) == ERROR ){
			*pOffset = ERROR;
			return NULL;
		}
		// now we want to view the pSrc as an array of 3 unsigned int
		unsigned int * pU = (unsigned int*) pSrc;
		p->x = pU[0];
		p->y = pU[1];
		p->z = pU[2];

		*pOffset += 3 * sizeof(p->x);
	} else {
		assert(*pOffset == sizeof(void*));
		return NULL;
	}

	return p;
}

/**
 * packetize the pointer to the int
 *
 * @param pDst (in) when we right our packet
 * @param pSrc (in) from where we are copying the uint3 (our uint3 pointer)
 * @return offset we need to add to pDst later
 *         ERROR if pDst is NULL
 *
 */
inline int l_packIntPtr(char * pDst, int *pSrc){
	char * pDstOrig = pDst;

	if( !pDst )
		return ERROR;

	int ** p = (int**) pDst;
	p[0] = pSrc;
	pDst += sizeof(void*);

	if( pSrc ){
		int * d = (int*) pDst;
		d[0] = *pSrc;
		pDst += sizeof(int);
	}

	return pDst - pDstOrig;
}
/**
 * unpacks the pointer to the Uint; tries to zero the *pOffset
 * @param pSrc (in) from where we recreate the pointer to the uint3
 * @param pOffset (out) changes the offset to enable us to update the pSrc
 *        if < 0 then indicates some errors with memory allocation
 *        or pSrc is NULL
 * @return a pointer to a new uint3
 *         NULL if problems with memory allocation or pSrc is NULL
 */
inline int * l_unpackIntPtr(const char *pSrc, int * pOffset){
	int * p;

	if( !pSrc ){
		*pOffset = ERROR;
		return NULL;
	}

	*pOffset = 0;		// cleans the counter

	// pSrc
	int ** t1 = (int**) pSrc;
	pSrc += sizeof(void*);
	*pOffset = sizeof(void*);

	if( t1[0]){
		// not null
		p = (int*) malloc(sizeof(int));
		if( mallocCheck(p, __FUNCTION__, NULL ) == ERROR ){
			*pOffset = ERROR;
			return NULL;
		}
		// now we want to view the pSrc as an array of 3 unsigned int
		int * t2 = (int*) pSrc;
		*p = t2[0];
		*pOffset += sizeof(int);
	} else {
		assert(*pOffset == sizeof(void*));
		return NULL;
	}

	return p;
}

/**
 * Packs the function arguments in the very similar manner as packFatBinary.
 * Allocates memory to hold the all this packed stuff and packs the stuff
 * to that memory.
 *
 * @param all parameters are taken from ____cudaRegisterFunction
 * @param pSize (out) returns the size of the packet pointed by pPack
 *
 * @return pPack the pointer to the packed arguments
 *         NULL if some memory allocation problems or copying files
 */
char * packRegFuncArgs( void** fatCubinHandle, const char* hostFun,
        char* deviceFun, const char* deviceName, int thread_limit,
        uint3* tid, uint3* bid, dim3* bDim, dim3* gDim, int* wSize,
	int *pSize){
	// where we are
	int offset=0;
	char * pPack; // for the contiguous space with packed arguments up
	char * pPackStart; // the beginning

	*pSize = l_getSize_regFuncArgs(fatCubinHandle, hostFun,
	         deviceFun,  deviceName, thread_limit,  tid,
	         bid, bDim,  gDim,  wSize);

	pPack = malloc(*pSize);
	if( mallocCheck(pPack, __FUNCTION__, NULL) == ERROR )
		return NULL;

	// remember the beginning of the packet
	pPackStart = pPack;

	void *** p = (void ***) pPack;
	p[0] = fatCubinHandle;
	pPack += sizeof(void*);


	offset = l_packStr(pPack, hostFun);
	if( ERROR == offset ) return NULL; else pPack += offset;

	// pack the value of the pointer
	const char ** c = (const char**) pPack;
	c[0] = hostFun;
	pPack += sizeof(char*);

	offset = l_packStr(pPack, deviceFun);
	if( ERROR == offset ) return NULL; else pPack += offset;

	offset = l_packStr(pPack, deviceName);
	if( ERROR == offset ) return NULL; else pPack += offset;

	int * pInt = (int*) pPack;
	pInt[0] = thread_limit;
	pPack += sizeof(int);

	offset = l_packUint3Ptr(pPack, tid);
	if( ERROR == offset ) return NULL; else pPack += offset;

	offset = l_packUint3Ptr(pPack, bid);
	if( ERROR == offset ) return NULL; else pPack += offset;

	offset = l_packDim3Ptr(pPack, bDim);
	if( ERROR == offset ) return NULL; else pPack += offset;

	offset = l_packDim3Ptr(pPack, gDim);
	if( ERROR == offset ) return NULL; else pPack += offset;

	offset = l_packIntPtr(pPack, wSize);
	if( ERROR == offset ) return NULL; else pPack += offset;

	return pPackStart;
}

/**
 * Unpacks the reg func arguments
 *
 * @param pFatC the destination
 * @param pFatPack our source
 *
 * @return OK everything went smoothly
 *         ERROR there were some errors
 */
int unpackRegFuncArgs(reg_func_args_t * pRegFuncArgs, char * pPacket){
	int offset = 0;

	void *** v = (void***) pPacket;
	printf("Start: pPacket = %p, offset = %d\n",  pPacket, offset);
	pRegFuncArgs->fatCubinHandle = v[0];
	pPacket += sizeof(void*);
	printf("Handle: pPacket = %p, offset = %d\n",  pPacket, offset);

	// @todo it should be done better with NULL and with communicating
	// an error - right now it doesn't have an effect
	// you should change the implementation of l_packStr/l_unpackStr
	// to differentiate the NULL and the ERROR in the offset
	pRegFuncArgs->hostFun  = l_unpackStr(pPacket, &offset);
	if( ERROR == offset ) return ERROR; else pPacket += offset;

	char** c = (char **) pPacket;
	pRegFuncArgs->hostFEaddr = c[0];
	pPacket += sizeof(char*);

	pRegFuncArgs->deviceFun = l_unpackStr(pPacket, &offset);
	if( ERROR == offset ) return ERROR; else pPacket += offset;

	pRegFuncArgs->deviceName = l_unpackStr(pPacket, &offset);
	if( ERROR == offset ) return ERROR; else pPacket += offset;

	int * pI = (int *) pPacket;
	pRegFuncArgs->thread_limit = pI[0];
	pPacket += sizeof(int);

	pRegFuncArgs->tid = l_unpackUint3Ptr(pPacket, &offset);
	if( ERROR == offset ) return ERROR; else pPacket += offset;

	pRegFuncArgs->bid = l_unpackUint3Ptr(pPacket, &offset);
	if( ERROR == offset ) return ERROR; else pPacket += offset;

	pRegFuncArgs->bDim = l_unpackDim3Ptr(pPacket, &offset);
	if( ERROR == offset ) return ERROR; else pPacket += offset;

	pRegFuncArgs->gDim = l_unpackDim3Ptr(pPacket, &offset);
	if( ERROR == offset ) return ERROR; else pPacket += offset;

	pRegFuncArgs->wSize = l_unpackIntPtr(pPacket, &offset);
	if( ERROR == offset ) return ERROR; else pPacket += offset;

	return OK;
}

char * packRegVar( void **fatCubinHandle, char *hostVar,
		char *deviceAddress, const char *deviceName, int ext, int vsize,
		int constant, int global, int * pSize ){
	// where we are
	int offset = 0;
	char * pPack; // for the contiguous space with packed arguments up
	char * pPackStart; // the beginning

	*pSize = l_getSize_regVar(fatCubinHandle, hostVar, deviceAddress,
			deviceName, ext, vsize, constant, global);

	pPack = malloc(*pSize);

	if (mallocCheck(pPack, __FUNCTION__, NULL) == ERROR)
		return NULL;

	// remember the beginning of the packet
	pPackStart = pPack;

	void *** p = (void ***) pPack;
	p[0] = fatCubinHandle;
	pPack += sizeof(void*);

	// @todo experiments show that this is a pointer, not a string so
	// I will follow it
//	offset = l_packStr(pPack, hostVar);
//	if( ERROR == offset ) return NULL; else pPack += offset;

	// pack the value of the pointer
	const char ** c = (const char**) pPack;
	c[0] = hostVar;
	pPack += sizeof(char*);

	// This variable actually is just the address of deviceName variable. But
	// the adjustment is done in Dom0
	offset = l_packStr(pPack, deviceAddress);
	if( ERROR == offset ) return NULL; else pPack += offset;

	offset = l_packStr(pPack, deviceName);
	if( ERROR == offset ) return NULL; else pPack += offset;

	int * pInt = (int*) pPack;
	pInt[0] = ext;
	pPack += sizeof(int);

	pInt[1] = vsize;
	pPack += sizeof(int);

	pInt[2] = constant;
	pPack += sizeof(int);

	pInt[3] = global;
	pPack += sizeof(int);

	return pPackStart;
}

int unpackRegVar(reg_var_args_t * pRegVar, char *pPacket){
	int offset = 0;

	void *** v = (void***) pPacket;
	pRegVar->fatCubinHandle = v[0];
	pPacket += sizeof(void*);

	// @todo it should be done better with NULL and with communicating
	// an error - right now it doesn't have an effect
	// you should change the implementation of l_packStr/l_unpackStr
	// to differentiate the NULL and the ERROR in the offset
	// actually this part is tricky; since from experiments it looks
	// that hostVar is only a pointer to some place in host memory
	// so this function will return a NULL, as no string has been sent
	// Since in this packet I also send the value of the pointer so
	// I need to check if this unpacked is a pointer or a string
	// if this is a Null value then it is pointer that has been sent
	// via following bytes
	//pRegVar->hostVar  = l_unpackStr(pPacket, &offset);
	//if( ERROR == offset ) return ERROR; else pPacket += offset;


	// @todo I assume that hostVar holds a pointer
	char** c = (char **) pPacket;
	pRegVar->hostVar = c[0];
	pPacket += sizeof(char*);

	// this will keep a real host address on this (remote side)
	// this should be set by the __cudaRegisterVar()
	// it looks that hostVar will be a char (following GViM implementation)
	// copyRegVarArgs from local_api_wrapper.c
	// for some reason this can't be null, (the registerVar executed
	// remotely should set this
	// value somehow, but is doesn't set it up when initially it is set to NULL
	// it looks as this values is not changed by the registerVar
	// so I do not know, anyway following the original implementation.
	pRegVar->dom0HostAddr = (char *) malloc(sizeof(char));


	pRegVar->deviceAddress = l_unpackStr(pPacket, &offset);
	if( ERROR == offset ) return ERROR; else pPacket += offset;

	pRegVar->deviceName = l_unpackStr(pPacket, &offset);
	if( ERROR == offset ) return ERROR; else pPacket += offset;

	int * pI = (int *) pPacket;
	pRegVar->ext = pI[0];
	pRegVar->size = pI[1];
	pRegVar->constant = pI[2];
	pRegVar->global = pI[3];

	return OK;
}

// -------------------------------------
// frees functions
// -------------------------------------

/**
 * copied from local nvidia_backend/local_api_wrapper.c
 */
int freeRegFunc(reg_func_args_t *args){
	if (args == NULL)
		return OK;

	if (args->hostFun != NULL)
		free(args->hostFun);
	if (args->deviceFun != NULL)
		free(args->deviceFun);
	if (args->deviceName != NULL)
		free(args->deviceName);
	if (args->tid != NULL)
		free(args->tid);
	if (args->bid != NULL)
		free(args->bid);
	if (args->bDim != NULL)
		free(args->bDim);
	if (args->gDim != NULL)
		free(args->gDim);
	if (args->wSize != NULL)
		free(args->wSize);
	free(args);

	return OK;
}

int freeRegVar(reg_var_args_t *args){
	if (args == NULL)
		return OK;

	free(args->deviceName);
	free(args->deviceAddress);
	free(args->dom0HostAddr);
	free(args);

	return OK;
}

/**
 * free resources occupied by the fatCubin
 *
 * @return OK normally should return ok
 */
int freeFatBinary(__cudaFatCudaBinary *fatCubin){

	int i;
	__cudaFatPtxEntry *tempPtx;
	__cudaFatCubinEntry *tempCub;
	__cudaFatDebugEntry *tempDeb;
	__cudaFatElfEntry *tempElf;

	if( fatCubin == NULL )
		return OK;

	if( fatCubin->key != NULL )
		free(fatCubin->key);
	if (fatCubin->ident != NULL)
		free(fatCubin->ident);
	if (fatCubin->usageMode != NULL)
		free(fatCubin->usageMode);

	// free ptx
	// Ptx block
	if (fatCubin->ptx != NULL) {
		tempPtx = fatCubin->ptx;
		i = 0;
		while (!(tempPtx[i].gpuProfileName == NULL && tempPtx[i].ptx == NULL)) {
			if (tempPtx[i].gpuProfileName != NULL)
				free(tempPtx[i].gpuProfileName);
			if (tempPtx[i].ptx != NULL)
				free(tempPtx[i].ptx);
			i++;
		}
		free(fatCubin->ptx);
	}

	// Cubin block
	if (fatCubin->cubin != NULL) {
		tempCub = fatCubin->cubin;
		i = 0;
		while (!(tempCub[i].gpuProfileName == NULL && tempCub[i].cubin == NULL)) {
			if (tempCub[i].gpuProfileName != NULL)
				free(tempCub[i].gpuProfileName);
			if (tempCub[i].cubin != NULL)
				free(tempCub[i].cubin);
			i++;
		}

		free(fatCubin->cubin);
	}

	// Debug block
	if (fatCubin->debug != NULL) {
		tempDeb = fatCubin->debug;
		i = 0;
		while (!(tempDeb[i].gpuProfileName == NULL && tempDeb[i].debug == NULL)) {
			if (tempDeb[i].gpuProfileName != NULL)
				free(tempDeb[i].gpuProfileName);
			if (tempDeb[i].debug != NULL)
				free(tempDeb[i].debug);
			i++;
		}
		free(fatCubin->debug);
	}

	// Debug block
	if (fatCubin->debug != NULL) {
		tempDeb = fatCubin->debug;
		i = 0;
		while (!(tempDeb[i].gpuProfileName == NULL && tempDeb[i].debug == NULL)) {
			if (tempDeb[i].gpuProfileName != NULL)
				free(tempDeb[i].gpuProfileName);
			if (tempDeb[i].debug != NULL)
				free(tempDeb[i].debug);
			i++;
		}
		free(fatCubin->debug);
	}

	// elf block
	if (fatCubin->elf != NULL) {
		tempElf = fatCubin->elf;
		i = 0;
		while (!(tempElf[i].gpuProfileName == NULL && tempElf[i].elf == NULL)) {
			if (tempElf[i].gpuProfileName != NULL)
				free(tempElf[i].gpuProfileName);
			if (tempElf[i].elf != NULL)
				free(tempElf[i].elf);
			i++;
		}
		free(fatCubin->elf);
	}

	// @todo IGNORING DEPENDENDS AS OF NOW
	// exported/imported
	free(fatCubin);

	return OK;
}

// ---------------------------
// misc
// ---------------------------
/**
 * Translates method id to string
 * @param method_id The method id
 * @return a string corresponding to a given method id
 *         NULL if a method id has not been found
 */
char * methodIdToString(const int method_id){
	// could be an array of char* where you access the string with the
	// method_id indices, but then it might lead to errors if the order
	// in method_id.h will change, so this way is safer

	char * fname;

	switch(method_id){
	case CUDA_MALLOC: fname = "cudaMalloc"; break;
	case CUDA_FREE: fname = "cudaFree"; break;
	case CUDA_MEMCPY_H2D: fname = "cudaMemcpyH2D"; break;
	case CUDA_MEMCPY_D2H: fname = "cudaMemcpyD2H"; break;
	case CUDA_MEMCPY_H2H: fname = "cudaMemcpyH2H"; break;
	case CUDA_MEMCPY_D2D: fname = "cudaMemcpyD2D"; break;
	case CUDA_SETUP_ARGUMENT: fname = "cudaSetupArgument"; break;
	case CUDA_LAUNCH: fname = "cudaLaunch"; break;
	case CUDA_GET_DEVICE_COUNT: fname = "cudaGetDeviceCount"; break;
	case CUDA_GET_DEVICE_PROPERTIES: fname = "cudaGetDeviceProperties"; break;
	case CUDA_GET_DEVICE: fname = "cudaGetDevice"; break;
	case CUDA_SET_DEVICE: fname = "cudaSetDevice"; break;
	case CUDA_CONFIGURE_CALL: fname = "cudaConfigureCall"; break;
	case FE_BE_PIN_PAGES: fname = "feBePinPages"; break;
	case CUDA_THREAD_SYNCHRONIZE: fname = "cudaThreadSynchronize"; break;
	case CUDA_THREAD_EXIT: fname = "cudaThreadExit"; break;
	case CUDA_MEMSET: fname = "cudaMemset"; break;
	case CUDA_UNBIND_TEXTURE: fname = "cudaUnbindTexture"; break;
	case CUDA_BIND_TEXTURE_TO_ARRAY: fname = "cudaBindTextureToArray"; break;
	case CUDA_FREE_HOST: fname = "cudaFreeHost"; break;
	case CUDA_MEMCPY_TO_SYMBOL: fname = "cudaMemcpyToSymbol"; break;
	case CUDA_MEMCPY_FROM_SYMBOL: fname = "cudaMemcpyFromSymbol"; break;
	case CUDA_MALLOC_ARRAY: fname = "cudaMallocArray"; break;
	case CUDA_FREE_ARRAY: fname = "cudaFreeArray"; break;
	case CUDA_MEMCPY_TO_ARRAY_D2D: fname = "cudaMemcpyToArrayD2D"; break;
	case CUDA_MEMCPY_TO_ARRAY_H2D: fname = "cudaMemcpyToArrayH2D"; break;
	case CUDA_MEMCPY_TO_ARRAY_D2H: fname = "cudaMemcpyToArrayD2H"; break;
	case CUDA_MEMCPY_TO_ARRAY_H2H: fname = "cudaMemcpyToArrayH2H"; break;
	case __CUDA_REGISTER_FAT_BINARY: fname = "__cudaRegisterFatBinary"; break;
	case __CUDA_REGISTER_FUNCTION: fname = "__cudaRegisterFunction"; break;
	case __CUDA_REGISTER_VARIABLE: fname = "__cudaRegisterVariable"; break;
	case __CUDA_REGISTER_TEXTURE: fname = "__cudaRegisterTexture"; break;
	case __CUDA_REGISTER_SHARED: fname = "__cudaRegisterShared"; break;
	case __CUDA_UNREGISTER_FAT_BINARY: fname = "__cudaUnregisterFatBinary"; break;

	default: fname = NULL; break;
	}

	return fname;
}

/**
 * check if the pointer is null and if yes then exit
 *
 * @param p pointer to be checked
 * @param message the message that needs to be displayed when error occurs
 */
inline void nullExitChkpt(void *p, char * message){
	if(NULL == p)
		g_error(message);
}

/**
 * check if the pointer is null and if yes then exit
 *
 * @param p pointer to be checked
 * @param func The name of the function checking the pointer
 * @param message the message that needs to be displayed when error occurs
 * @return TRUE print the message and indicate that the pointer
 *              is null
 *         FALSE the pointer is not null and the message is
 *               not displayed
 */
inline gboolean nullDebugChkpt(const void * p, const char * func, char * message){
	if( NULL == p ){
		p_debug("%s: The pointer is NULL. %s ", func, message);
		return TRUE;
	}
	return FALSE;
}

/**
 * checks if the pointer is null and if yes then exits
 * Displays memory info
 *
 * @param p pointer to be checked
 * @param message the message the needs to be displayed when error occurs
 */
inline void nullExitChkptMalloc(void *p, char * message){
	if(NULL == p){
		if( NULL == message)
			g_error("Problems with memory allocation.\n");
		else
			g_error("Problems with memory allocation. %s\n", message);
	}
}
// ---------------------------------------------
// glib helper functions
// ---------------------------------------------


/**
 * returns the the pointer to the fatcubin_info_t corresponding to
 * a fatCubinHandle. If there is a few the same fatCubinHandles
 * the first found is returned
 *
 * infix fcia stays for F_atC_ubin_I_nfo A_rray
 *
 * @todo check for uniqueness of the fatCubinHandle
 *
 * @param fatCubinInfoArr the pointer to the array
 * @param fatCubinHandle against which handle do we compare entries in fatCubinInfoArr
 *
 * @return index of the entry holding the fatCubinHandle
 *         -1 if no entry equal to fatCubinHandle can be found or the fatCubinInfoArr
 *            is NULL
 */
inline int g_fcia_idx(GArray * fatCubinInfoArr, void ** fatCubinHandle) {
	fatcubin_info_t * e = NULL;
	int index = -1;
	unsigned int i;

	if (NULL == fatCubinInfoArr)
		return -1;

	for (i = 0; i < fatCubinInfoArr->len; i++) {
		e = &g_array_index( fatCubinInfoArr, fatcubin_info_t, i);
		if (e->fatCubinHandle == fatCubinHandle) {
			// we have found it
			index = (int) i;
			break;
		}
	}

	return index;
}


/**
 * returns the the pointer to the fatcubin_info_t corresponding to
 * a fatCubinHandle and an index . If there is a few the same fatCubinHandles
 * the first found is returned; invokes @see g_find_fatci
 *
 * @todo check for uniqueness of the fatCubinHandle
 *
 * @param fatCubinHandle against which handle do we compare entries in fatCubinInfoArr
 * @param fatCubinInfoArr the pointer to the array
 * @param pIndex (out) The return value of the index; -1 if not found
 * @return pointer to  the entry holding the fatCubinHandle
 *         NULL if no entry equal to fatCubinHandle can be found or fatCubinInfoArr
 *         is lost
 */
inline fatcubin_info_t * g_fcia_elidx(GArray * fatCubinInfoArr, void ** fatCubinHandle, int * pIndex){
	*pIndex = g_fcia_idx(fatCubinInfoArr, fatCubinHandle);

	return (-1 == *pIndex ? NULL : &g_array_index(fatCubinInfoArr, fatcubin_info_t, *pIndex));
}

/**
 * returns the the pointer to the fatcubin_info_t corresponding to
 * a fatCubinHandle. If there is a few the same fatCubinHandles
 * the first found is returned; invokes @see g_find_fatci
 *
 * @todo check for uniqueness of the fatCubinHandle
 *
 * @param fatCubinHandle against which handle do we compare entries in fatCubinInfoArr
 * @param fatCubinInfoArr the pointer to the array
 * @return pointer to  the entry holding the fatCubinHandle
 *         NULL if no entry equal to fatCubinHandle can be found or fatCubinInfoArr
 *         is lost
 */
inline fatcubin_info_t * g_fcia_elem(GArray * fatCubinInfoArr, void ** fatCubinHandle){

	int idx;

	return g_fcia_elidx(fatCubinInfoArr, fatCubinHandle, &idx);
}

/**
 * it looks for hostVar in the fatCubinInfoArr
 *
 * @param fatCubinInfoArr (in) The array we are searching through
 * @param hostVar (in) The original value as originally issued on the client side
 *                we assume this is a pointer - the client sends not the name
 *                but the pointer
 * @param pIndex (out) The index in fatcubin_info_t->variables where
 *          you found this; if not found then it is set to -1
 * @return pointer to the fatcubin_info_t containing the hostVar
 *         NULL  if the hostVar has not been found
 */
fatcubin_info_t * g_fcia_host_var(GArray * fatCubinInfoArr, char * hostVar, int * pIndex) {
	guint i;
	int j;
	fatcubin_info_t *fci = NULL;

	*pIndex = -1;

	if( fatCubinInfoArr == NULL )
		return NULL;

	for (i = 0; i < fatCubinInfoArr->len; i++) {
		fatcubin_info_t * p = &g_array_index(fatCubinInfoArr, fatcubin_info_t, i);
		assert( p != NULL );
		// now iterate through chosen fatcubin registered structure
		for (j = 0; j < p->num_reg_vars; j++) {
			if (p->variables[j] != NULL && p->variables[j]->hostVar == hostVar) {
				fci = p;
				*pIndex = j;
				break;
			}
		}
	}

	return fci;
}

// -------------------------------
// dealing with regVarsHashTable
// -------------------------------
/**
 * it inserts the hostVar to the regHostVarsTab; if the handler doesn't exist
 * it will be created
 * @param regHostVarsTab The table that will be updated
 * @param fcHandle The key
 * @param val the variable that will be stored
 *
 * @return NULL it means that fcHandle is NULL
 *         the value (pointer to array) corresponding to fcHandle in regHostVarsTab where the pValue
 *         has been inserted
 */
inline GPtrArray * g_vars_insert(GHashTable * regHostVarsTab, void ** fcHandle, vars_val_t * pValue){
//@todo
	// the array that holds or will hold the hostVar
	GPtrArray *varArr = NULL;

	if( NULL == fcHandle || NULL == pValue){
		p_debug("FatCubinHandler or pValue is NULL. We do not insert NULL fatCubinHandler\n");
		return NULL;
	}

	if( (varArr = g_hash_table_lookup(regHostVarsTab, fcHandle)) == NULL ){
		// we need to initiate a new array for hostVariable before we insert the
		// variable; and preallocate expected max registered vars
		varArr = g_ptr_array_new() ;
		g_hash_table_insert(regHostVarsTab, fcHandle, varArr);
	}

	g_ptr_array_add (varArr, (gpointer)pValue);

	return varArr;
}

/**
 * removes the handler and associated array of pointers from the table
 * @param regHostVarsTab The pointer to the table of host vars
 * @param fatCubinHandle The handler to be removed
 * @return OK
 */
inline int g_vars_remove(GHashTable * regHostVarsTab, void** fatCubinHandle){
	if( nullDebugChkpt(regHostVarsTab, "g_vars_remove", "regHostVarsTab\n") == TRUE
		|| nullDebugChkpt(fatCubinHandle, "g_vars_remove", "fatCubinHandle\n") == TRUE)
		return OK;

	// this trigger calling g_vars_remove_val
	g_hash_table_remove(regHostVarsTab, fatCubinHandle);

	return OK;
}

/**
 * removes the array; the call should be triggered automatically
 * when removing key from regHostVarTab (@see g_vars_remove())
 * @param value The array corresponding to the fat cubin handle.
 */
void g_vars_remove_val(gpointer * value){
	guint i;
	GPtrArray * varArr = (GPtrArray*) value;

	p_debug("Triggered call.\n");
	if( NULL == value )
		return;		// everything is freed

	for(i = 0; i < varArr->len; i++){
		g_vars_val_delete(g_ptr_array_index(varArr, i));
	}

	g_ptr_array_free(varArr, TRUE);
}

/**
 * predicate used by @see g_vars_find()
 *
 * @param key
 * @param value
 * @param user_data which should be an array containing two pointers to char:
 *        user_data[0] is a value we are checking, user_data[1]
 *        which is hostVar is the found
 *        result if return is TRUE;
 *
 * @return TRUE if the user_data has been found
 *         FALSE if the user_data has not been found
 */
gboolean l_g_vars_find_hostVar(gpointer key, gpointer value, gpointer user_data) {
	guint i ;
	GPtrArray * varArr = (GPtrArray*)value;
	GPtrArray * a = (GPtrArray *) user_data;
	// what for we are looking for
	char * symbol;

	if( user_data == NULL )
		return FALSE;

	symbol = g_ptr_array_index(a, 0);

	// first you need to iterate over
	for( i = 0; i < varArr->len; i++){
		vars_val_t * v = (vars_val_t *) g_ptr_array_index(varArr, i);
		if( (v->hostVar == symbol) ){
			g_ptr_array_add(a, v->hostVar);
			return TRUE;
		}
	}

	return FALSE;
}

/**
 * predicate used by @see g_vars_find(); this function should be called
 * after l_g_vars_find_hostVar;
 *
 * @param key
 * @param value
 * @param user_data which should be an array containing two pointers to char:
 *        user_data[0] is a value we are checking, user_data[1]
 *        which is hostVar is the found
 *        result if return is TRUE;
 *
 * @return TRUE if the user_data has been found
 *         FALSE if the user_data has not been found
 */
gboolean l_g_vars_find_deviceName(gpointer key, gpointer value, gpointer user_data) {
	guint i ;
	GPtrArray * varArr = (GPtrArray*)value;
	GPtrArray * a = (GPtrArray *) user_data;
	// what for we are looking for
	char * symbol;

	if( user_data == NULL )
		return FALSE;

	symbol = g_ptr_array_index(a, 0);


	// first you need to iterate over
	for( i = 0; i < varArr->len; i++){
		vars_val_t * v = (vars_val_t *) g_ptr_array_index(varArr, i);

		if( strcmp(v->deviceName, symbol) == 0 ){
			g_ptr_array_add(a, v->hostVar);

			return TRUE;
		}
	}

	return FALSE;
}


/**
 * checks if the regHostVarsTab contains specified hostVar pointer
 *
 * @param regHostVarsTab The table to be search of registered
 *        values
 * @param symbol what we are looking for - it is a symbol which can be a pointer
 *        (i.e., the address of the variable) or a string name (i.e. a pointer
 *        to the name of the variable - @see cudaMemcpyToSymbol() )
 * @return hostVar corresponding to a symbol which can be a pointer (the address
 *         of the variable) or a string name (i.e. a pointer to the name of the variable)
 *         NULL if symbol has not been found
 */
inline char * g_vars_find(GHashTable * regHostVarsTab, const char * symbol){

	char * result;

	if( nullDebugChkpt(regHostVarsTab,  "g_vars_find", "regHostVarsTab\n" ) == TRUE)
		return NULL;

	if( nullDebugChkpt( symbol, "g_vars_find", "symbol\n") == TRUE)
		return NULL;

	// find the array
	GPtrArray * user_data = g_ptr_array_new();
	g_ptr_array_add(user_data, (char* ) symbol);

	// first check if symbol is a pointer; if you change the sequence (first look
	// for a deviceName then for hostVar, if symbol is a hostVar, then it
	// strcmp used likely will be confused and will stop working
	g_hash_table_find(regHostVarsTab, (GHRFunc)l_g_vars_find_hostVar, (gpointer) user_data);

	if( user_data->len == 1)
		// now try with a device name;
		g_hash_table_find(regHostVarsTab, (GHRFunc)l_g_vars_find_deviceName, (gpointer) user_data);

	result = (user_data->len == 2 ? g_ptr_array_index(user_data, 1) : NULL);
	// if g_hash_table_find returns TRUE, user_data[1] contains the deviceName
	// if g_hash_table_find returns FALSE, we should return NULL and it means
	// that user_data has not been changed (and are initiated to NULL)
	g_ptr_array_free(user_data, TRUE);
	return result;
}

/**
 * creates a single structure from provied arguments: allocates memory and copies
 * strings; so you are responsible for removing this from memory later
 *
 * @param hostVar a pointer to the hostVariable on the client side
 * @param deviceName a string representing the device name
 * @return the pointer to a new structure
 *         NULL if you cannot allocate the memory
 */
vars_val_t * g_vars_val_new(char * hostVar, const char * deviceName){
	vars_val_t * v = g_new(vars_val_t, 1);

	v->hostVar = hostVar;
	v->deviceName = g_strdup(deviceName);

	return v;
}

/**
 * frees the memory; it should deal with NULL values, return NULL
 *
 * @param pValue value to be deleted
 * @return NULL
 */
vars_val_t * g_vars_val_delete(vars_val_t * pValue){
	p_debug("Executing: %s\n", __FUNCTION__);
	if( pValue != NULL ){
		g_free(pValue->deviceName);
		pValue->deviceName = NULL;
	}

	g_free(pValue);

	return NULL;
}
