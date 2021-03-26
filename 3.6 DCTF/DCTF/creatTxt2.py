# 选取最高功率的帧绘制的DCTF
import os
import random

numOfBatch = 9
dirPath = f'/home/sansi/datas/dctf_{numOfBatch}'
targetFiles = [file for file in sorted(os.listdir(dirPath)) if file.endswith('_dctf')]
# targetFiles = [file for file in sorted(os.listdir(dirPath)) if file.endswith('_dctf') and int(file[6]) < 5]

pixel = 64
flag = 0
# numOfNormalDCTF = 1
# numOfHighestPowerDCTF = 8
numOfNormalDCTF = 2
numOfHighestPowerDCTF = 16
# numOfNormalDCTF = 10
# numOfHighestPowerDCTF = 80
# numOfNormalDCTF = 20
# numOfHighestPowerDCTF = 160
# numOfNormalDCTF = 5
# numOfHighestPowerDCTF = 40
# numOfNormalDCTF = 2
# numOfHighestPowerDCTF = 20
tupleOfNumOfNormalDCTF = tuple(f'_{i}.png' for i in range(numOfNormalDCTF))
tupleOfNumOfHighestPowerDCTF = tuple(f'_{i}.png' for i in range(numOfHighestPowerDCTF))

if not os.path.exists(f'./{numOfBatch}'):
    os.mkdir(f'./{numOfBatch}')

with open(f'./{numOfBatch}/data_{pixel}_{flag}.txt', 'w') as f:
# with open(f'./test.txt', 'w') as f:
    for targetFile in targetFiles:
        path = os.path.join(dirPath, targetFile, str(pixel), str(flag))
        imgFiles = sorted(os.listdir(path))
        for imgFile in imgFiles:
            if imgFile[12] != '3' and not imgFile.endswith(tupleOfNumOfNormalDCTF):
                continue
            elif imgFile[12] == '3' and not imgFile.endswith(tupleOfNumOfHighestPowerDCTF):
                continue
            elif imgFile[8:13] == 'test3' and not imgFile.endswith(tupleOfNumOfNormalDCTF):
                continue
            label = '0' if imgFile[6] == '0' else str(int(imgFile[6:8]) - 25)
            f.write(f'{os.path.join(dirPath, targetFile, str(pixel), str(flag), imgFile)} {label}\n')


quantile = 0.3
# quantile = 0.25
# 分离训练集与测试集
with open(f'./{numOfBatch}/data_{pixel}_{flag}.txt', 'r') as f:
    lines = f.readlines()
    random.shuffle(lines)
    quantileIndex = int(len(lines) * (1 - quantile))
    with open(f'./{numOfBatch}/data_{pixel}_{flag}_train.txt', 'w') as f1:
        f1.writelines(lines[:quantileIndex])
    with open(f'./{numOfBatch}/data_{pixel}_{flag}_test.txt', 'w') as f2:
        f2.writelines(lines[quantileIndex:])
