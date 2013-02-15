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
#include "particle.h"
#include <assert.h>

#define SWIDTH 400
#define SHEIGHT 400
#define DT .5

int els_for_each;
float* a_h_global;
Particle *parts;
int nIters, pNum;
int deviceCount;
pthread_barrier_t barr;



__global__
void checkCollisionWithParticles(Particle *parts, int n, float dt, int gpuid, int BLOCK_SIZE, int els_for_each)
{

        int thid=blockIdx.x*BLOCK_SIZE+threadIdx.x;


	int i=thid+els_for_each*gpuid;
	{
		Vec3 p1,p2;
		Vec3 v1,v2;
		float m1;
		
		m1 = parts[i].m;
		
		p1[0] = parts[i].p[0]+parts[i].v[0]*dt;
		p1[1] = parts[i].p[1]+parts[i].v[1]*dt;
		p1[2] = parts[i].p[2]+parts[i].v[2]*dt;
		
		v1[0] = parts[i].v[0];
		v1[1] = parts[i].v[1];
		v1[2] = parts[i].v[2];
		
		for(int j=0; j<n;j++)
		{
			if(i!=j && !parts[j].willCollide && !parts[i].willCollide)
			{
				p2[0] = parts[j].p[0]+parts[j].v[0]*dt;
				p2[1] = parts[j].p[1]+parts[j].v[1]*dt;
				p2[2] = parts[j].p[2]+parts[j].v[2]*dt;
				
				v2[0] = parts[j].v[0];
				v2[1] = parts[j].v[1];
				v2[2] = parts[j].v[2];
				if(dist(p2,p1)<parts[i].r+parts[j].r)
				{
					Vec3 auxx, auxy, auxz;
					float v1xp, v2xp, v1x, v1y, v2x, v2y, m2 = parts[j].m, A, B, a, b, c;
					for(int k=0; k<3; k++)
						auxx[k] = parts[j].p[k]-parts[i].p[k];
						
					norm(auxx,&auxx);
					auxy[0] = -auxx[1];
					auxy[1] = auxx[0];
					
					auxz[0] = auxz[1] = 0;
					auxz[2] = 1;
					
					v1x = dot(parts[i].v,auxx);
					v1y = dot(parts[i].v,auxy);
					v2x = dot(parts[j].v,auxx);
					v2y = dot(parts[j].v,auxy);
					
					//A = v1x + (m2/m1)*v2x;
					//B = v1x*v1x + (m2/m1)*v2x*v2x;
					
					//a = m2/m1 + (m2*m2)/(m1*m1);
					//b = -2*A*(m2/m1);
					//c = A*A-B;
					
					//v2xp = (-b+sqrt(b*b-4*a*c))/(2*a);
					//v1xp = A-(m2/m1)*v2xp;
					v1xp = ((m1-m2)*v1x+2*m2*v2x)/(m1+m2);
					v2xp = v1x-v2x+v1xp;
					
					parts[i].willCollide = true;
					parts[j].willCollide = true;
									
					parts[i].nv[0] = auxx[0]*v1xp + auxy[0]*v1y;
					parts[i].nv[1] = auxx[1]*v1xp + auxy[1]*v1y;
					parts[i].nv[2] = auxx[2]*v1xp + auxy[2]*v1y;
					
					parts[j].nv[0] = auxx[0]*v2xp + auxy[0]*v2y;
					parts[j].nv[1] = auxx[1]*v2xp + auxy[1]*v2y;
					parts[j].nv[2] = auxx[2]*v2xp + auxy[2]*v2y;
					
				}
			}
		}
	}
}


__global__
void checkCollisionWithBox(Particle *parts, int n, float dt, int gpuid, int BLOCK_SIZE, int els_for_each)
{

        int thid=blockIdx.x*BLOCK_SIZE+threadIdx.x;


	int i=thid+els_for_each*gpuid;
	{
            if(!parts[i].willCollide)
            {
		float colt;
		float colv;
		if(parts[i].p[0]+parts[i].r+parts[i].v[0]*dt>SWIDTH/2.0 || parts[i].p[0]-parts[i].r+parts[i].v[0]*dt<-SWIDTH/2.0)
		{
			//colt = (SWIDTH/2.0-fabs(parts[i].p[0])-parts[i].r)/parts[i].v[0];
			//if(colt < parts[i].hit.t)
			{
				//parts[i].hit.t = colt;
				parts[i].willCollide = true;
				parts[i].nv[0] = -parts[i].v[0];
				parts[i].nv[1] = parts[i].v[1];
				parts[i].nv[2] = parts[i].v[2];
			}
			//parts[i].v[0] *= -1;
		}
		
		else if(parts[i].p[1]+parts[i].r+parts[i].v[1]*dt>SHEIGHT/2.0  || parts[i].p[1]-parts[i].r+parts[i].v[1]*dt<-SHEIGHT/2.0)
		{
			//colt = (SHEIGHT/2.0-fabs(parts[i].p[1])-parts[i].r)/parts[i].v[1];
			//if(colt < parts[i].hit.t)
			{
				//parts[i].hit.t = colt;
				parts[i].willCollide = true;
				parts[i].nv[0] = parts[i].v[0];
				parts[i].nv[1] = -parts[i].v[1];
				parts[i].nv[2] = parts[i].v[2];
			}
			//parts[i].v[1] *= -1;
		}
            }
	}
}

