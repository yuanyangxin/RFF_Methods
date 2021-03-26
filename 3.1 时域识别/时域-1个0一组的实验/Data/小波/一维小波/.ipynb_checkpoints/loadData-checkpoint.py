'''
从txt文件中导入数据，作为神经网络的输入数据
'''

from torch.utils.data import Dataset
import numpy as np


def default_loader(path):
#     a = np.load(path)
#     a.reshape()
#     print("--------------",np.load(path))
    a = np.load(path)
#     print("---------")
#     print(a.shape)
#     print(a.shape[0])
#     print(a.shape[1])
#     print("---------")
    b = a.reshape((1, len(a), 1))
#     print(b.shape)
    return b

class MyDataset(Dataset):
    def __init__(self, txt, transform=None, loader=default_loader):
        # super(MyDataset, self).__init__()
        super().__init__()
        self.files = []
        with open(txt, 'r') as fh:
            for line in fh:
                line = line.strip('\n')
                line = line.rstrip()
                words = line.split()
                self.files.append((words[0], int(words[1])))
        # self.files = files
        self.transform = transform
        self.loader = loader



    def __getitem__(self, index):
        fn, label = self.files[index]
        data = self.loader(fn)
        if self.transform is not None:
            data = self.transform(data)
        return data, label

    def __len__(self):
        return len(self.files)

