#include <stdio.h>

__global__ void myKernel() {
    printf("Hello from thread %d, block %d\n", threadIdx.x, blockIdx.x);
}

int main() {
    // 定义执行配置和启动 kernel 函数
    myKernel<<<1, 5>>>();

    // 同步设备以确保 kernel 执行完成
    cudaDeviceSynchronize();

    return 0;
}

