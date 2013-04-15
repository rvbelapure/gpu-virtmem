/**
 * @file fatcubininfo.h
 * @brief Defines data relate to fat cubin binary; data copied from
 * remote_gpu/nvidia_backend/defs.h
 *
 * @date Mar 21, 2011
 * @author Magda Slawinska, magg __at_ gatech __dot_ edu
 */

#ifndef FATCUBININFO_H_
#define FATCUBININFO_H_

//! the maximum number of fatcubins structures we support
//! in general it should be a vector with dynamic length as
//! all those MAX_REGISTERED_THINGS
//#define MAX_FATCUBINS 3

// @todo looks as those values are observed empirically

// Maximum number of distinct kernels that will be invoked by a domain
#define MAX_REGISTERED_FUNCS 10
// Maximum number of constant/shared cuda variables
#define MAX_REGISTERED_VARS 10
#define MAX_REGISTERED_TEXS 10
#define MAX_REGISTERED_SHARED 5

/**
 * previously known as dom_fat_info_t
 * Stores important information about the fat cubin
 *
 */
typedef struct {
	void **fatCubinHandle;
	__cudaFatCudaBinary *fatCubin;

	// Cache all the RegisterVar values and compare them with
	// cudaMemcpy2Symbol
	int num_reg_vars;
	reg_var_args_t *variables[MAX_REGISTERED_VARS];

	// Cache all the RegisterTex values and compare them with
	int num_reg_texs;
	reg_tex_args_t *textures[MAX_REGISTERED_TEXS];

	// All the shared variables
	int num_reg_shared;
	char *shared_vars[MAX_REGISTERED_SHARED];

	// This could be a fancier data structure to enable quick
	// searching of functions but linear shouldn't be so bad with
	// < 10 elements
	int num_reg_fns;
	reg_func_args_t *reg_fns[MAX_REGISTERED_FUNCS];
} fatcubin_info_t;


#endif /* FATCUBININFO_H_ */
