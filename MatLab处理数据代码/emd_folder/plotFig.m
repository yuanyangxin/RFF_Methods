clc;
clear;
close all;

figure;
for round = 1: 150
   str= strcat ('F:\东大毕设\data\HHT数据\10dB\SignalZero_Device_1_' ,int2str(round), '.mat');
   load(str, 'recover');
   hold on;
   x = 1: length(recover);
   plot(x, recover);
end