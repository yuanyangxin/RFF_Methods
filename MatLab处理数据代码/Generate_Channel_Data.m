clear
close all
clc


for Process_Device_Index = 1:54
    for Process_Test_Index = 1:5
        str= strcat ('F:\东大毕设\data\同步信号10dB\Syn_Device_', int2str(Process_Device_Index) , '_', int2str(Process_Test_Index) ,'.mat');   % Test, get file name
%         str= strcat ('F:\东大毕设\180709_DCTF_CNN_Demo\Copy_of_Data_Set\A_No_1_19dBm_1.mat');
        load(str, 'Data_Process_Find_Synchronized','Time_Synchronization_Index')    % Test, get data
%         saveFileName = strcat('F:\东大毕设\180709_DCTF_CNN_Demo\Copy_of_Data_Synchronization\A_Device_',int2str(Process_Device_Index),'_', int2str(Process_Test_Index) ,'.mat');
        
        % 获取信道的信号
        str2 = strcat ('F:\东大毕设\data\研究信道影响的数据\Data_Set_10dB\室外高延迟\Data_Device_', int2str(Process_Device_Index) , '_', int2str(Process_Test_Index) ,'.mat');   % Test, get file name
        load(str2, 'fadeSig')
        
        length(fadeSig)
        length(Data_Process_Find_Synchronized)
        if length(fadeSig) == length(Data_Process_Find_Synchronized)
            fadeSig = fadeSig(Time_Synchronization_Index:length(fadeSig));
            saveFileName = strcat('F:\东大毕设\data\研究信道影响的数据\同步截取后的信号\室外高延迟\Syn_Device_',int2str(Process_Device_Index),'_', int2str(Process_Test_Index) ,'.mat')
            save(saveFileName, 'fadeSig');
        end
    end
end