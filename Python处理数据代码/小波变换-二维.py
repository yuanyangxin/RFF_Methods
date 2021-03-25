import os
import scipy.io as sio
import numpy as np
import matplotlib.pyplot as plt
import pywt
import changeSize

path = "F:/东大毕设/data/FFT/30dB/"

file = "FFT30dB_Device_1_1.mat"
files = os.listdir(path)
for file in files:
    device = file.split('_')[2]
    y = int(device) - 1
    round = int(file.split('_')[3][0:-4])
    print(device, round)
    data = sio.loadmat(os.path.join(path, file))
    # print(data)
    X = data["y1"]
    X = changeSize.flatten(X)
    # print(X)

    coeffs = pywt.dwt(X, 'haar')
    cA, cD = coeffs

    LowFrequencyFile = "F:\\东大毕设\\data\\FFT\\小波\\haar\\低频\\"
    HighFrequencyFile = "F:\\东大毕设\\data\\FFT\\小波\\haar\\高频\\"


    if round < 20:
        LowFrequencyFileName = LowFrequencyFile + "train\\"+ str(device) +"\\" + str("A_" + device) + "_" + str(round) + ".npy"
        HighFrequencyFileName = HighFrequencyFile + "train\\" + str(device) + "\\" + str("A_" + device) + "_" + str(round) + ".npy"
    else:
        LowFrequencyFileName = LowFrequencyFile + "val\\" + str(device) + "\\" + str("A_" + device) + "_" + str(round) + ".npy"
        HighFrequencyFileName = HighFrequencyFile + "val\\" + str(device) + "\\" + str("A_" + device) + "_" + str(round) + ".npy"
    np.save(LowFrequencyFileName, cA)
    np.save(HighFrequencyFileName, cD)
