#include<iostream>
#include<cuda_runtime.h>
#define BLOCKSIZE 32
// 相同wrap中的线程访问不同bank的内存，无bank conflict
__global__ void kernel1(float *matrix, float *matrixTest, const int row, const int col){

    int x_id = blockDim.x * blockIdx.x + threadIdx.x; // 列坐标
    int y_id = blockDim.y * blockIdx.y + threadIdx.y; // 行坐标
    int index = y_id * col + x_id;

    __shared__ float sData[BLOCKSIZE][BLOCKSIZE];

    if (x_id < col && y_id < row){
        sData[threadIdx.x][threadIdx.y] = matrix[index];
        __syncthreads();
        matrixTest[index] = sData[threadIdx.x][threadIdx.y];
    }
}

int main(){

    int row = 32;
    int col = 32;
    float *matrixTest;
    cudaMalloc((void **)&matrixTest, row*col*sizeof(float));
    cudaMemset(matrixTest, 0, row*col*sizeof(float));
    float *matrix;
    cudaMalloc((void **)&matrix, row*col*sizeof(float));
    cudaMemset(matrix, 1, row*col*sizeof(float));


    dim3 gridSize(1, 1);
    dim3 blockSize(row, col);
    kernel1<<<gridSize, blockSize>>>(matrix, matrixTest, row, col);

    cudaFree(matrixTest);
    cudaFree(matrix);
}
