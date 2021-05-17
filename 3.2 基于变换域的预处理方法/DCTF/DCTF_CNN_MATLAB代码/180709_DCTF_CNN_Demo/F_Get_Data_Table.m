function [Plot_Talbe] = F_Get_Data_Table(Plot_Table_Size, Plot_Table_Max, Input_Data, Data_Offset_Length)
    % Plot Table
	Plot_Talbe = zeros(2*Plot_Table_Size+1,2*Plot_Table_Size+1);
	Plot_Scale = Plot_Table_Max/Plot_Table_Size;
    Process_Length = length(Input_Data) - 2 * Data_Offset_Length;
	if(Process_Length>0)
        for n = Data_Offset_Length+1:Process_Length-Data_Offset_Length
            I_Index = floor(real(Input_Data(n,1))/Plot_Scale);
            Q_Index = floor(imag(Input_Data(n,1))/Plot_Scale);
            if(I_Index>Plot_Table_Size)
                I_Index = Plot_Table_Size;
            end
            if(Q_Index>Plot_Table_Size)
                Q_Index = Plot_Table_Size;
            end        
            if(I_Index<-Plot_Table_Size)
                I_Index = -Plot_Table_Size;
            end
            if(Q_Index<-Plot_Table_Size)
                Q_Index = -Plot_Table_Size;
            end           
            Plot_Talbe(Plot_Table_Size+Q_Index+1,Plot_Table_Size+I_Index+1) = Plot_Talbe(Plot_Table_Size+Q_Index+1,Plot_Table_Size+I_Index+1)+1;
        end   
    end
%  	Plot_Talbe(Plot_Table_Size,Plot_Table_Size) = 0;
%  	Plot_Talbe(Plot_Table_Size+1,Plot_Table_Size+1) = 0;   
%  	Plot_Talbe(Plot_Table_Size+2,Plot_Table_Size+2) = 0;  
% 	Plot_Talbe(Plot_Table_Size+2,Plot_Table_Size+1) = 0;  
% 	Plot_Talbe(Plot_Table_Size+1,Plot_Table_Size+2) = 0;  
% 	Plot_Talbe(Plot_Table_Size,Plot_Table_Size+2) = 0; 
% 	Plot_Talbe(Plot_Table_Size+2,Plot_Table_Size) = 0;     
% 	Plot_Talbe(Plot_Table_Size,Plot_Table_Size+1) = 0;    
%  	Plot_Talbe(Plot_Table_Size+1,Plot_Table_Size) = 0;
    
    Plot_Talbe = sqrt(Plot_Talbe);
    
return;