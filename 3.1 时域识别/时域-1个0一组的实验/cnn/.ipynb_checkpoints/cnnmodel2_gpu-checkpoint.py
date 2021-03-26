
#%%
# 此模型训练结果更好。
import matplotlib.pyplot as plt

import torchvision as tv
import torch.nn.functional as F
import torch
import torch.nn as nn
from torch.autograd import Variable
import torchvision.models as models
from torchvision import transforms, utils
from torch.utils.data import Dataset, DataLoader
from PIL import Image
import numpy as np
import torch.optim as optim
import os
import time
import loadData
import LeNetModel

startTime = time.time()
#%%
# 读取数据
transforms = tv.transforms.Compose([
    # transforms.CenterCrop(64),
    # transforms.CenterCrop(128),
    transforms.ToTensor(),
    # transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5)),
])

numOfBatch = 9
pixel = 64
flag = 0
root = f'./{numOfBatch}/data'
batchSize = 2
# train_data = loadData.MyDataset(txt=f'{root}_{pixel}_{flag}_train.txt', transform=transforms)
# test_data = loadData.MyDataset(txt=f'{root}_{pixel}_{flag}_test.txt', transform=transforms)
train_data = loadData.MyDataset(txt=f'files_train.txt', transform=transforms)
test_data = loadData.MyDataset(txt=f'files_test.txt', transform=transforms)
train_loader = DataLoader(dataset=train_data, batch_size=batchSize, shuffle=True, num_workers=2)
test_loader = DataLoader(dataset=test_data, batch_size=batchSize, shuffle=False, num_workers=2)
print('num_of_trainData:', len(train_data))
print('num_of_testData:', len(test_data))

#%%

net = LeNetModel.LeNet()

if torch.cuda.is_available():
    print('cuda!')
    net = net.cuda()

# dataiter = iter(train_loader)
# images, labels = dataiter.next()
# images = images.cuda()
# outputs = net(images)
# print(outputs)
# print(torch.max(outputs, dim=1))

#%%
criterion = nn.CrossEntropyLoss()
optimizer = optim.SGD(params=net.parameters(), lr=0.001, momentum=0.9)
# optimizer = optim.SGD(params=net.parameters(), lr=0.0005, momentum=0.9)

epochs = 50
lossThre = 0.1
average_loss_series = []

for epoch in range(epochs):
    running_loss = 0.0
    running_acc = 0.0

    for i, data in enumerate(train_loader):
        inputs, labels = data
        inputs, labels = inputs.cuda(), labels.cuda()
        # inputs, labels = Variable(inputs), Variable(labels)
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
    # 为 loss 设定一个阈值
    # if average_loss < lossThre:
    #     break



x = range(0, len(average_loss_series))
plt.figure()
plt.plot(x, average_loss_series)
plt.show()
#%%
# 在测试集上测试


def correct_rate(net, testloader):
    correct = 0
    total = 0
    realLabel = []
    predictedLabel = []
    for data in testloader:
        inputs, labels = data
        inputs, labels = inputs.cuda(), labels.cuda()
        realLabel.append([int(label) for label in labels])
        outputs = net(inputs)
        _, predicted = torch.max(outputs.data, dim=1)
        predictedLabel.append([int(label) for label in predicted])
        total += labels.size(0)
        correct += (predicted == labels).sum()
    return 100 * float(correct) / float(total), realLabel, predictedLabel


correct, realLabel, predictedLabel = correct_rate(net, test_loader)
# print(f'{len(test_loader) * 4}张测试集中准确率为： {correct}%')
print(f'{len(test_data)}张测试集中准确率为： {correct}%')

#%%
import itertools
from sklearn.metrics import confusion_matrix

realLabel = list(itertools.chain.from_iterable(realLabel))
predictedLabel = list(itertools.chain.from_iterable(predictedLabel))

cm = confusion_matrix(realLabel, predictedLabel)
print(cm)


print(f'the running time is {time.time() - startTime}s')
# #%%
torch.save(net.state_dict(), f'./{numOfBatch}/model_{pixel}_{flag}.pkl')