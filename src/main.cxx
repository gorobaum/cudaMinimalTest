#include "cuda.h"
#include "cuda_runtime.h"
#include "cuda_occupancy.h"

#include <iostream>

#include "cutest.h"

int main(int argc, char** argv) {
  int size = 10;
  runCudaTest(size);

  return 0;
}
