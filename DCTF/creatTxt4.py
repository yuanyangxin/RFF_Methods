# 选取最高功率的帧绘制的DCTF
# 以相同参数的GSM信号的DCTF做训练，其他不同GSM参数如频点训练序列的信号的DCTF做测试
import os
import random

numOfBatch = 9
dirPath = f'/home/sansi/datas/dctf_{numOfBatch}'
# targetFiles = [file for file in sorted(os.listdir(dirPath)) if file.endswith('_dctf')]
targetFilesForTraining = [file for file in sorted(os.listdir(dirPath)) if file.endswith('_dctf') and int(file[6]) < 5]
targetFilesForTesting = [file for file in sorted(os.listdir(dirPath)) if file.endswith('_dctf') and int(file[6]) == 8]

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

with open(f'./{numOfBatch}/data_{pixel}_{flag}_train.txt', 'w') as f:
# with open(f'./test.txt', 'w') as f:
    for targetFile in targetFilesForTraining:
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

with open(f'./{numOfBatch}/data_{pixel}_{flag}_test.txt', 'w') as f:
# with open(f'./test.txt', 'w') as f:
    for targetFile in targetFilesForTesting:
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

