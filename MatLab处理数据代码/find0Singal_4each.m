clc
close all
clear
load 'F:\东大毕设\data\ChannelB_In_Office_30dB\ChannelBInOffice_Device_1_1.mat'
% load Xindao.mat
% plot(real(Brush_Data_Temp))

figure;

for i = 14:64
%     y = Brush_Data_Temp(160 * i - 159 : 160 * i);
    y = fadeSig(640 * i - 639 : 640 * i);
    x = 1: 640;
    hold on;
    plot(x, real(y));
    title("多径瑞利衰落信道下的0信号(高延迟室外)");
    xlabel("采样点");
    ylabel("幅度");    
end