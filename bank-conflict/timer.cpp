#include "test_bazel/test_cuda/bank-conflict/timer.hpp"
#include <chrono>
#include <iostream>
#include <memory>

#include "cuda_runtime.h"
#include "cuda_runtime_api.h"
#include "test_bazel/test_cuda/bank-conflict/utils.hpp"

Timer::Timer() {
  _timeElasped = 0;
  _cStart = std::chrono::high_resolution_clock::now();
  _cStop = std::chrono::high_resolution_clock::now();
  cudaEventCreate(&_gStart);
  cudaEventCreate(&_gStop);
}

Timer::~Timer() {
  cudaFree(_gStart);
  cudaFree(_gStop);
  cudaEventDestroy(_gStart);
  cudaEventDestroy(_gStop);
}

void Timer::start_gpu() { cudaEventRecord(_gStart, 0); }

void Timer::stop_gpu() { cudaEventRecord(_gStop, 0); }

void Timer::start_cpu() { _cStart = std::chrono::high_resolution_clock::now(); }

void Timer::stop_cpu() { _cStop = std::chrono::high_resolution_clock::now(); }

void Timer::duration_gpu(std::string msg) {
  CUDA_CHECK(cudaEventSynchronize(_gStart));
  CUDA_CHECK(cudaEventSynchronize(_gStop));
  cudaEventElapsedTime(&_timeElasped, _gStart, _gStop);

  // cudaDeviceSynchronize();
  // LAST_KERNEL_CHECK();

  LOG("%-60s uses %.6lf ms", msg.c_str(), _timeElasped);
}
