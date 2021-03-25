clc
close all
clear
%%提取每台设备5次实验中的所有0信号
% for round = 1: 5
x = 1:1280
for Process_Device_Index = 1:12
    figure;
    for round = 1: 5
        str= strcat ('F:\东大毕设\data\实验采集的数据\室内近距离_实验室桌子_同步信号\Syn_Device_', int2str(Process_Device_Index) , '_',int2str(round), '.mat')
        if exist(str,'file') ~= 0
            load(str, 'SynSignal');
            for i = 3: 32 
                if 1280 * i < length(SynSignal)
                    y = SynSignal(1280 * i - 1279 : 1280 * i);
                    hold on;
                    plot(x, y);
                    
                    title("室内近距离_实验室桌子下设备采集到的数据(每8个0为一组)");
                    Process_Test_Index = i - 2 + 30 * (round - 1);
                    saveFileName = strcat ('F:\东大毕设\data\实验采集的数据\室内近距离_实验室桌子_8个0\SignalZero_Device_', int2str(Process_Device_Index) , '_', int2str(Process_Test_Index) ,'.mat');    
                    save(saveFileName, 'y');
                end
            end
        end
    end
end
