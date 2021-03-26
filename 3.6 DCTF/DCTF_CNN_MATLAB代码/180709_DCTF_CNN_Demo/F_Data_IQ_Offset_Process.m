function [Data_Process_Out] = F_Data_IQ_Offset_Process(Data_Process_In,Offset_Interval)
    % Data_IQ Offset Process
    Data_Process_Real = real(Data_Process_In);
    Data_Process_Imag = imag(Data_Process_In);
    Process_Length = length(Data_Process_In) - Offset_Interval;
    Data_Process_Out = zeros(length(Data_Process_In),1);
    if(Process_Length>0)
        for n  =1:Process_Length
            Data_Process_Out(n,1) = Data_Process_Real(n+Offset_Interval,1)+Data_Process_Imag(n,1)*1i;
        end        
    end
return;


