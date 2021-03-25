clc
close all
clear
% load 'F:\东大毕设\data\研究信道影响的数据\同步截取后的信号\室外高延迟\Syn_Device_53_1.mat'
load 'F:\东大毕设\data\实验采集的数据\室外近距离_同步信号\Syn_Device_12_2.mat'
% load Xindao.mat
% plot(real(Brush_Data_Temp))

figure;

for i = 3:32
%     y = Brush_Data_Temp(160 * i - 159 : 160 * i);
    y = SynSignal(1280 * i - 1279 : 1280 * i);
    x = 1: 1280;
    hold on;
    plot(x, real(y));
    title("室外近距离情况下真实采集的0数据");
    xlabel("采样点");
    ylabel("幅度");    
end

