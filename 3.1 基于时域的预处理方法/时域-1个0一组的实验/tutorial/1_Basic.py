from __future__ import print_function
import torch

x = torch.tensor([5.5, 3])
# print(x)

x = x.new_ones(5,3,dtype = torch.double)
# print(x)

x = torch.rand_like(x, dtype=torch.float)
# print(x.size())

x = torch.randn(4, 4)
y = x.view(-1, 16)
z = x.view(-1,8)
# print(x, y, z)
# print(x.size(), y.size(), z.size())

x = torch.randn(1)
# print(x)
# print(x.item())

a = torch.ones(5)
# print(a)

b = a.numpy()
# print(b)

a.add_(1)
# print(a)
# print(b)


import numpy as np
a = np.ones(5)
b = torch.from_numpy(a)
np.add(a, 1, out = a)
# print(a)
# print(b)

if torch.cuda.is_available():
    device = torch.device("cuda")  # a CUDA device object
    y = torch.ones_like(x, device=device)  # directly create a tensor on GPU
    x = x.to(device)  # or just use strings ``.to("cuda")``
    z = x + y
    print(z)
    print(z.to("cpu", torch.double))