/**
 * @file method_id.h
 * @brief Contains debug utils
 * Copied from: remote_gpu/include/method_id.h
 *
 * @date Feb 28, 2011
 * @author Prepared by Magda Slawinska, magg@gatech.edu
 */

#ifndef __METHOD_ID_H
#define __METHOD_ID_H

// Method IDs we assign to API functions.
// !WARNING! Ordering of these is important! If modified, the API function tables which use this
// must have these changes reflected in them, as the value of these enums index into the function
// table.
typedef enum METHOD_ID {
    CUDA_MALLOC = 1, // don't set this to zero to catch indicies set to zero then not modified
    CUDA_FREE,
    CUDA_MEMCPY_H2D,
    CUDA_MEMCPY_D2H,
    CUDA_MEMCPY_H2H,
    CUDA_MEMCPY_D2D,
    CUDA_SETUP_ARGUMENT,
    CUDA_LAUNCH,
    CUDA_GET_DEVICE_COUNT,
    CUDA_GET_DEVICE_PROPERTIES,
    CUDA_GET_DEVICE, 	// added by MS
    CUDA_SET_DEVICE,
    CUDA_CONFIGURE_CALL,
    // For calls that require more than one page to be pinned, the
    // mfn (machine frame number) needs to be conveyed to the backend due to user kernel
    // single page at a time map issues. So use this method to just
    // create a mapping and then make the respective function call
    // for which all this was arranged
    FE_BE_PIN_PAGES,
    CUDA_THREAD_SYNCHRONIZE,
    CUDA_THREAD_EXIT,
    CUDA_MEMSET,
    CUDA_UNBIND_TEXTURE,
    CUDA_BIND_TEXTURE_TO_ARRAY,
    CUDA_FREE_HOST,
    CUDA_MEMCPY_TO_SYMBOL,
    CUDA_MEMCPY_FROM_SYMBOL, // added by Magic
    CUDA_MALLOC_ARRAY,
    CUDA_FREE_ARRAY,
    CUDA_MEMCPY_TO_ARRAY_D2D,
    CUDA_MEMCPY_TO_ARRAY_H2D,
    CUDA_MEMCPY_TO_ARRAY_D2H,
    CUDA_MEMCPY_TO_ARRAY_H2H,
    CUDA_MEMCPY_2D_TO_ARRAY_D2D,
    CUDA_MEMCPY_2D_TO_ARRAY_H2D,
    CUDA_MEMCPY_2D_TO_ARRAY_D2H,
    CUDA_MEMCPY_2D_TO_ARRAY_H2H,
    __CUDA_REGISTER_FAT_BINARY,
    __CUDA_REGISTER_FUNCTION,
    __CUDA_REGISTER_VARIABLE,
    __CUDA_REGISTER_TEXTURE,
    __CUDA_REGISTER_SHARED,
    __CUDA_UNREGISTER_FAT_BINARY,
    // TODO If we start the first entry at zero, then this would be correct.
    MAX_METHODS
} method_id;


// Defining this in general even when not profiling calls
#define __CALL_PROFILE_CALL 100

#endif
