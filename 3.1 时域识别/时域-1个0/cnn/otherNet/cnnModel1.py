#%%
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

#%%
def default_loader(path):
    return Image.open(path).convert('RGB')


transforms = tv.transforms.Compose([
    # transforms.CenterCrop(64),
    transforms.ToTensor(),
    # transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5)),
])


class MyDataset(Dataset):
    def __init__(self, txt, transform=None, target_transform=None, loader=default_loader):
        # super(MyDataset, self).__init__()
        super().__init__()
        imgs = []
        with open(txt, 'r') as fh:
            for line in fh:
                line = line.strip('\n')
                line = line.rstrip()
                words = line.split()
                imgs.append((words[0], int(words[1])))

        self.imgs = imgs
        self.transform = transform
        self.target_transform = target_transform
        self.loader = loader

    def __getitem__(self, index):
        fn, label = self.imgs[index]
        img = self.loader(fn)
        if self.transform is not None:
            img = self.transform(img)
        return img, label

    def __len__(self):
        return len(self.imgs)


pixel = 32
flag = 0
root = './data'
train_data = MyDataset(txt=f'{root}_{pixel}_{flag}_train.txt', transform=transforms)
test_data = MyDataset(txt=f'{root}_{pixel}_{flag}_test.txt', transform=transforms)
train_loader = DataLoader(dataset=train_data, batch_size=4, shuffle=True, num_workers=2)
test_loader = DataLoader(dataset=test_data, batch_size=4, shuffle=False, num_workers=2)
print('num_of_trainData:', len(train_data))
print('num_of_testData:', len(test_data))

# # # 查看图像
# images, labels = next(iter(train_loader))
# img = tv.utils.make_grid(images)
# img = img.numpy().transpose(1, 2, 0)
# plt.imshow(img)
# plt.show()

class Net(nn.Module):
    def __init__(self):
        super().__init__()
        # super(Net, self).__init__()
        self.conv1 = nn.Conv2d(in_channels=3, out_channels=6, kernel_size=5, stride=2)
        # torch.nn.MaxPool2d(kernel_size=2, stride=2)
        self.pool = nn.MaxPool2d(3, 2)
        self.conv2 = nn.Conv2d(6, 16, 5)
        self.fc1 = nn.Linear(16 * 5 * 5, 120)
        self.fc2 = nn.Linear(120, 84)
        self.fc3 = nn.Linear(84, 6)

    def forward(self, x):
        x = self.pool(F.relu(self.conv1(x)))
        x = self.pool(F.relu(self.conv2(x)))
        # print(x.shape)
        x = x.view(-1, 16 * 5 * 5)
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = self.fc3(x)
        return x


net = Net()
#
# dataiter = iter(train_loader)
# images, labels = dataiter.next()
# outputs = net(images)
# print(outputs)
# print(torch.max(outputs, dim=1))

criterion = nn.CrossEntropyLoss()
optimizer = optim.SGD(params=net.parameters(), lr=0.001, momentum=0.9)

epochs = 20
average_loss_series = []

for epoch in range(epochs):
    running_loss = 0.0
    for i, data in enumerate(train_loader):
        inputs, labels = data
        # inputs, labels = Variable(inputs), Variable(labels)
        optimizer.zero_grad()
        outputs = net(inputs)

        loss = criterion(outputs, labels)
        loss.backward()
        optimizer.step()
        running_loss += loss.item()
        loopNum = 200
        if i % loopNum == loopNum - 1:
            average_loss = running_loss / loopNum
            print('[{0}, {1}] loss: {2}'.format(epoch + 1, i + 1, average_loss))
            average_loss_series.append(average_loss)
            running_loss = 0.0
print('Finished Training!')

#%%
x = range(0, len(average_loss_series))
plt.figure()
plt.plot(x, average_loss_series)
plt.show()

#%%
# 测试结果
# 局部测试
# images, labels = next(iter(test_loader))
# print(labels)
#
# outputs = net(images)
# _, predicted = torch.max(outputs.data, dim=1)
# print(predicted)

#%%
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
print(f'{len(test_loader)*4}张测试集中准确率为： {correct}%')

#%%
# confusion matrix
import itertools
from sklearn.metrics import confusion_matrix

realLabel = list(itertools.chain.from_iterable(realLabel))
predictedLabel = list(itertools.chain.from_iterable(predictedLabel))

cm = confusion_matrix(realLabel, predictedLabel)
print(cm)



