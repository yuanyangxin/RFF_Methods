
"""
验证网络对具体设备的识别情况，生成训练数据文件。
"""
#%%
# 选取最高功率的帧绘制的DCTF
import os
import random

numOfBatch = 5
dirPath = f'/home/sansi/datas/dctf_{numOfBatch}'
targetFiles = [file for file in sorted(os.listdir(dirPath)) if file.endswith('_dctf')]
pixel = 32
flag = 0
numOfNormalDCTF = 5
numOfHighestPowerDCTF = 40
# numOfNormalDCTF = 2
# numOfHighestPowerDCTF = 20
tupleOfNumOfNormalDCTF = tuple(f'_{i}.png' for i in range(numOfNormalDCTF))
tupleOfNumOfHighestPowerDCTF = tuple(f'_{i}.png' for i in range(numOfHighestPowerDCTF))
quantile = 0.2


if not os.path.exists(f'./{numOfBatch}'):
    os.mkdir(f'./{numOfBatch}')

# if os.path.exists(f'./{numOfBatch}/data_{pixel}_{flag}.txt'):
#     os.remove(f'./{numOfBatch}/data_{pixel}_{flag}.txt')
# if os.path.exists(f'./{numOfBatch}/data_{pixel}_{flag}_train.txt'):
#     os.remove(f'./{numOfBatch}/data_{pixel}_{flag}_train.txt')
# if os.path.exists(f'./{numOfBatch}/data_{pixel}_{flag}_test.txt'):
#     os.remove(f'./{numOfBatch}/data_{pixel}_{flag}_test.txt')

for targetFile in targetFiles:
    path = os.path.join(dirPath, targetFile, str(pixel), str(flag))
    imgFiles = sorted(os.listdir(path))
    imgClass = []
    imgClasses = []

    for counter, imgFile in enumerate(imgFiles):
        if (counter + 1) == len(imgFiles):
            imgClass.append(imgFile)
            imgClasses.append(imgClass)
            imgClass = []
            break
        if imgFile[6:8] == imgFiles[counter + 1][6:8]:
            imgClass.append(imgFile)
        elif imgFile[6:8] != imgFiles[counter + 1][6:8]:
            imgClass.append(imgFile)
            imgClasses.append(imgClass)
            imgClass = []

    for oneimgClass in imgClasses:
        imgClassAfterFilter = []
        for imgFile in oneimgClass:

            if imgFile[12] != '3' and not imgFile.endswith(tupleOfNumOfNormalDCTF):
                continue
            elif imgFile[12] == '3' and not imgFile.endswith(tupleOfNumOfHighestPowerDCTF):
                continue
            elif imgFile[8:13] == 'test3' and not imgFile.endswith(tupleOfNumOfNormalDCTF):
                continue
            imgClassAfterFilter.append(imgFile)
            label = '0' if imgFile[6] == '0' else str(int(imgFile[6:8]) - 25)
            text = f'{os.path.join(dirPath, targetFile, str(pixel), str(flag), imgFile)} {label}\n'
            if not os.path.exists(f'./{numOfBatch}/test_result'):
                os.mkdir(f'./{numOfBatch}/test_result')
            with open(f'./{numOfBatch}/test_result/{targetFile[6]}{imgFile[:-9]}.txt', 'a') as f:
                f.write(text)

