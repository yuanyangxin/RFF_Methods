import torch.nn as nn
import torch


class AlexNet(nn.Module):
    def __init__(self,num_classes=6):
        super(AlexNet,self).__init__()
        self.features=nn.Sequential(
            nn.Conv2d(3,96,kernel_size=11,stride=4,padding=2),   #(224+2*2-11)/4+1=55
            nn.ReLU(inplace=True),
            nn.MaxPool2d(kernel_size=3,stride=2),   #(55-3)/2+1=27
            nn.Conv2d(96,256,kernel_size=5,stride=1,padding=2), #(27+2*2-5)/1+1=27
            nn.ReLU(inplace=True),
            nn.MaxPool2d(kernel_size=3,stride=2),   #(27-3)/2+1=13
            nn.Conv2d(256,384,kernel_size=3,stride=1,padding=1),    #(13+1*2-3)/1+1=13
            nn.ReLU(inplace=True),
            nn.Conv2d(384,384,kernel_size=3,stride=1,padding=1),    #(13+1*2-3)/1+1=13
            nn.ReLU(inplace=True),
            nn.Conv2d(384,256,kernel_size=3,stride=1,padding=1),    #13+1*2-3)/1+1=13
            nn.ReLU(inplace=True),
            nn.MaxPool2d(kernel_size=3,stride=2),   #(13-3)/2+1=6
        )   #6*6*256=9126

        self.avgpool=nn.AdaptiveAvgPool2d((6,6))
        self.classifier=nn.Sequential(
            nn.Dropout(),
            nn.Linear(256*6*6,4096),
            nn.ReLU(inplace=True),
            nn.Dropout(),
            nn.Linear(4096,4096),
            nn.ReLU(inplace=True),
            nn.Linear(4096,num_classes),
        )

    def forward(self,x):
        x=self.features(x)
        x=self.avgpool(x)
        x=x.view(x.size(0),-1)
        x=self.classifier(x)
        return x


if __main__ == '__name__':
    net=AlexNet()


    input = torch.randn(2, 3, 65, 65)
    out = net(input)
    print(out.shape)