__global__
void advanceParticles(Particle *parts, int n, float dt, int gpuid, int BLOCK_SIZE, int els_for_each)
{


        int thid=blockIdx.x*BLOCK_SIZE+threadIdx.x;


	int i=thid+els_for_each*gpuid;
	{
		if(parts[i].willCollide == true)
		{
			parts[i].p[0] += parts[i].nv[0]*(dt);
			parts[i].p[1] += parts[i].nv[1]*(dt);
			parts[i].v[0] = parts[i].nv[0];
			parts[i].v[1] = parts[i].nv[1];
			parts[i].v[2] = parts[i].nv[2];
			parts[i].willCollide = false;
		}
		else
		{
			parts[i].p[0] += parts[i].v[0]*dt; 
			parts[i].p[1] += parts[i].v[1]*dt;
			//parts[i].p[2] += parts[i].v[2]*dt;
		}
	}
}     
	
  

// main routine that executes on the host
// >>>>>>>>> change main() -> cuda_main()
void* cuda_main(void* t) {
	long int gpuid = (long int)t;
	Particle *parts_h, *parts_d; // Pointer to host & device arrays
	const int N = els_for_each; // Number of elements in arrays
	size_t size = pNum * sizeof(Particle);
	int i;
	int deviceCount = 0;
	cudaDeviceProp prop;
	int cur_dev;
        


	assert(cudaSetDevice(gpuid)==cudaSuccess);
	cudaGetDevice(&cur_dev);
	printf("Dev: %d\n", cur_dev);


/*	cudaGetDeviceCount(&deviceCount);

	for(i = 0; i < deviceCount; i++){
		cudaGetDeviceProperties(&prop, i);
	}
*/
//	printf("%s.%d: The number of cuda devices is %d\n", __FUNCTION__, __LINE__, deviceCount);


	assert(cudaMalloc((void **) &parts_d, size)==cudaSuccess); // Allocate array on device
	printf("after cudaMalloc: parts_d = %p\n", parts_d);
	// Initialize host array and copy it to CUDA device
	//for (int i = 0; i < N; i++)
	//	a_h[i] = (float) i;
	assert(cudaMemcpy(parts_d, parts, size, cudaMemcpyHostToDevice)==cudaSuccess);
	// Do calculation on device:
	int block_size = 16;
	int n_blocks = N / block_size + (N % block_size == 0 ? 0 : 1);

	for(int i=0; i<nIters; i++)
    	{
        	checkCollisionWithParticles<<<n_blocks,block_size>>>(parts_d, pNum, DT, gpuid, block_size, els_for_each);
        	checkCollisionWithBox<<<n_blocks,block_size>>>(parts_d, pNum, DT, gpuid, block_size, els_for_each);
        	advanceParticles<<<n_blocks,block_size>>>(parts_d, pNum, DT, gpuid, block_size, els_for_each);
		assert(cudaMemcpy(parts+gpuid*els_for_each, parts_d+gpuid*els_for_each, els_for_each*sizeof(Particle), cudaMemcpyDeviceToHost)==cudaSuccess);
		printf("thid %d reached barier\n", gpuid);
                pthread_barrier_wait(&barr);
		printf("thid %d leaving barrier\n", gpuid);
                assert(cudaMemcpy(parts_d, parts, size, cudaMemcpyHostToDevice)==cudaSuccess);


	}
	//cudaConfigureCall(n_blocks, block_size, 0, 0);
	//cudaSetupArgument(&a_d, sizeof(float*), 0);
	//cudaSetupArgument(&N, sizeof(int), 0);
	//cudaLaunch("square_array");	

	// Retrieve result from device and store it in host array
	//cudaMemcpy(a_h, a_d, sizeof(float) * N, cudaMemcpyDeviceToHost);
	
	// Cleanup
	//free(a_h);
	cudaFree(parts_d);






	return 0;
}

void initParticles(Particle *parts, int n)
{
	for(int i=0; i<n; i++)
	{
		parts[i].p[0] = 300*(rand()/(float)RAND_MAX)-150;
		parts[i].p[1] = 300*(rand()/(float)RAND_MAX)-150;
		parts[i].p[2] = 0;// rand()/(float)RAND_MAX;
		
		parts[i].v[0] = rand()/(float)RAND_MAX - .5;
		parts[i].v[1] = rand()/(float)RAND_MAX - .5;
		parts[i].v[2] = 0;//rand()/(float)RAND_MAX - .5;
		
		parts[i].r = 2;
		parts[i].willCollide = false;
		parts[i].m = 100;
		//parts[i].hit.t = 100000;
	}

}


int main(int argv, char** argc){
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
	
        cudaError_t cuerr;
	double h_time=0;
	assert(argv>2);
	nIters = atoi(argc[1]);
	pNum = atoi(argc[2]);
	parts = (Particle *) malloc(pNum*sizeof(Particle));
	printf("Initializing particle system with pNum: %d\n", pNum);
        initParticles(parts, pNum);

	deviceCount = 0;
	cudaGetDeviceCount(&deviceCount);
        printf("NO OF DEVICES: %d\n", deviceCount);

	pthread_t* thid_array=(pthread_t*)malloc(deviceCount*sizeof(pthread_t));
	
	
	// now call the cuda main, so our GA enabler library can sort out
	// which cuda call goes where
	
	els_for_each = pNum/deviceCount;
	pthread_barrier_init(&barr, NULL, deviceCount);

	for(int i =0; i<deviceCount; i++)
	   pthread_create(&thid_array[i], NULL, cuda_main, (void*)i);
	
	//cuda_main();
	for(int i =0; i<deviceCount; i++)
	   pthread_join(thid_array[i], NULL);
	// Print results



	return 0;
}
