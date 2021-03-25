# 此模型训练结果更好。
import matplotlib.pyplot as plt

import torch.nn.functional as F
import torch
import torch.nn as nn
from torch.autograd import Variable
import torchvision.models as models
# from torchvision import transforms, utils
from torch.utils.data import Dataset, DataLoader
# from PIL import Image
# import numpy as np
import torch.optim as optim
# import os
import time

import loadData
startTime = time.time()
#%%
# 读取数据


numOfBatch = 9
pixel = 64
flag = 0
root = f'./{numOfBatch}/data'
batchSize = 2
train_data = loadData.MyDataset(txt=f'files_train.txt')
test_data = loadData.MyDataset(txt=f'files_test.txt')
train_loader = DataLoader(dataset=train_data, batch_size=batchSize, shuffle=True, num_workers=2)
test_loader = DataLoader(dataset=test_data, batch_size=batchSize, shuffle=False, num_workers=2)
print('num_of_trainData:', len(train_data))
print('num_of_testData:', len(test_data))

#%%
kernelSize = 3

class LeNet(nn.Module):
    def __init__(self):
        nn.Module.__init__(self)
        self.feature_engineering = nn.Sequential(
            nn.Conv2d(in_channels=3, out_channels=6, kernel_size=kernelSize),
            nn.MaxPool2d(kernel_size=2, stride=2),
            nn.Conv2d(in_channels=6, out_channels=16, kernel_size=kernelSize),
            nn.MaxPool2d(kernel_size=2, stride=2)
        )

        self.classifier = nn.Sequential(
            # nn.Linear(in_features=16 * 5 * 5, out_features=120),
            # nn.Linear(in_features=16 * 29 * 29, out_features=120),
            nn.Linear(in_features=16 * 61 * 61, out_features=120),
            nn.Linear(in_features=120, out_features=84),
            nn.Linear(in_features=84, out_features=6)
        )

    def forward(self, x):
        x = self.feature_engineering(x)
        print(x.shape)
        # x = x.view(-1, 16 * 5 * 5)
        # x = x.view(-1, 16 * 29 * 29)
        x = x.view(-1, 16 * 61 * 61)
        x = self.classifier(x)
        return x


net = LeNet()

# dataiter = iter(train_loader)
# images, labels = dataiter.next()
# outputs = net(images)
# print(outputs)
# print(torch.max(outputs, dim=1))

#%%
criterion = nn.CrossEntropyLoss()
optimizer = optim.SGD(params=net.parameters(), lr=0.001, momentum=0.9)

epochs = 20
average_loss_series = []

for epoch in range(epochs):
    running_loss = 0.0
    running_acc = 0.0

    for i, data in enumerate(train_loader):
        inputs, labels = data
        optimizer.zero_grad()
        outputs = net(inputs)
        _, predicted = torch.max(outputs.data, dim=1)
        total = labels.size(0)
        # assert total == batchSize
        running_correct = (predicted == labels).sum()
        running_acc += running_correct
        loss = criterion(outputs, labels)
        running_loss += loss.item()
        loss.backward()
        optimizer.step()

        # 每loopNum个batch打印一次训练状态
        loopNum = 400
        if i % loopNum == loopNum - 1:
            average_loss = running_loss / loopNum
            print('[{0}, {1}] loss: {2}'.format(epoch + 1, i + 1, average_loss))
            running_acc = running_acc.float()
            average_acc = running_acc / loopNum / total
            print('[{0}, {1}] acc: {2}'.format(epoch + 1, i + 1, average_acc))
            average_loss_series.append(average_loss)
            running_loss = 0.0
            running_acc = 0.0



x = range(0, len(average_loss_series))
plt.figure()
plt.plot(x, average_loss_series)
plt.show()
#%%
# 在测试集上测试
realLabel = []
predictedLabel = []

def correct_rate(net, testloader):
    correct = 0
    total = 0

    for data in testloader:
        images, labels = data
        realLabel.append([int(label) for label in labels])
        outputs = net(images)
        _, predicted = torch.max(outputs.data, dim=1)
        predictedLabel.append([int(label) for label in predicted])
        total += labels.size(0)
        correct += (predicted == labels).sum()

    return 100 * correct / total


correct = correct_rate(net, test_loader)
print(f'{len(test_loader) * 4}张测试集中准确率为： {correct}%')

#%%
import itertools
from sklearn.metrics import confusion_matrix

realLabel = list(itertools.chain.from_iterable(realLabel))
predictedLabel = list(itertools.chain.from_iterable(predictedLabel))

cm = confusion_matrix(realLabel, predictedLabel)
print(cm)

print('the running time is', time.time() - startTime)
#%%
torch.save(net, f'./{numOfBatch}/model_{pixel}_{flag}.pkl')