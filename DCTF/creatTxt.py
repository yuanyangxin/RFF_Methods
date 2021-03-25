
import os
import random

dirPath = '/home/sansi/datas'
targetFiles = [file for file in sorted(os.listdir(dirPath)) if file.endswith('_dctf')]
pixel = 32
flag = 0

with open(f'./data_{pixel}_{flag}.txt', 'w') as f:
    for targetFile in targetFiles:
        path = os.path.join(dirPath, targetFile, str(pixel), str(flag))
        imgFiles = sorted(os.listdir(path))
        for imgFile in imgFiles:
            label = '0' if imgFile[6] == '0' else str(int(imgFile[6:8]) - 25)
            f.write(f'{os.path.join(dirPath, targetFile, str(pixel), str(flag), imgFile)} {label}\n')

quantile = 0.25
# 分离训练集与测试集
with open(f'./data_{pixel}_{flag}.txt', 'r') as f:
    lines = f.readlines()
    random.shuffle(lines)
    quantileIndex = int(len(lines) * (1 - quantile))
    with open(f'./data_{pixel}_{flag}_train.txt', 'w') as f1:
        f1.writelines(lines[:quantileIndex])
    with open(f'./data_{pixel}_{flag}_test.txt', 'w') as f2:
        f2.writelines(lines[quantileIndex:])
  