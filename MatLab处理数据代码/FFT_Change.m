clear
clc
% close all
for Process_Device_Index = 1:54
%     Process_Device_Index
    for Process_Test_Index = 1:5
        str= strcat ('F:\东大毕设\data\同步信号30dB\Syn_Device_', int2str(Process_Device_Index) , '_', int2str(Process_Test_Index) ,'.mat');   
        load(str, 'Brush_Data_Temp');
        for i = 4:8
            newterm = 5 * (i-4) + Process_Test_Index;
            saveFileName = strcat('F:\东大毕设\data\FFT\30dB\FFT30dB_', 'Device_', int2str(Process_Device_Index) , '_', int2str(newterm));
            y = Brush_Data_Temp(160 * i - 159: 160 * i);
            yy_fft=fft(y);  %做FFT变换
            yy_abs = fftshift(yy_fft);
            y1 = abs(yy_abs);  %求模值并换算成dB形式
            fig = figure;
%             titleName = strcat("第", int2str(Process_Device_Index), "台设备")
%             title(titleName);
            x = 1:160;
            plot(x, y1);
            axis off;
            if Process_Device_Index >= 1
                set(fig,'visible','off');
            end
            frame = getframe(fig);
            img = frame2im(frame);
            if Process_Test_Index == 1 || Process_Test_Index == 5 
                savePicName = strcat('F:\东大毕设\data\FFT\30dBPic-299pixel\train\', int2str(Process_Device_Index) , '\', int2str(newterm),'.png')
            else
                savePicName = strcat('F:\东大毕设\data\FFT\30dBPic-299pixel\val\', int2str(Process_Device_Index) , '\', int2str(newterm),'.png')
            end 
            II = imresize(img,[299, 299]);
            imwrite(II,savePicName);
            save(saveFileName, 'y1');
        end
    end
end

% clear
% clc
% close all
% for i = 16:30
%     str = strcat ('F:\东大毕设\data\FFT\30dB\FFT30dB_Device_54_', int2str(i))
%     load(str, 'y1')
%     y = y1
%     x = 1 : length(y)
%     hold on
%     plot(x,y);
%     xlabel("采样点")
%     ylabel("幅度")
%     title("FFT")
% end