cmake_minimum_required (VERSION 2.8)

project (cutest)

find_package(CUDA REQUIRED)

set(CUDA_NVCC_FLAGS "${CUDA_NVCC_FLAGS} -Xptxas -v -arch=sm_30")

cuda_compile(CUTPS_O src/cutest.cu)

cuda_add_executable(cutest
  src/main.cxx

  ${CUTPS_O}
  )

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x -fpermissive -include cstddef -w")


# TODO: Fix CUDA_cusolver_LIBRARY in FindCUDA.cmake
target_link_libraries(cutest
    ${CMAKE_THREAD_LIBS_INIT}
    ${CUDA_CUBLAS_LIBRARIES})
