#include <stdio.h>
#include <cuda.h>


__global__ void Add(float *A, int size)
{
  const unsigned int numThreads = blockDim.x * gridDim.x;
  const int idx = (blockIdx.x * blockDim.x) + threadIdx.x;

  for (unsigned int i = idx;i < size; i += numThreads)
	   A[i] = A[i]+ A[i];
}

void test_bandwidth()
{
	cudaEvent_t* ticktock;
	ticktock = (cudaEvent_t*)malloc(2*sizeof(cudaEvent_t));
	cudaEventCreate(&ticktock[0]);
	cudaEventCreate(&ticktock[1]);
	int iter = 10;
	printf("The bandwidth should stay be about the same each time:\n");
	size_t free = 0, total = 0;  
	cudaMemGetInfo(&free,&total);
	double used_memory_in_MB = (total- free)/1024./1024.;
	printf("Memory used by OS %f GB\n",used_memory_in_MB/1024.);
	for(int i = 128; i < 4096 - used_memory_in_MB;i+=256 )
	{
		float time = 0.0f;
		float *gpu_data;
		int size = i*(1024*1024/4);
		size_t bytes = size*sizeof(float);
		cudaMalloc((void**)&gpu_data, bytes);
		cudaMemset(gpu_data,0,bytes);
		
		cudaEventRecord(ticktock[0], 0);

		//run multiple iterations to saturate the GPU		
		for(int j = 0; j < iter; j++)
			Add<<<512,512>>>(gpu_data, size);
		

		cudaEventRecord(ticktock[1], 0);
		cudaEventSynchronize(ticktock[1]);
		cudaEventElapsedTime(&time, ticktock[0], ticktock[1]);
		cudaDeviceSynchronize();

		time = time/1000.0f; //seconds

		float GB = ((iter*i)/1024.0f); 

		printf("Data size: %f GB; Bandwidth: %f GB/s\n",i/1024.0f, GB/time);

		cudaFree(gpu_data);


	}


}



int main(int argc, char *argv[])
{
	test_bandwidth();
	return 0;
}