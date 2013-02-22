/**
 * @file libciutils.h
 * @brief The header file for the libciutils.c
 *
 * @date Mar 1, 2011
 * @author Magda Slawinska, magg __at_ gatech __dot_ edu
 */

#ifndef CITUILS_H_
#define CITUILS_H_

#include <__cudaFatFormat.h>
#include "cudaFatBinary.h"
#include "packetheader.h"
#include "fatcubininfo.h"
#include <glib.h>		// GArray
/**
 * For storing the number of records  for particular structures
 * contained in the __cudaFatCubinBinaryRec
 */
typedef struct {
	int nptxs;
	int ncubs;
	int ndebs;
	int ndeps; // number of dependends
	int nelves;
	int nexps; // number of exported
	int nimps; // number of imported
} cache_num_entries_t;

typedef struct {
	int * p;
	int size;
} array_int_t;

/**
 * a helper structure that stores the information about the registered variable
 * and a corresponding name of this variable. It is intended to be used
 * to map deviceName to hostVar which is expected by cudaMemcpyTo/FromSymbol;
 * so we can provide a hostVar to the remote side even if the symbol is
 * a string. It is used in __cudaRegisterVariables and later in cudaMemcpyTo/FromSymbol
 */
typedef struct {
	char * hostVar;
	char * deviceName;
} vars_val_t;

/**
 * To use it when marshaling and unmarshaling in the sent packet
 * Should indicate the size of the following bytes
 */
typedef unsigned int size_pkt_field_t;

int mallocCheck(const void * const p, const char * const pFuncName,
		const char * pExtraMsg);

/**
 * check if the pointer is null and if yes then exit
 *
 * @param p pointer to be checked
 * @param func the name of the function we are checking in
 * @param message the message that needs to be displayed when error occurs
 * @return TRUE print the message and indicate that the pointer
 *              is null
 *         FALSE the pointer is not null and the message is
 *               not displayed
 */
inline gboolean nullDebugChkpt(const void * p, const char *func, char * message);

/**
 * check if the pointer is null and if yes then exit
 *
 * @param p pointer to be checked
 * @param message the message that needs to be displayed when error occurs
 */
inline void nullExitChkpt(void *p, char * message);

/**
 * checks if the pointer is null and if yes then exits
 * Displays memory info
 *
 * @param p pointer to be checked
 * @param message the message the needs to be displayed when error occurs
 */
inline void nullExitChkptMalloc(void *p, char * message);

inline char * freeBuffer(char * pBuffer);

int getFatRecPktSize(const __cudaFatCudaBinary *pFatCubin,
		cache_num_entries_t * pEntriesCache);
//int get_fat_rec_size(__cudaFatCudaBinary *fatCubin, cache_num_entries_t *num);

int packFatBinary(char * pFatPack, __cudaFatCudaBinary * const pSrcFatC,
		cache_num_entries_t * const pEntriesCache);
int unpackFatBinary(__cudaFatCudaBinary *pFatC, char * pFatPack);

char * packRegFuncArgs(void** fatCubinHandle, const char* hostFun,
		char* deviceFun, const char* deviceName, int thread_limit, uint3* tid,
		uint3* bid, dim3* bDim, dim3* gDim, int* wSize, int *pSize);
int unpackRegFuncArgs(reg_func_args_t * pRegFuncArgs, char * pPacket);

char * packRegVar(void **fatCubinHandle, char *hostVar, char *deviceAddress,
		const char *deviceName, int ext, int vsize, int constant, int global,
		int * pSize);
int unpackRegVar(reg_var_args_t * pRegVar, char *pPacket);

int freeRegFunc(reg_func_args_t *args);
int freeFatBinary(__cudaFatCudaBinary *fatCubin);
int freeRegVar(reg_var_args_t *args);

cuda_packet_t * callocCudaPacket(const char * pFunctionName,
		cudaError_t * pCudaError);

// print utilities
void l_printFatBinary(__cudaFatCudaBinary * pFatBin);
void l_printRegFunArgs(void** fatCubinHandle, const char* hostFun,
		char* deviceFun, const char* deviceName, int thread_limit, uint3* tid,
		uint3* bid, dim3* bDim, dim3* gDim, int* wSize);
void l_printRegVar(void **fatCubinHandle, char *hostVar, char *deviceAddress,
		const char *deviceName, int ext, int vsize, int constant, int global);
int l_printCudaDeviceProp(const struct cudaDeviceProp * const pProp);
int printFatCIArray(GArray * fcia);
int printRegVarTab(GHashTable * tab);

/**
 * cleans the structure, frees the allocated memory, sets values to zeros,
 * nulls, etc; intended to be used in __unregisterCudaFatBinary
 */
int cleanFatCubinInfo(fatcubin_info_t * pFatCInfo);

/**
 * removes the handler and associated array of pointers from the table
 * @param regHostVarsTab The pointer to the table of host vars
 * @param fatCubinHandle The handler to be removed
 * @return OK
 */
