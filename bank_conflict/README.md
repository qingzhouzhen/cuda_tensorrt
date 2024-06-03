## 编译
`nvcc -o no_conflict_v1 no_conflict_v1.cu`

## 执行
`nvprof ./no_conflict_v1`

## 参考过的博客
1 英伟达关于bank_conflict的描述：https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html?highlight=bank%20conflict#shared-memory-and-memory-banks
2 某个18年的博客：https://blog.csdn.net/kebu12345678/article/details/82982618
