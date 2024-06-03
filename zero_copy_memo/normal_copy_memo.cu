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

    int N = 1 << 10;
    int size = N*sizeof(int); 
    // Host Arrays
    float* h_in  = new float[N];
    float* h_out = new float[N];
    for(int i = 0; i < N; i++){
        h_in[i] = 1;
    }
    std::cout<<"input0: "<<h_in[0]<<std::endl;
    std::cout<<"input-1: "<<h_in[N-1]<<std::endl;

    // Device arrays
    float *d_out, *d_in;

    // Allocate memory on the device
    cudaMalloc((void **) &d_in,  size);
    cudaMalloc((void **) &d_out, size);

    // Copy array contents of input from the host (CPU) to the device (GPU)
    cudaMemcpy(d_in, h_in, size, cudaMemcpyHostToDevice);

    // Launch the GPU kernel
    dim3 blockSize(256);
    dim3 gridSize((N + blockSize.x - 1) / blockSize.x);
    add<<<gridSize, blockSize>>>(d_in, d_out, N);

    // Copy result back
    cudaMemcpy(h_out, d_out, size, cudaMemcpyDeviceToHost);

    std::cout<<"output0: "<<h_out[0]<<std::endl;
    std::cout<<"output-1: "<<h_out[N-1]<<std::endl;

    // Continue processing on host using h_out
}
