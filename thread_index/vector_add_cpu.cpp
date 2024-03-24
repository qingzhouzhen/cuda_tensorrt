#include<iostream>
int main(){
    int N = 1 << 20;
    int nBytes = N * sizeof(float);
    float *x, *y, *z;
    x = (float *) malloc(nBytes);
    y = (float *) malloc(nBytes);
    z = (float *) malloc(nBytes);
    for (int i = 0; i < N; i++){
        x[i] = 10.0;
        y[i] = 20.0;
    }

    clock_t startTime = clock();
    for (int i = 0; i < N; i++){
        z[i] = x[i] + y[i];
    }
    clock_t endTime = clock();
    double elapsed = static_cast<double>(endTime - startTime) / CLOCKS_PER_SEC;
    std::cout<<"++++++++++"<<elapsed<<std::endl;
}
