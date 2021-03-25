import os
import scipy.io as sio
import numpy as np
import matplotlib.pyplot as plt
import pywt
import changeSize

path = "F:/东大毕设/data/FFT/30dB/"

# file = "FFT30dB_Device_1_1.mat"
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

    if device == 1 and round == 1:
        plt.plot(cA)
        plt.plot(cD)

    LowFrequencyFile = "F:\\东大毕设\\data\\FFT\\小波\\haar\\低频\\"
    HighFrequencyFile = "F:\\东大毕设\\data\\FFT\\小波\\haar\\高频\\"


    LowFrequencyFileName = LowFrequencyFile + "\\"+ "Haar_Device_" + str(device)   + "_" + str(round) + ".npy"
    HighFrequencyFileName = HighFrequencyFile + "\\"+ "Haar_Device_" + str(device)   + "_" + str(round) + ".npy"

    np.save(LowFrequencyFileName, cA)
    np.save(HighFrequencyFileName, cD)
