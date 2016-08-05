#include <iostream>
#include <cassert>
#include <iostream>

#include "cuda.h"
#include "cuda_runtime.h"
#include "cuda_occupancy.h"

#include "cutest.h"

__global__ void testCuda(int* cudamtxa, int* cudamtxb, int* cudamtxc) {
  int i = threadIdx.x;

  cudamtxc[i] = cudamtxa[i] + cudamtxb[i];
}

void runCudaTest(int size) {
  int *a, *b, *c;
  int *cudamtxa, *cudamtxb, *cudamtxc;

  dim3 threadPerBlock(size);

  a = (int*)malloc(size * sizeof(int));
  b = (int*)malloc(size * sizeof(int));
  c = (int*)malloc(size * sizeof(int));

  for (int i = 0; i < size; i++) {
    a[i] = 1;
    b[i] = i;
  }

  cudaMalloc(&cudamtxa, size*sizeof(int));
  cudaMalloc(&cudamtxb, size*sizeof(int));
  cudaMalloc(&cudamtxc, size*sizeof(int));

  cudaMemcpy(cudamtxa, a, size*sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(cudamtxb, b, size*sizeof(int), cudaMemcpyHostToDevice);

  testCuda<<<1, threadPerBlock>>>(cudamtxa, cudamtxb, cudamtxc);
  cudaMemcpy(c, cudamtxc, size*sizeof(int), cudaMemcpyDeviceToHost);
  cudaDeviceSynchronize();

  for (int i = 0; i < size; i++)
    std::cout << c[i] << std::endl;

  free(a);
  free(b);
  free(c);
}
