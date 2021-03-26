import torch
import torch.nn as nn


class LeNet(nn.Module):
    def __init__(self):
        nn.Module.__init__(self)
        self.feature_engineering = nn.Sequential(
            nn.Conv2d(in_channels=3, out_channels=6, kernel_size=5),
            nn.MaxPool2d(kernel_size=2, stride=2),
            nn.Conv2d(in_channels=6, out_channels=16, kernel_size=5),
            nn.MaxPool2d(kernel_size=2, stride=2)
        )
        
        self.classifier = nn.Sequential(
            # kernelSize = 3
            # nn.Linear(in_features=16 * 1 * 1, out_features=120),
            # nn.Linear(in_features=16 * 14 * 14, out_features=120),
            # nn.Linear(in_features=16 * 30 * 30, out_features=120),

            # kernelSize = 5
            # nn.Linear(in_features=16 * 1 * 1, out_features=120),
            # nn.Linear(in_features=16 * 5 * 5, out_features=120),
            # nn.Linear(in_features=16 * 13 * 13, out_features=120),
            nn.Linear(in_features=13456, out_features=1024),
            # nn.Linear(in_features=16 * 61 * 61, out_features=120),
            nn.Linear(in_features=1024, out_features=512),
            nn.Linear(in_features=512, out_features=54)
        )

    def forward(self, x):
        x = self.feature_engineering(x)
        # print(x.shape)
        # kernelSize = 3
        # x = x.view(-1, 16 * 1 * 1)
        # x = x.view(-1, 16 * 14 * 14)
        # x = x.view(-1, 16 * 30 * 30)

        # kernelSize = 5
        # x = x.view(-1, 16 * 1 * 1)
        # x = x.view(-1, 16 * 5 * 5)
        # x = x.view(-1, 16 * 13 * 13)
        x = x.view(-1, 13456)
        # x = x.view(-1, 16 * 61 * 61)
        x = self.classifier(x)
        return x


net = LeNet()
print(list(net.parameters()))