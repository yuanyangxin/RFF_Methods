function [Get_Data] = F_Get_Data_From_File(Process_Data_Start,Process_Data_Length)
    global fileID
    Get_Data_Length = (Process_Data_Length+Process_Data_Start)*2+1;
    Data_Temp = fread(fileID,[Get_Data_Length,1],'float32');
    Get_Data_Length = floor(length(Data_Temp)/2);
    Data_Real = zeros(Get_Data_Length,1);
    Data_Imag = zeros(Get_Data_Length,1);
    for n = 1:Get_Data_Length
        Data_Real(n,1) = Data_Temp((n-1)*2+1,1);
        Data_Imag(n,1) = Data_Temp(n*2,1);
    end
    Data_Complex = Data_Real + Data_Imag * 1i;
    
    In_Data_Length = length(Data_Complex) - Process_Data_Start;
    if(Process_Data_Length>In_Data_Length)
        Process_Data_Length = In_Data_Length;
    end
    Get_Data = zeros(Process_Data_Length,1);
    for n = 1:Process_Data_Length
        Get_Data(n,1) = Data_Complex(Process_Data_Start+n,1);
    end
return;