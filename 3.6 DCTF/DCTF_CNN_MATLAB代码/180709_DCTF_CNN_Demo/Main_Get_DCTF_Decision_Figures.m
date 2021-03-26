clear
clc


Device_Index_Number = 54;       % Test, get device index
Device_Test_Number = 3;         % Test, get test index
% Due to the carrier frequency offset variations, it is better to use test index 1 and 5 for training, test index 2, 3, 4 for testing
% We will solve this carrier frequency offset variations problem in furture work.

IQ_Offset_Interval = 1; % Introduced I/Q phase mismatch distortion
Differential_Interval = 10; % Differential interval

Plot_Table_Size = 32;  % DCTF Size
Plot_Table_Max = 3;     % DCTF amplitude range
Process_Data_Offset = 0; % Delete some samples for generating DCTF

Downsampling_Rate = 1; % Down sampling rate

Simulation_Loops = 5;

Data_Length_Identification = 40000; % Get data length for generating DCTF

Data_Length_Identification = floor(Data_Length_Identification / Downsampling_Rate);

Adding_Noise_Start = 10;    % Simulation SNR start, in dB
Adding_Noise_End = 10;      % Simulation SNR end, in dB
Adding_Noise_Step = 5;      % Simulation SNR step, in dB

Adding_Noise_Loops = (Adding_Noise_End - Adding_Noise_Start) / Adding_Noise_Step + 1; % Get the overall loop number

for Process_Device_Index = 1:Device_Index_Number
    Process_Device_Index = Process_Device_Index
    Cont_Test_Index = 0;
    
    for Adding_Noise_Index = 1:Adding_Noise_Loops
        Noise_Level = Adding_Noise_Start + Adding_Noise_Step * (Adding_Noise_Index - 1);
        
        for Simulation_Index = 1:Simulation_Loops
        
            for Process_Test_Index = 1:Device_Test_Number
%                 Get_Test_Index = (Process_Test_Index - 1) * 4 + 1;      % For geting test index 1 and 5
                Get_Test_Index = Process_Test_Index + 1;              % For geting test index 2, 3, 4
                str= strcat ('Data_Set/A_No_', int2str(Process_Device_Index) , '_19dBm_', int2str(Get_Test_Index) ,'.mat');   % Test, get file name
                load(str)    % Test, get data

                Data_Size = size(Count_Data_Length_Sides);

                Segment_Length = Data_Size(1,1);

                for Process_Segment_Index = 1:Segment_Length
                    Get_Sample_Length = Count_Data_Length_Sides(Process_Segment_Index,2) - Count_Data_Length_Sides(Process_Segment_Index,1)+1;
                    Data_Sample = zeros(Get_Sample_Length,1);
                    Data_Sample(1:Get_Sample_Length,1) = Brush_Data_Temp(Count_Data_Length_Sides(Process_Segment_Index,1): Count_Data_Length_Sides(Process_Segment_Index,2),1);
                    Data_Sample(1:Get_Sample_Length,1) = Data_Sample(1:Get_Sample_Length,1) / mean(abs(Data_Sample(1:Get_Sample_Length,1)));

                    % DownSampling
                    Data_Sample = resample(Data_Sample,1,Downsampling_Rate);
                    Get_Sample_Length = floor(Get_Sample_Length / Downsampling_Rate);
                    
                    % Adding Noise
                    Data_Process_Raw = awgn(Data_Sample,Noise_Level);  
                    Data_Process_Raw_Process = zeros(Data_Length_Identification,1);
                    
                    if(Data_Length_Identification<Get_Sample_Length)
                        Data_Process_Raw_Process(1:Data_Length_Identification,1) = Data_Process_Raw(1:Data_Length_Identification,1);
                    else
                        Data_Process_Raw_Process = Data_Process_Raw;
                    end

                    Data_Process_Raw_Offset = F_Data_IQ_Offset_Process(Data_Process_Raw_Process,IQ_Offset_Interval);
                    Data_Process_Raw_Offset = F_Differential_Process(Data_Process_Raw_Offset,Differential_Interval);

                    Plot_Table = F_Get_Data_Table(Plot_Table_Size,Plot_Table_Max,Data_Process_Raw_Offset,Process_Data_Offset);

                    min_table=min(min(Plot_Table));  
                    max_table=max(max(Plot_Table));
                    Plot_Table=Plot_Table./(max_table-min_table)*255;  
                    Plot_Table = 255 - Plot_Table;

                    Cont_Test_Index = Cont_Test_Index + 1;
                    str_write_jpg= strcat ('DCTF_Features/DCTF32_IQ1_D10_30dB_D/', int2str(Process_Device_Index) , '/', int2str(Cont_Test_Index), '.png');
%                     str_write_jpg= strcat ('Test.png'); 
                    imwrite(uint8(Plot_Table), str_write_jpg);
                end
            end
        end
    end
end

