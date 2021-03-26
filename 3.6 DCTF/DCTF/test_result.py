
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
import LeNetModel
import loadData
import itertools
from sklearn.metrics import confusion_matrix

path = './5/model_32_0.pkl'
net = LeNetModel.LeNet()
net.load_state_dict(torch.load(path))
net = net.cuda()

transforms = tv.transforms.Compose([
    # transforms.CenterCrop(64),
    # transforms.CenterCrop(128),
    transforms.ToTensor(),
    # transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5)),
])

numOfBatch = 5
dirPath = f'./{numOfBatch}/test_result'
targetFiles = sorted(os.listdir(dirPath))

erroCounter = 0
realLabels = []
predictedLabels = []
for targetFile in targetFiles:

    batchSize = 2
    test_data = loadData.MyDataset(txt=f'{dirPath}/{targetFile}', transform=transforms)
    test_loader = DataLoader(dataset=test_data, batch_size=batchSize, shuffle=False, num_workers=2)

    correct = 0
    total = 0
    realLabel = []
    predictedLabel = []

    for data in test_loader:
        inputs, labels = data
        inputs, labels = inputs.cuda(), labels.cuda()
        realLabel.append([int(label) for label in labels])
        outputs = net(inputs)
        _, predicted = torch.max(outputs.data, dim=1)
        predictedLabel.append([int(label) for label in predicted])
        total += labels.size(0)
        correct += (predicted == labels).sum()
    
    realLabel = realLabel[0][0]
    # print(torch.argmax(torch.bincount(predictedLabel)))
    predictedLabel = list(itertools.chain.from_iterable(predictedLabel))
    predictedLabel = max(predictedLabel, key=predictedLabel.count)
    realLabels.append(realLabel)
    predictedLabels.append(predictedLabel)
    if realLabel != predictedLabel:
        erroCounter += 1


correct = 1 - erroCounter / len(targetFiles)
print(correct)

cm = confusion_matrix(realLabels, predictedLabels)
print(cm)