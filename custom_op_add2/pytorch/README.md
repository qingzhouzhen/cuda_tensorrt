L=s, L先对sum函数求导，sum是1024个参数的和，所以和对他们求导就是1024个1，[1,....1]
上一步得到的求导的结果就是自定义算子backward输入
s = a2 + b2
s 对 a2, b2求导为1，所以链式求导，将输入的1和求导得到的1相乘，返回的是梯度，所以返回值的shape要和所有输入shape相等
再对a平方和b平方求导，
```
(Pdb) model.a
Parameter containing:
tensor([ 0.1061,  0.3093, -0.7090,  ..., -1.2302,  1.0178,  0.8503],
       device='cuda:0', requires_grad=True)
(Pdb) model.a.grad
tensor([ 0.2121,  0.6186, -1.4179,  ..., -2.4604,  2.0357,  1.7006],
       device='cuda:0')
(Pdb) 0.1061 - (0.2121*0.01)
0.103979
(Pdb) n
> /rtx/hanqing/project/cuda_tensorrt/custom_op_add2/pytorch/train.py(81)<module>()
-> if epoch % 25 == 0:
(Pdb) model.a
Parameter containing:
tensor([ 0.1039,  0.3031, -0.6948,  ..., -1.2056,  0.9975,  0.8333],
       device='cuda:0', requires_grad=True)
(Pdb)
```
从上面调试的结果也是符合预期的
参数a=0.1061, 根据链式求导，a的导数为1x1x2(0.1061)=0.2121, 执行backward得到梯度为0.2121，a值减去lr*grad=0.1039, 完全符合预期

