import torch
import torchvision

print(torch.__version__)
print('torchvision version', torchvision.__version__)
print('torchvision path', torchvision.__path__)

x = torch.rand(5, 3)
print(x)

print(torch.cuda.is_available())

torch.zeros(1).cuda()