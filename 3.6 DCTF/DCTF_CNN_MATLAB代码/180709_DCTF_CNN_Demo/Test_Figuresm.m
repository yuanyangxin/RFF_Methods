clear
clc

Data_Length_Identification = 40000; % Get data length for generating DCTF
IQ_Offset_Interval = 0; % Introduced I/Q phase mismatch distortion
Differential_Interval = 10; % Differential interval


Set_Channel_Type = 3;      % 0 for Zero, 1 for good, 2 for moderate, 3 for bad, 4 for random
Set_Multi_Path_Number = 4;  % set the number of multipath

% Get_Test_Index = (Process_Test_Index - 1) * 4 + 1;    % For geting test index 1 and 5
% Get_Test_Index = Process_Test_Index + 1;              % For geting test index 2, 3, 4
% str= strcat ('Data_Set/A_No_1_19dBm_1.mat');   % Test, get file name
str= strcat ('zigbeeBefore.mat');
load(str)    % Test, get data

Data_Size = size(Count_Data_Length_Sides);

Segment_Length = Data_Size(1,1);

%                 Impulse_Response = Random_Generate_Channel(1,4);


for Process_Segment_Index = 1:Segment_Length
    Get_Sample_Length = Count_Data_Length_Sides(Process_Segment_Index,2) - Count_Data_Length_Sides(Process_Segment_Index,1)+1;
    Data_Sample = zeros(Get_Sample_Length,1);
    Data_Sample(1:Get_Sample_Length,1) = Brush_Data_Temp(Count_Data_Length_Sides(Process_Segment_Index,1): Count_Data_Length_Sides(Process_Segment_Index,2),1);
    Data_Sample(1:Get_Sample_Length,1) = Data_Sample(1:Get_Sample_Length,1) / mean(abs(Data_Sample(1:Get_Sample_Length,1)));

    % DownSampling
%     Data_Sample = resample(Data_Sample,1,Downsampling_Rate);
%     Get_Sample_Length = floor(Get_Sample_Length / Downsampling_Rate);

    % Adding Channel
%     Impulse_Response = Random_Generate_Channel(Set_Channel_Type, Set_Multi_Path_Number);                    

%     if(Data_Length_Identification < Get_Sample_Length)
%         Data_Process_Channel = conv(Data_Sample, Impulse_Response, 'same');
%     else
%         Data_Process_Channel = conv(Data_Sample, Impulse_Response, 'same');
%     end

    % Adding Noise
%     Data_Process_Raw = Data_Sample;
    Data_Process_Raw = awgn(Data_Sample,30);  
    Data_Process_Raw_Process = zeros(Data_Length_Identification,1);

    if(Data_Length_Identification<Get_Sample_Length)
        Data_Process_Raw_Process(1:Data_Length_Identification,1) = Data_Process_Raw(1:Data_Length_Identification,1);
    else
        Data_Process_Raw_Process = Data_Process_Raw;
    end

    Data_Process_Raw_Offset = F_Data_IQ_Offset_Process(Data_Process_Raw_Process,IQ_Offset_Interval);
    Data_Process_Raw_Offset = F_Differential_Process(Data_Process_Raw_Offset,Differential_Interval);

    Plot_Table = F_Get_Data_Table(32,3,Data_Process_Raw_Offset,0);

    min_table=min(min(Plot_Table));  
    max_table=max(max(Plot_Table));
    Plot_Table=Plot_Table./(max_table-min_table)*255;  
    Plot_Table = 255 - Plot_Table;

%     Cont_Test_Index = Cont_Test_Index + 1;
%     str_write_jpg= strcat ('DCTF_Features/DCTF32_IQ1_D10_30dB_T/', int2str(Process_Device_Index) , '/', int2str(Cont_Test_Index), '.png');
    str_write_jpg= strcat ('203.png'); 
    imwrite(uint8(Plot_Table), str_write_jpg);

end





































