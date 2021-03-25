clear
clc
close all
% for Process_Device_Index = 1:54
for Process_Device_Index = 1:1
%     for Process_Test_Index = 1: 150
    for Process_Test_Index = 1:1000
        str= strcat ('F:\东大毕设\data\Signal0-30dB-All\SignalZero_Device_', int2str(Process_Device_Index) , '_', int2str(Process_Test_Index) ,'.mat');   
        load(str, 'y');
        
        yy_fft=fft(y);  %做FFT变换
        y = fftshift(yy_fft);
%         y1 = abs(yy_abs);  %求模值并换算成dB形式
%         saveFileName = strcat("F:\东大毕设\data\FFT\FFT-30dB-带相位-8个一组\FFT30dB_Device_", int2str(Process_Device_Index),"_",int2str(Process_Test_Index))
%         save(saveFileName, 'y');
        
%         fig = figure;
        hold on;
        x = 1:160;
        plot(x, y);
        hold on;
%         xlabel("采样点");
%         ylabel("幅度");
        title("对第一台设备的所有0做FFT变换");
%         axis off;
%         if Process_Device_Index >= 1
%              set(fig,'visible','off');
%         end
%         frame = getframe(fig);
%         img = frame2im(frame);
% %         if (Process_Test_Index >= 180 && Process_Test_Index < 200) || ...,
% %            (Process_Test_Index >= 380 && Process_Test_Index < 400) || ...,
% %            (Process_Test_Index >= 580 && Process_Test_Index < 600) || ...,
% %            (Process_Test_Index >= 780 && Process_Test_Index < 800) || ...,
% %            (Process_Test_Index >= 980 && Process_Test_Index < 1000) 
% %              savePicName = strcat('F:\东大毕设\data\FFT\图片\30dB\val\', int2str(Process_Device_Index) , '\', int2str(Process_Test_Index),'.png')
% %         else
% %              savePicName = strcat('F:\东大毕设\data\FFT\图片\30dB\train\', int2str(Process_Device_Index) , '\', int2str(Process_Test_Index),'.png')
% %         end  
%         II = imresize(img,[64, 64]);
%         imwrite(II,savePicName);
    end
end
