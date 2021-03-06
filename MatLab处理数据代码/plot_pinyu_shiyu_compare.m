clc;
clear;
close all;

x = [10,15,20,30];

% %%每组输入1个符号0情况下时域和时域的识别准确率
% pinyu = [38.21, 60.98, 82.39, 96.10];
% shiyu = [41.59, 64.08, 85.22, 99.39];

% %%每组输入4个符号0情况下时域和时域的识别准确率
% pinyu = [53.92, 85.73, 92.28, 98.42];
% shiyu = [65.94, 88.07, 95.4, 98.78];

%%每组输入8个符号0情况下时域和时域的识别准确率
pinyu = [58.21, 86.34, 93.21, 97.04];
shiyu = [77.84, 90.57, 96.39, 99.24];


plot(x,pinyu,'d-k',x,shiyu,'s-k')
legend('频域信号','时域信号');
set(gca,'Xtick',[10 15 20 30],'fontsize',18);
title("每组输入8个符号0情况下时域和时域的识别准确率");
xlabel("信噪比（dB）")
ylabel("准确率（%）")