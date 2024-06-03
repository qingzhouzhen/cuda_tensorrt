#include <iostream>

// 对每个输入数据input每个元素加1并输出给result，grid和block均为一维
__global__ void add(float* input, float* result, int n)
{
    // 获取全局索引
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    // 步长
    int stride = blockDim.x * gridDim.x;
    for (int i = index; i < n; i += stride)
    {
        result[i] = input[i] + 1;
    }
    // z[index] = x[index] + y[index];
}

int main(){


    cudaSetDeviceFlags(cudaDeviceMapHost);

    int N = 1 << 10;
    int size = N*sizeof(int); 
    // Allocate host memory using CUDA allocation calls
    float* h_in  = NULL;
    float* h_out = NULL;
    cudaHostAlloc((void **)&h_in, size, cudaHostAllocMapped);
    cudaHostAlloc((void **)&h_out, size, cudaHostAllocMapped);
    for(int i = 0; i < N; i++){
        h_in[i] = 1;
    }
    // Device arrays
    float *d_out, *d_in;

    // Get device pointer from host memory
    cudaHostGetDevicePointer((void **)&d_in,  (void *) h_in , 0);
    cudaHostGetDevicePointer((void **)&d_out, (void *) h_out, 0);


    // Launch the GPU kernel
    dim3 blockSize(256);
    dim3 gridSize((N + blockSize.x - 1) / blockSize.x);
    add<<<gridSize, blockSize>>>(d_in, d_out, N);


    std::cout<<"output0: "<<h_out[0]<<std::endl;
    std::cout<<"output-1: "<<h_out[N-1]<<std::endl;

    // Continue processing on host using h_out
}
