#include<iostream>
#include<cuda_runtime.h>

__global__ void computeImageMean(const unsigned *image, const unsigned width, const unsigned height, float *result){

    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    int imageIdx = row * width + col;
    atomicAdd(result, static_cast<float>(image[imageIdx]));
}

int main(){
    
    int width = 10;
    int height = 10;
    unsigned int *image = new unsigned int[height * width];
    for (int i = 0; i < height*width; i++){
        image[i] = i;
    }
    unsigned *image_cuda;
    cudaMalloc((void **)&image_cuda, height*width*sizeof(unsigned int));
    cudaMemcpy(image_cuda, image, height*width*sizeof(unsigned int), cudaMemcpyHostToDevice);

    float *result_cuda;
    cudaMalloc((void **)&result_cuda, sizeof(float));
    cudaMemset(result_cuda, 0, sizeof(float));

    dim3 gridSize(2, 2);
    dim3 blockSize(width/gridSize.x, height/gridSize.y);
    computeImageMean<<<gridSize, blockSize>>>(image_cuda, width, height, result_cuda);


    float result = 0;
    cudaMemcpy(&result, result_cuda, sizeof(float), cudaMemcpyDeviceToHost);
    result = result/static_cast<float>(width*height);

    std::cout<<"result: "<<result<<std::endl;

    delete[] image;
    cudaFree(image_cuda);
    cudaFree(result_cuda);
}