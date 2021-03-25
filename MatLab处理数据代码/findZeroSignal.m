clc
close all
clear
% load 'F:\东大毕设\data\实验采集的数据\室外近距离\A_No_3_10dBm_5'
% 
% figure;
% for i = 1:8
%     plot(real(Brush_Data_Temp(160*i - 159:160*i)));
%     hold on;
% end

load 'F:\东大毕设\data\消除频偏的信号\Syn_Device_1_1'
plot(real(Brush_Data_Temp(1:1280)));
set(gca,'Xtick',[0 160 320 480 640 800 960 1120 1280],'Ytick',[-1.5 1.5],'fontsize',10);
title("同步报头波形");
xlabel("采样点")
ylabel("同步幅度")



load 'F:\东大毕设\data\实验采集的数据\室外近距离_同步信号\Syn_Device_12_1.mat'
% load Xindao.mat
% plot(real(Brush_Data_Temp))
% 
% figure;
% plot(real(SynSignal(1:100)));

figure;
for i = 14:56
%     y = Brush_Data_Temp(160 * i - 159 : 160 * i);
    y = SynSignal(160 * i - 159 : 160 * i);
    x = 1: 160;
    hold on;
    plot(x, real(y), 'r');
%     title("多径瑞利衰落信道下的0信号(高延迟室外)");
    xlabel("采样点");
    ylabel("幅度");
end

load 'F:\东大毕设\data\实验采集的数据\室外近距离_同步信号\Syn_Device_11_1.mat'
% load Xindao.mat
% plot(real(Brush_Data_Temp))
% 
% figure;
% plot(real(SynSignal(1:100)));

for i = 14:56
%     y = Brush_Data_Temp(160 * i - 159 : 160 * i);
    y = SynSignal(160 * i - 159 : 160 * i);
    x = 1: 160;
    hold on;
    plot(x, real(y),'b');
%     title("多径瑞利衰落信道下的0信号(高延迟室外)");
    xlabel("采样点");
    ylabel("幅度");
end

load 'F:\东大毕设\data\实验采集的数据\室外近距离_同步信号\Syn_Device_1_1.mat'
% load Xindao.mat
% plot(real(Brush_Data_Temp))
% 
% figure;
% plot(real(SynSignal(1:100)));

for i = 14:56
%     y = Brush_Data_Temp(160 * i - 159 : 160 * i);
    y = SynSignal(160 * i - 159 : 160 * i);
    x = 1: 160;
    hold on;
    plot(x, real(y),'c');
%     title("多径瑞利衰落信道下的0信号(高延迟室外)");
    xlabel("采样点");
    ylabel("幅度");
end


% load 'F:\东大毕设\data\实验采集的数据\室外近距离_同步信号\Syn_Device_12_3.mat'
% % load Xindao.mat
% % plot(real(Brush_Data_Temp))
% % 
% % figure;
% % plot(real(SynSignal(1:100)));
% 
% figure;
% for i = 14:56
% %     y = Brush_Data_Temp(160 * i - 159 : 160 * i);
%     y = SynSignal(160 * i - 159 : 160 * i);
%     x = 1: 160;
%     hold on;
%     plot(x, real(y));
% %     title("多径瑞利衰落信道下的0信号(高延迟室外)");
%     xlabel("采样点");
%     ylabel("幅度");
% end
% 
% 
% load 'F:\东大毕设\data\实验采集的数据\室外近距离_同步信号\Syn_Device_12_4.mat'
% % load Xindao.mat
% % plot(real(Brush_Data_Temp))
% % 
% % figure;
% % plot(real(SynSignal(1:100)));
% 
% figure;
% for i = 14:56
% %     y = Brush_Data_Temp(160 * i - 159 : 160 * i);
%     y = SynSignal(160 * i - 159 : 160 * i);
%     x = 1: 160;
%     hold on;
%     plot(x, real(y));
% %     title("多径瑞利衰落信道下的0信号(高延迟室外)");
%     xlabel("采样点");
%     ylabel("幅度");
% end
% 
% 
% load 'F:\东大毕设\data\实验采集的数据\室外近距离_同步信号\Syn_Device_12_5.mat'
% % load Xindao.mat
% % plot(real(Brush_Data_Temp))
% % 
% % figure;
% % plot(real(SynSignal(1:100)));
% 
% figure;
% for i = 14:56
% %     y = Brush_Data_Temp(160 * i - 159 : 160 * i);
%     y = SynSignal(160 * i - 159 : 160 * i);
%     x = 1: 160;
%     hold on;
%     plot(x, real(y));
% %     title("多径瑞利衰落信道下的0信号(高延迟室外)");
%     xlabel("采样点");
%     ylabel("幅度");
% end
% figure;

load 'F:\东大毕设\data\消除频偏的信号\Syn_Device_1_1.mat'
for i = 3: 8
    y = Brush_Data_Temp(160 * i - 159 : 160 * i)
    x = 1: 160
    hold on
    plot(x, y)
    title("设备1同步报头中的稳态0")
    xlabel("采样点")
    ylabel("幅度")
end
figure;
for i = 13: 100
    y = Brush_Data_Temp(160 * i - 159 : 160 * i)
    x = 1: 160
    hold on
    plot(x, y)
end

% figure;
% for i = 3: 21
%     i
%     y = Brush_Data_Temp(1920 * i - 1919 : 1920 * i)
%     x = 1: 1920
%     hold on
%     plot(x, y)
%     title("寻找0信号(30dB)")
%     xlabel("采样点")
%     ylabel("幅度")
% end

% figure;
% for i = 13: 250
%     y = Brush_Data_Temp(160 * i - 159 : 160 * i)
%     x = 1: 160
%     hold on
%     plot(x, y)
%     Process_Test_Index = i - 12;
%     saveFileName = strcat ('F:\东大毕设\data\Signal0-30dB\SignalZero_Device_', int2str(Process_Device_Index) , '_', int2str(Process_Test_Index) ,'.mat')  
%     save(saveFileName, 'y1');
% end
    

% for i= 1:45
%     fileName = strcat("F:\东大毕设\data\0信号30dB\30dB_0Signal-13-21_54_",int2str(i),'.mat')
% %     F:\东大毕设\data\0信号30dB\30dB_0Signal-13-21_1_1.mat
%     load(fileName)
%     x = 1:160
%     hold on
% %     str=strcat(num2str(i));
% %     legend(str)
%     plot(x, y)
%     title("30dB时的0信号")
%     xlabel("采样点")
%     ylabel("幅度")
% end

