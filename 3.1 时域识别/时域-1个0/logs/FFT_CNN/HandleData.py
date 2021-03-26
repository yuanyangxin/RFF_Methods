'''
实现把采集的信号（n*1）分为实虚两路信号20 * 160

'''
import os
import scipy.io as sio
import numpy as np
from shutil import copyfile


def load_data(path):
    files = os.listdir(path)
    data = []
    labels = []
    for file in files:
        if file.startswith("A"):
            device = file.split('_')[2]
            y = int(device) - 1
            round = int(file.split('_')[4][0])
            data = sio.loadmat(os.path.join(path, file))
            X = data["Brush_Data_Temp"]
            real = X.real
            imag = X.imag
            
            real = real.transpose()
            imag = imag.transpose()
            
            result = real[0: 160]
            k = 1
            while k < 10:
                a = real[160*k: 160*(k + 1)]
                result = np.vstack((result, a))
                k += 1
            k = 0 
            while k < 10:
                a = imag[160*k: 160*(k + 1)]
                result = np.vstack((result, a))
                k += 1
            print("最后的大小为【20 * 160】？" ,result.shape)
            name ="NO_"+str("A_"+device)+"_"+str(round) +".npy"
            path1 = "./DATA_RESIZE/" + name
            np.save(path1, result)
            
            
load_data("./Data_Set")