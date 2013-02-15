/**
 * @file add1.cu
 * @brief this example is for testing cudaMemcpyFrom/ToSymbol
 *
 * @date Apr 27, 2011
 * @author Magda Slawinska, magg __at_ gatech __dot_ edu
 */


#include <stdio.h>
#include <cuda.h>

#define MAX 14

__device__ char name_device[MAX];
__device__ int tab_d[MAX];
__constant__ __device__ char hw[] = "Hello World!\n";

__global__ void helloWorldOnDevice(void) {
	int idx = blockIdx.x;
	name_device[idx] = hw[idx];
	tab_d[idx] *= tab_d[idx];
}

__global__ void inc(void){
	int idx = blockIdx.x;
	tab_d[idx]++;
}

int main(void) {
	int tab_h[MAX];
	int tab_h1[MAX];
	int i;
	char name_host[MAX];


	for (i = 0; i < MAX; i++)
		tab_h[i] = i;

	// symbol as a pointer
	cudaMemcpyToSymbol(tab_d, tab_h, sizeof(int) * MAX, 0,
			cudaMemcpyHostToDevice);

	helloWorldOnDevice <<< MAX, 1 >>> ();
	cudaThreadSynchronize();

	// -----------  symbol as a pointer to a variable
	cudaMemcpyFromSymbol(name_host, name_device, sizeof(char) * 13, 0,
			cudaMemcpyDeviceToHost);
	cudaMemcpyFromSymbol(tab_h1, tab_d, sizeof(int) * MAX, 0,
			cudaMemcpyDeviceToHost);

	printf("\n\nGot from GPU: %s\n", name_host);
	if (strcmp(name_host, "Hello World!\n") == 0)
		printf("Hello test: PASSED\n");
	else
		printf("Hello test: FAILED\n");

	for (i = 0; i < MAX; i++) {
		if (tab_h1[i] != (tab_h[i] * tab_h[i])) {
			printf("FAILED!\n");
			break;
		} else
			printf("tab_h1[%d] = %d\n", i, tab_h1[i]);
	}

	// ----------- now symbol as a name
	// symbol as a name
	cudaMemcpyToSymbol("tab_d", tab_h, sizeof(int) * MAX, 0,
				cudaMemcpyHostToDevice);
	inc <<< MAX, 1 >>> ();
	cudaThreadSynchronize();
	cudaMemcpyFromSymbol(tab_h1, "tab_d", sizeof(int) * MAX, 0,
			cudaMemcpyDeviceToHost);
	for (i = 0; i < MAX; i++) {
		if (tab_h1[i] != (tab_h[i] + 1)) {
			printf("FAILED!\n");
			break;
		} else
			printf("tab_h1[%d] = %d\n", i, tab_h1[i]);
	}

}

