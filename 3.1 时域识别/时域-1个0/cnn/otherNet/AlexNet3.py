x.size(0)import torch
import torch.nn as nn
import torch.nn.functional as F

import torch
import torch.nn as nn
 
 
class AlexNet(nn.Module):
    def __init__(self):
        super(AlexNet,self).__init__()
        self.conv1=nn.Sequential(
                nn.Conv2d(in_channels=3,out_channels=64,kernel_size=11,stride=4,padding=2),#in 3*223*223   out 64*55*55
                nn.ReLU(inplace=True),
                nn.MaxPool2d(kernel_size=3,stride=2),     
                )
        self.conv2=nn.Sequential(
                nn.Conv2d(in_channels=64,out_channels=192,kernel_size=5,padding=2),
                nn.ReLU(inplace=True),
                nn.MaxPool2d(kernel_size=3,stride=2), 
                )
        self.conv3=nn.Sequential(
                nn.Conv2d(in_channels=192,out_channels=384,kernel_size=3,padding=1),
                nn.ReLU(inplace=True),
                )
        self.conv4=nn.Sequential(
                nn.Conv2d(in_channels=384,out_channels=256,kernel_size=3,padding=1),
                nn.ReLU(inplace=True),
                )
        self.conv5=nn.Sequential(
                nn.Conv2d(in_channels=256,out_channels=256,kernel_size=3,padding=1),
                nn.ReLU(inplace=True),
                nn.MaxPool2d(kernel_size=3,stride=2)
                )
        self.classifier=nn.Sequential(
                nn.Dropout(),
                nn.Linear(256*1*1,4096),
                nn.ReLU(inplace=True),
                nn.Dropout(),
                nn.Linear(4096,4096),
                nn.ReLU(inplace=True),
                nn.Linear(4096,6)
                )
     
    def forward(self,x):
        x=self.conv1(x)
        x=self.conv2(x)
        x=self.conv3(x)
        x=self.conv4(x)
        x=self.conv5(x)
        #x=x.view(x.size(0),-1)
        x=x.view(x.size(0),-1)
        output=self.classifier(x)
        return output
 
if __name__ == "__main__":

    net=AlexNet()

    # input = torch.randn(2, 3, 227, 227)
    input = torch.randn(2, 3, 65, 65)
    out = net(input)
    print(out.shape)
