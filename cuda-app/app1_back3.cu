/**
 * @file interposer.c
 * @brief Demonstrates using of libcudainterpose.c
 *
 * @date Feb 4, 2011
 * @author Magda S., magg@gatech.edu
 */

//#include "stdafx.h"

#include <stdio.h>
#include <cuda.h>
#include <pthread.h>

// Kernel that executes on the CUDA device
__global__ void square_array(float *a, int N) {
	int idx = blockIdx.x * blockDim.x + threadIdx.x;
	if (idx < N)
		a[idx] = a[idx] * a[idx];
}


// main routine that executes on the host
// >>>>>>>>> change main() -> cuda_main()
void* cuda_main(void* t) {
	long int gpuid = (long int)t;
	float *a_h, *a_d; // Pointer to host & device arrays
	const int N = 10; // Number of elements in arrays
	size_t size = N * sizeof(float);
	int i;
	int deviceCount = 0;
	cudaDeviceProp prop;
	int cur_dev;
        

	cudaGetDeviceCount(&deviceCount);
        printf("NO OF DEVICES: %d\n", deviceCount);

	if(cudaSetDevice(gpuid)!=cudaSuccess) printf("FAILED\n");
	cudaGetDevice(&cur_dev);
	printf("Dev: %d\n", cur_dev);


/*	cudaGetDeviceCount(&deviceCount);

	for(i = 0; i < deviceCount; i++){
		cudaGetDeviceProperties(&prop, i);
	}
*/
//	printf("%s.%d: The number of cuda devices is %d\n", __FUNCTION__, __LINE__, deviceCount);

	a_h = (float *) malloc(size); // Allocate array on host
	a_d = NULL;

	cudaMalloc((void **) &a_d, size); // Allocate array on device
	printf("after cudaMalloc: a_d = %p\n", a_d);
	// Initialize host array and copy it to CUDA device
	for (int i = 0; i < N; i++)
		a_h[i] = (float) i;
	cudaMemcpy(a_d, a_h, size, cudaMemcpyHostToDevice);
	// Do calculation on device:
	int block_size = 4;
	int n_blocks = N / block_size + (N % block_size == 0 ? 0 : 1);

	square_array <<< n_blocks, block_size >>> (a_d, N);
	//cudaConfigureCall(n_blocks, block_size, 0, 0);
	//cudaSetupArgument(&a_d, sizeof(float*), 0);
	//cudaSetupArgument(&N, sizeof(int), 0);
	//cudaLaunch("square_array");	

	// Retrieve result from device and store it in host array
	cudaMemcpy(a_h, a_d, sizeof(float) * N, cudaMemcpyDeviceToHost);
	// Print results
	for (int i = 0; i < N; i++)
		printf("%d %f\n", i, a_h[i]);

	// Cleanup
	free(a_h);
	cudaFree(a_d);

//------------------------------------------------
#if 0
        cudaSetDevice(2);
        cudaGetDevice(&cur_dev);
        printf("Dev: %d\n", cur_dev);


/*      cudaGetDeviceCount(&deviceCount);

        for(i = 0; i < deviceCount; i++){
                cudaGetDeviceProperties(&prop, i);
        }
*/
//      printf("%s.%d: The number of cuda devices is %d\n", __FUNCTION__, __LINE__, deviceCount);

        a_h = (float *) malloc(size); // Allocate array on host
        a_d = NULL;

        cudaMalloc((void **) &a_d, size); // Allocate array on device
        printf("after cudaMalloc: a_d = %p\n", a_d);
        // Initialize host array and copy it to CUDA device
        for (int i = 0; i < N; i++)
                a_h[i] = (float) i;
        cudaMemcpy(a_d, a_h, size, cudaMemcpyHostToDevice);
        // Do calculation on device:
        block_size = 4;
        n_blocks = N / block_size + (N % block_size == 0 ? 0 : 1);
        square_array <<< n_blocks, block_size >>> (a_d, N);
        // Retrieve result from device and store it in host array
        cudaMemcpy(a_h, a_d, sizeof(float) * N, cudaMemcpyDeviceToHost);
        // Print results
        for (int i = 0; i < N; i++)
                printf("%d %f\n", i, a_h[i]);

        // Cleanup
        free(a_h);
        cudaFree(a_d);
#endif





	return 0;
}

int main(){
	// I wonder, if this cannot be done by Python, since this is administration
	// and python integrates with c, so I think it might be wiser
	// to use python for that. but maybe later, when the thinks will clarify
	// create GPU assembly
	// 0. init if not initialized
	// (not here outthere) the device - create in buStore the representations
	// of the physical devices
	// 1. specify how many GPU you need
	// 2. create as many vgpu (in terms of structures) as required
	// 3. wire vgpu to gpus
	// 4. gpu assembly
	// 5. some process needs to clean up after - but we do not worry about that

	printf("\n*******************************\n");
	printf("CUDA APP START\n");
	printf("*******************************\n");
	
	pthread_t thid1, thid2;
	// now call the cuda main, so our GA enabler library can sort out
	// which cuda call goes where
	pthread_create(&thid1, NULL, cuda_main, (void*)0);
	pthread_create(&thid2, NULL, cuda_main, (void*)2);
	//cuda_main();
	pthread_join(thid1, NULL);
	pthread_join(thid2, NULL);


	return 0;
}
