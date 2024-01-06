#include <iostream>
#include <cuda_runtime.h>

int main() {
    // CUDA 设备属性结构体
    cudaDeviceProp devProp;

    // 获取当前设备的属性
    cudaGetDeviceProperties(&devProp, 0);  // 0 表示第一个 GPU 设备，可以根据需要更改设备编号

    // 打印设备属性信息
    std::cout << "Device Name: " << devProp.name << std::endl;
    std::cout << "Compute Capability: " << devProp.major << "." << devProp.minor << std::endl;
    std::cout << "Total Global Memory: " << devProp.totalGlobalMem / (1 << 30) << " GB" << std::endl;
    std::cout << "SM(Stream Multiprocessors)数量: " << devProp.multiProcessorCount << std::endl;
    std::cout << "每个SM最大线程数: " << devProp.maxThreadsPerMultiProcessor << std::endl;
    std::cout << "每个SM最大线程束数量: " << devProp.maxThreadsPerMultiProcessor / 32 << std::endl;
    std::cout << "每个线程块最大的线程数: " << devProp.maxThreadsPerBlock << std::endl;
    std::cout << "Max Memory Per Block: " << devProp.sharedMemPerBlock / 1024.0 << " KB" << std::endl;

    return 0;
}
