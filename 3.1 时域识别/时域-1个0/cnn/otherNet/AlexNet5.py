import torch
import torch.nn as nn
import torch.nn.functional as F

import torch
import torch.nn as nn

class AlexNet(torch.nn.Module):
    def __init__(self):
        super(AlexNet, self).__init__()
        # 227*227*3
        self.conv1 = torch.nn.Sequential(
            torch.nn.Conv2d(in_channels=3, out_channels=96, kernel_size=11, stride=4, padding=0),
            # in_channels, out_channels, kernel_size(int/tuple), stride ,padding
            # (227-11)/4+1=55,  55*55*96
            torch.nn.ReLU(),
            torch.nn.MaxPool2d(kernel_size=3, stride=2, padding=0)
            # kernel_size, stride, padding
            # (55-3)/2+1=27,  27*27*96
        )

        # 27*27*96
        self.conv2 = torch.nn.Sequential(
            torch.nn.Conv2d(in_channels=96, out_channels=256, kernel_size=5, stride=1, padding=2),
            # （27-5 + 2*2）/ 1 + 1 = 27, 27*27*256
            torch.nn.ReLU(),
            torch.nn.MaxPool2d(kernel_size=3, stride=2, padding=0)
            # (27 - 3 )/2 + 1 = 13, 13*13*256
        )

        # 13*13*256
        self.conv3 = torch.nn.Sequential(
            torch.nn.Conv2d(in_channels=256, out_channels=384, kernel_size=3, stride=1, padding=1),
            # (13 - 3 +1*2)/1 + 1 = 13 , 13*13*384
            torch.nn.ReLU()
        )

        # 13*13*384
        self.conv4 = torch.nn.Sequential(
            torch.nn.Conv2d(in_channels=384, out_channels=384, kernel_size=3, stride=1, padding=1),
            # (13 - 3 + 1*2)/1 +1 = 13, 13*13*384
            torch.nn.ReLU()
        )

        # 13*13*384
        self.conv5 = torch.nn.Sequential(
            torch.nn.Conv2d(in_channels=384, out_channels=256, kernel_size=3, stride=1, padding=1),
            # (13 - 3 + 1*2) +1 = 13, 13*13*256
            torch.nn.ReLU(),
            torch.nn.MaxPool2d(kernel_size=3, stride=2, padding=0)
            # (13 - 3 )/2 +1 =6, 6*6*256
        )

        # 6*6*256 = 9216
        self.dense = torch.nn.Sequential(
            torch.nn.Linear(256*2*2, 4096),
            torch.nn.ReLU(),
            torch.nn.Dropout(0.5),
            torch.nn.Linear(4096, 4096),
            torch.nn.ReLU(),
            torch.nn.Dropout(0.5),
            torch.nn.Linear(4096, 6)
            # 因为只有两类
        )

    def forward(self, x):
        conv1_out = self.conv1(x)
        conv2_out = self.conv2(conv1_out)
        conv3_out = self.conv3(conv2_out)
        conv4_out = self.conv4(conv3_out)
        conv5_out = self.conv5(conv4_out)
        # print(conv5_out.shape)
        res = conv5_out.view(conv5_out.size(0), -1)
        out = self.dense(res)
        return out

if __name__ == "__main__":
    
    net = AlexNet()
    # input = torch.randn(2, 3, 227, 227)
    input = torch.randn(2, 3, 129, 129)
    out = net(input)
    print(out.shape)