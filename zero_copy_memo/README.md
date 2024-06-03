

## 结果
正常cuda拷贝的结果
```
 GPU activities:   47.33%  3.6800us         1  3.6800us  3.6800us  3.6800us  add(float*, float*, int)
                   27.57%  2.1440us         1  2.1440us  2.1440us  2.1440us  [CUDA memcpy DtoH]
                   25.10%  1.9520us         1  1.9520us  1.9520us  1.9520us  [CUDA memcpy HtoD]
      API calls:   97.10%  205.87ms         2  102.94ms  4.4750us  205.87ms  cudaMalloc
                    2.60%  5.5202ms       808  6.8310us     145ns  329.48us  cuDeviceGetAttribute
                    0.24%  507.79us         8  63.474us  59.157us  86.660us  cuDeviceGetName
                    0.02%  51.492us         2  25.746us  24.563us  26.929us  cudaMemcpy
                    0.01%  29.504us         1  29.504us  29.504us  29.504us  cudaLaunchKernel
                    0.01%  20.847us         8  2.6050us  1.1980us  8.7910us  cuDeviceGetPCIBusId
                    0.00%  8.5620us         8  1.0700us     340ns  5.4070us  cuDeviceTotalMem
                    0.00%  4.8900us        16     305ns     147ns  1.1340us  cuDeviceGet
                    0.00%  2.1770us         8     272ns     185ns     411ns  cuDeviceGetUuid
                    0.00%  1.1300us         3     376ns     187ns     620ns  cuDeviceGetCount
```
zero拷贝的结果
```
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:  100.00%  7.0400us         1  7.0400us  7.0400us  7.0400us  add(float*, float*, int)
      API calls:   96.43%  192.13ms         1  192.13ms  192.13ms  192.13ms  cudaSetDeviceFlags
                    2.60%  5.1719ms       808  6.4000us     140ns  305.61us  cuDeviceGetAttribute
                    0.68%  1.3496ms         2  674.82us  6.0220us  1.3436ms  cudaHostAlloc
                    0.25%  505.79us         8  63.223us  58.265us  85.569us  cuDeviceGetName
                    0.02%  40.993us         1  40.993us  40.993us  40.993us  cudaLaunchKernel
                    0.01%  19.523us         8  2.4400us  1.1390us  8.5080us  cuDeviceGetPCIBusId
                    0.01%  10.706us        16     669ns     143ns  7.5630us  cuDeviceGet
                    0.00%  2.6700us         8     333ns     305ns     388ns  cuDeviceTotalMem
                    0.00%  2.3550us         2  1.1770us     495ns  1.8600us  cudaHostGetDevicePointer
                    0.00%  1.6670us         8     208ns     174ns     404ns  cuDeviceGetUuid
                    0.00%  1.1380us         3     379ns     172ns     652ns  cuDeviceGetCount
```
没了拷贝时间，但是核函数的执行时间边长了一倍
