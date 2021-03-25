clc
clear
close all

load F:\东大毕设\data\Signal0-30dB-8个一组\SignalZero_Device_1_1.mat
s = [real(y)];
% Len = length(s);
% [ca1, cd1] = dwt(s, 'haar'); % 采用db1小波基分解
% a1 = upcoef('a', ca1, 'db1', 1, Len); % 从系数得到近似信号
% d1 = upcoef('d', cd1, 'db1', 1, Len); % 从系数得到细节信号
% s1 = a1+d1; % 重构信号
% figure;
% subplot(2, 2, 1); plot(s); title('初始FFT信号');
% subplot(2, 2, 2); plot(ca1); title('一层小波分解的低频信息');
% subplot(2, 2, 3); plot(cd1); title('一层小波分解的高频信息');
% subplot(2, 2, 4); plot(s1, 'r-'); title('一层小波分解的重构信号');
% 
% x = [1:160];
% figure;
% plot(x, s);
% hold on;
% plot(x, s1);
% legend("原信号","新信号");
% title("对比小波分析前后的波形图");


%%
subplot(411);plot(real(s));  %函数subplot的作用是在标定位置上建立坐标系 
title('原始符号0的信号'); 
%下面用haar小波函数进行一维离散小波变换 
[ca1,cd1]=dwt(s,'haar'); 
subplot(4,2,3);plot(ca1); axis tight;
ylabel('haar(ca1)'); 
title("一维离散小波变换 -低频")
subplot(4,2,4);plot(cd1); axis tight;
ylabel('haar(cd1)'); 
title("一维离散小波变换 -高频")
%给定一个小波db2,计算与之相关的分解滤波器 
[Lo_D,Hi_D]=wfilters('db2','d'); 
%用分解滤波器Lo_D,Hi_D计算信号s的离散小波分解系数 
[ca2,cd2]=dwt(s,Lo_D,Hi_D); 
subplot(4,2,5);plot(ca2); axis tight;
ylabel('db2(ca2)'); 
title("离散小波分解系数-低频")
subplot(4,2,6);plot(cd2); axis tight;
ylabel('db2(cd2)');
title("离散小波分解系数-高频")