int g_vars_remove(GHashTable * regHostVarsTab, void** fatCubinHandle);

/**
 * Translates method id to string
 * @param method_id The method id
 * @return a string corresponding to a given method id
 *         NULL if a method id has not been found
 */
char * methodIdToString(const int method_id);

/**
 * Reads the interposer:local value from the KIDRON_INI file and returns
 * the numerical value
 *
 * @return 1 - Local GPU will be invoked (means interposer:local is yes)
 *         0 - remote GPU will be invoked (means interposer:local is set no)
 */
inline int l_getLocalFromConfig(void);

/**
 * returns an index in fatCubinInfoArr to the fatcubin_info_t corresponding to
 * a provided fatCubinHandle. If there is a few the same fatCubinHandles
 * the first found is returned (I guess it should never happen)
 *
 * @todo check for uniqueness of the fatCubinHandle
 *
 * @param fatCubinInfoArr the pointer to the array
 * @param fatCubinHandle against which handle do we compare entries in fatCubinInfoArr
 * @return index of the entry holding the fatCubinHandle
 *         -1 if no entry equal to fatCubinHandle can be found
 */
inline int g_fcia_idx(GArray * fatCubinInfoArr, void ** fatCubinHandle);

/**
 * returns the the pointer to the fatcubin_info_t corresponding to
 * a fatCubinHandle. If there is a few the same fatCubinHandles
 * the first found is returned
 *
 * @todo check for uniqueness of the fatCubinHandle
 *
 * @param fatCubinHandle against which handle do we compare entries in fatCubinInfoArr
 * @param fatCubinInfoArr the pointer to the array
 * @return pointer to  the entry holding the fatCubinHandle
 *         NULL if no entry equal to fatCubinHandle can be found or fatCubinInfoArr
 *         is lost
 */
inline fatcubin_info_t * g_fcia_elem(GArray * fatCubinInfoArr,
		void ** fatCubinHandle);

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
inline fatcubin_info_t * g_fcia_elidx(GArray * fatCubinInfoArr,
		void ** fatCubinHandle, int * pIndex);

/**
 * it looks for hostVar in the fatCubinInfoArr
 *
 * @param fatCubinInfoArr The array we are searching through
 * @param hostVar The original value as originally issued on the client side
 *                we assume this is a pointer - the client sends not the name
 *                but the pointer
 * @param pIndex (out) The index in fatcubin_info_t->variables where
 *          you found this
 * @return pointer to the fatcubin_info_t containing the hostVar
 *         NULL if the hostVar has not been found
 */
fatcubin_info_t * g_fcia_host_var(GArray * fatCubinInfoArr, char * hostVar, int *pIndex) ;
// ----------------------------------
// register variables hash table helper functions
// ----------------------------------

/**
 * it inserts the hostVar to the regHostVarsTab;
 * @param regHostVarsTab The table that will be updated
 * @param fcHandle The key
 * @param value the variable that will be stored
 *
 * @return NULL it means that fcHandle is NULL
 *         the value corresponding to fcHandle in regHostVarsTab where the val
 *         has been inserted
 */
inline GPtrArray * g_vars_insert(GHashTable * regHostVarsTab, void ** fcHandle,
		vars_val_t * val);

/**
 * checks if the regHostVarsTab contains specified hostVar pointer
 *
 * @param regHostVarsTab The table to be search of registered
 *        values
 * @param symbol what we are looking for - it is a symbol which can be a pointer
 *        (i.e., the address of the variable) or a string name (i.e. a pointer
 *        to the name of the variable - @see cudaMemcpyToSymbol() )
 * @return deviceName corresponding to a symbol which can be a pointer (the address
 *         of the variable) or a string name (i.e. a pointer to the name of the variable)
 *         NULL if symbol has not been found
 */
inline char * g_vars_find(GHashTable * regHostVarsTab, const char * symbol);

/**
 * removes the handler and associated array of pointers from the table
 * @param regHostVarsTab The pointer to the table of host vars
 * @param fatCubinHandle The handler to be removed
 * @return OK
 */
inline int g_vars_remove(GHashTable * regHostVarsTab, void** fatCubinHandle);

/**
 * removes the array; the call should be triggered automatically
 * when removing key from regHostVarTab (@see g_vars_remove())
 * @param value The array corresponding to the fat cubin handle.
 */
void g_vars_remove_val(gpointer * value);



/**
 * creates a single structure from provied arguments: allocates memory and copies
 * strings; so you are responsible for removing this from memory later
 *
 * @param hostVar a pointer to the hostVariable on the client side
 * @param deviceName a string representing the device name
 * @return the pointer to a new structure
 *         NULL if you cannot allocate the memory
 */
vars_val_t * g_vars_val_new(char * hostVar, const char * deviceName);

/**
 * frees the memory; it should deal with NULL values, return NULL
 *
 * @param pValue value to be deleted
 * @return NULL
 */
vars_val_t * g_vars_val_delete(vars_val_t * pValue);

#endif /* CITUILS_H_ */
