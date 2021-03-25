clc
clear
close all

load 'F:\东大毕设\data\HHT数据\10dB-8个0一组-舍弃最后2个\SignalZero_Device_1_1.mat'
x = 1: length(recover)
plot(x, real(recover),'red');

load 'F:\东大毕设\data\Signal0-10dB-8个一组\SignalZero_Device_1_1'
hold on
plot(x, real(y),'black')