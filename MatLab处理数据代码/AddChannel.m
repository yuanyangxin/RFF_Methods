clc
close all
clear

% % 室外高延迟
% channel_tau = [0 200 800 1200 2300 3700];
% channel_gain = [0 -0.9 -4.9 -8 -7.8 -23.9];

% % 室外低延迟
% channel_tau = [0 110 190 410];
% channel_gain = [0 -9.7 -19.2 -22.8];

% % 室内高延迟
% channel_tau = [0 100 200 300 500 700];
% channel_gain = [0 -3.6 -7.2 -10.8 -18 -25.2];

% % 室内低延迟
% channel_tau = [0 50 110 170 290 310];
% channel_gain = [0 -3.0 -10.0 -18.0 -26.0 -32.0];

% % 随机信道
[channel_tau, channel_gain] = Random_Multi_Path(6)

channel_tau = channel_tau * 1e-9
Noise_Level = 30
Get_Data_Segment_Index = 1; 


% 添加信道
rayleighChan=comm.RicianChannel('SampleRate',10e6, 'PathDelays', channel_tau, 'AveragePathGains',channel_gain); % 调用自带的瑞利信道
% 
% rayleighChan = comm.RicianChannel('SampleRate',10e6, ...
%     'PathDelays',channel_tau, ...
%     'AveragePathGains',channel_gain);

% rayleighChan = comm.RayleighChannel(...
%     'SampleRate',10e6, ...
%     'PathDelays',[0 1.5e-4], ...
%     'AveragePathGains',[2 3]);

for Process_Device_Index = 1:54
    for Process_Test_Index = 1:5
        str= strcat ('Data_Set/A_No_', int2str(Process_Device_Index) , '_19dBm_', int2str(Process_Test_Index) ,'.mat');   % Test, get file name
        load(str, 'Brush_Data_Temp', 'Count_Data_Length_Sides')    % Test, get data
        saveFileName = strcat('F:\东大毕设\data\研究信道影响的数据\多径随机\多径随机_Device_',int2str(Process_Device_Index),'_', int2str(Process_Test_Index) ,'.mat');
        
        Input_Data_Segment = Brush_Data_Temp;
        Input_Data_Length = Count_Data_Length_Sides;
        
        Output_Data_Length = Input_Data_Length(Get_Data_Segment_Index,2) - Input_Data_Length(Get_Data_Segment_Index,1)+1;
        Output_Data = zeros(Output_Data_Length,1);
      	Output_Data(1:Output_Data_Length,1) = Input_Data_Segment(Input_Data_Length(Get_Data_Segment_Index,1):Input_Data_Length(Get_Data_Segment_Index,2),1);
       
        y = Output_Data;
        fadeSig = rayleighChan(y);
%         需要先归一化，然后再加噪声
        fadeSig = awgn(fadeSig, Noise_Level);
        save(saveFileName, 'fadeSig')
    end
end

