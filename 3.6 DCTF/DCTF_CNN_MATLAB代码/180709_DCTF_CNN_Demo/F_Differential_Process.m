function [Data_Process_Out] = F_Differential_Process(Data_Process_Raw_In, Differential_Interval)
    % Differential Process
    Process_Length = length(Data_Process_Raw_In) - Differential_Interval;
    Data_Process_Out = zeros(length(Data_Process_Raw_In),1);
    if(Process_Length>0)
        for n = 1:Process_Length
            Data_Process_Out(n,1) = Data_Process_Raw_In(n,1) * conj(Data_Process_Raw_In(n+Differential_Interval,1));
        end         
    end
return;