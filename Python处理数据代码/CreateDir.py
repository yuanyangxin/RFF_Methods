def mkdir(path):
    # 引入模块
    import os
    # 去除首位空格
    path = path.strip()
    # 去除尾部 \ 符号
    path = path.rstrip("\\")
    isExists = os.path.exists(path)

    # 判断结果
    if not isExists:
        os.makedirs(path)
        return True
    else:
        return False

path = "F:\\东大毕设\\data\\FFT\\图片\\30dB\\train\\"
path1 = "F:\\东大毕设\\data\\FFT\\图片\\30dB\\val\\"
for i in range(1, 55):
    dir = path + str(i)
    dir1 = path1 + str(i)
    print(dir)
    mkdir(dir)
    mkdir(dir1)