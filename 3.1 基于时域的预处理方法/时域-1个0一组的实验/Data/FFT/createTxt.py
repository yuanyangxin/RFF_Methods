import os
import random

dir_path = "./DATA_RESIZE"

targetFiles = sorted(os.listdir(dir_path))
flag = 0
print("targetFiles:=+++", targetFiles)

# 按照[文件名 标签名]的格式写入txt文件
with open(f'./files.txt', 'w') as f:
    for targetFile in targetFiles:
        # print(targetFile)
        label = targetFile.split("_")[2]
        f.write(f'{os.path.join(dir_path, targetFile)} {label}\n')

# 分离训练集和测试集
with open(f'./files.txt', 'r') as f, open(f'./files_train.txt', 'w') as f_train, open(f'./files_test.txt',
                                                                                      'w') as f_test:
    lines = f.readlines()
    for line in lines:
        round = int(line.split(" ")[0].split("/")[2].split("_")[3][0])
        if round in [1, 5]:
            f_train.write(line)
        else:
            f_test.write(line)
