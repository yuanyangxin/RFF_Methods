clear
clc
close all
for Process_Device_Index = 1:54
%     Process_Device_Index
    for Process_Test_Index = 1:5
        str= strcat ('F:\东大毕设\data\FFT\30dB\FFT30dB_Device_', int2str(Process_Device_Index) , '_', int2str(Process_Test_Index) ,'.mat');   
        load(str, 'y1');
        s = y1;
        Len = length(s);
        [ca1, cd1] = dwt(s, 'db1'); % 采用db1小波基分解
        a1 = upcoef('a', ca1, 'db1', 1, Len); % 从系数得到近似信号
        d1 = upcoef('d', cd1, 'db1', 1, Len); % 从系数得到细节信号
%         s1 = a1+d1; % 重构信号

        
        [ca1, cd1] = dwt(s, 'db1'); % 采用db1小波基分解
        a1 = upcoef('a', ca1, 'db1', 1, Len); % 从系数得到近似信号
        d1 = upcoef('d', cd1, 'db1', 1, Len); % 从系数得到细节信号
%         s1 = a1+d1; % 重构信号
        
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