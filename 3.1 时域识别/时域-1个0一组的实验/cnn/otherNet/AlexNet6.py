import torch
import torch.nn as nn
 
 
class AlexNet(nn.Module):   #定义网络，推荐使用Sequential，结构清晰
    def  __init__(self):
        super(AlexNet,self).__init__()
        self.conv1 = torch.nn.Sequential(   #input_size = 227*227*3
            torch.nn.Conv2d(in_channels=3,out_channels=96,kernel_size=11,stride=4,padding=0),
            torch.nn.ReLU(),
            torch.nn.MaxPool2d(kernel_size=3, stride=2) #output_size = 27*27*96
        )
        self.conv2 = torch.nn.Sequential(   #input_size = 27*27*96
            torch.nn.Conv2d(96, 256, 5, 1, 2),
            torch.nn.ReLU(),
            torch.nn.MaxPool2d(3, 2)    #output_size = 13*13*256
        )
        self.conv3 = torch.nn.Sequential(   #input_size = 13*13*256
            torch.nn.Conv2d(256, 384, 3, 1, 1),
            torch.nn.ReLU(),    #output_size = 13*13*384
        )
        self.conv4 = torch.nn.Sequential(   #input_size = 13*13*384
            torch.nn.Conv2d(384, 384, 3, 1, 1),
            torch.nn.ReLU(),    #output_size = 13*13*384
        )
        self.conv5 = torch.nn.Sequential(   #input_size = 13*13*384
            torch.nn.Conv2d(384, 256, 3, 1, 1),
            torch.nn.ReLU(),
            torch.nn.MaxPool2d(3, 2)    #output_size = 6*6*256
        )
 
        #网络前向传播过程
        self.dense = torch.nn.Sequential(
            torch.nn.Linear(256*2*2, 4096),
            torch.nn.ReLU(),
            torch.nn.Dropout(0.5),
            torch.nn.Linear(4096, 4096),
            torch.nn.ReLU(),
            torch.nn.Dropout(0.5),
            torch.nn.Linear(4096, 6)
        )
 
    def forward(self, x):   #正向传播过程
        conv1_out = self.conv1(x)
        conv2_out = self.conv2(conv1_out)
        conv3_out = self.conv3(conv2_out)
        conv4_out = self.conv4(conv3_out)
        conv5_out = self.conv5(conv4_out)
        res = conv5_out.view(conv5_out.size(0), -1)
        out = self.dense(res)
        return out


if __name__ == "__main__":
    net=AlexNet()
    
    # input = torch.randn(2, 3, 227, 227)
    input = torch.randn(2, 3, 129, 129)
    out = net(input)
    print(out.shape)