#%%
import torch
import torch.nn as nn
import torch.optim as optim
import torchvision as tv
import matplotlib.pyplot as plt
from PIL import Image
from torch.utils.data import Dataset, DataLoader
from torchvision import transforms

import AlexNet
import AlexNet2
import AlexNet3
import AlexNet4
import AlexNet5
import AlexNet6
#%% 读取数据
def default_loader(path):
    return Image.open(path).convert('RGB')


transforms = tv.transforms.Compose([
    # transforms.CenterCrop(64),
    # transforms.CenterCrop(128),
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


numOfBatch = 0
pixel = 32
flag = 0
root = f'./{numOfBatch}/data'
batchSize = 2
train_data = MyDataset(txt=f'{root}_{pixel}_{flag}_train.txt', transform=transforms)
test_data = MyDataset(txt=f'{root}_{pixel}_{flag}_test.txt', transform=transforms)
train_loader = DataLoader(dataset=train_data, batch_size=batchSize, shuffle=True, num_workers=2)
test_loader = DataLoader(dataset=test_data, batch_size=batchSize, shuffle=False, num_workers=2)
print('num_of_trainData:', len(train_data))
print('num_of_testData:', len(test_data))

net = AlexNet.AlexNet()

#%%


criterion = nn.CrossEntropyLoss()
optimizer = optim.SGD(params=net.parameters(), lr=0.001, momentum=0.9)
# optimizer = optim.Adam(_AlexNet.parameters(),lr=LR)

epochs = 20
average_loss_series = []

for epoch in range(epochs):
    running_loss = 0.0

    for i, data in enumerate(train_loader):
        inputs, labels = data
        optimizer.zero_grad()
        outputs = net(inputs)
        loss = criterion(outputs, labels)
        loss.backward()
        optimizer.step()
        running_loss += loss.item()
        # 每loopNum个batch打印一次训练状态
        loopNum = 400
        if i % loopNum == loopNum - 1:
            average_loss = running_loss / loopNum
            print('[{0}, {1}] loss: {2}'.format(epoch + 1, i + 1, average_loss))
            average_loss_series.append(average_loss)
            running_loss = 0.0

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