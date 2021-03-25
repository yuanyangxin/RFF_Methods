clc
close all
clear
%%提取每台设备5次实验中的所有0信号
for Process_Device_Index = 1:54
    for round = 1: 5
    %     for round = 1: 5
        for i = 14: 64
            str= strcat ('F:\东大毕设\data\ChannelB_Out_Door_30dB\ChannelBOutDoor_Device_', int2str(Process_Device_Index) , '_',int2str(round), '.mat');   
            load(str, 'fadeSig');
            y = fadeSig(640 * i - 639 : 640 * i)
%             x = 1: 640
            hold on
%             plot(x, y)
            Process_Test_Index = i - 13 + 50 * (round - 1);
            saveFileName = strcat ('F:\东大毕设\data\瑞利多径处理后的数据\高延迟室外_4个0一组\SignalZero_Device_', int2str(Process_Device_Index) , '_', int2str(Process_Test_Index) ,'.mat')  
            save(saveFileName, 'y');
        end
%         titleName = strcat("设备", int2str(Process_Device_Index), "，第", int2str(round), "次实验")
%         title(titleName);
    end
end