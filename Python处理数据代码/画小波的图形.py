import os
import scipy.io as sio
import numpy as np
import matplotlib.pyplot as plt
import pywt
import changeSize

file = "F:/东大毕设/data/FFT/30dB/FFT30dB_Device_1_1.mat"
data = sio.loadmat(file)

X = data["y1"]
X = changeSize.flatten(X)

coeffs = pywt.dwt(X, 'haar')
cA, cD = coeffs

plt.figure()
plt.plot(X)
plt.show()

plt.figure()
plt.plot(cA)
plt.show()

plt.figure()
plt.plot(cD)
plt.show()