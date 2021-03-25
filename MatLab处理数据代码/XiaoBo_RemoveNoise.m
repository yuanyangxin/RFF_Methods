clc
clear
close all

load F:\东大毕设\data\同步信号10dB\Syn_Device_1_1.mat

figure;
for i = 13: 212
    y = Brush_Data_Temp(160 * i - 159 : 160 * i)
    x = 1: 160
    hold on
    plot(x, y)
    title("寻找0信号(30dB)")
    xlabel("采样点")
    ylabel("幅度")
end

figure;
for i = 13: 212
    y1 = Brush_Data_Temp(160 * i - 159 : 160 * i)
    x1 = 1: 160
    xb=wden(y1,'minimaxi','s','one',4,'db3');
    hold on
    plot(x1, y1)
    title("寻找0信号(30dB)")
    xlabel("采样点")
    ylabel("幅度")
end


