# 学习CUDA
## start
nvcc hello_cuda.cu -o hello_cuda
./hello_cuda
或者：
nvprof ./hello_cuda
## 环境
如果找不到nvcc
~/.bashrc 添加
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
## 参考过的不过的文件
1 有个介绍cuda教程的文档，收集整理了一些不错的学习资源：https://developer.aliyun.com/article/1235987
2 这篇是翻译英伟达的doc：https://zhuanlan.zhihu.com/p/53773183?spm=a2c6h.12873639.article-detail.13.568c4240JPkHUT

