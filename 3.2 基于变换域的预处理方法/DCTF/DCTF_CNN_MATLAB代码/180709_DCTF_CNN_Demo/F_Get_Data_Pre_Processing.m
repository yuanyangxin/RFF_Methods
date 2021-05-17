function [Input_Data_Segment,Input_Data_Length] = F_Get_Data_Pre_Processing(Input_Data,Process_Type)
    global Process_Data_Length FFT_Length FFT_Length_BW
    Moving_Average_Window = 20;     % Moving averag window length
    Find_Data_Power_Thoreshold = 2;     % Power detection theoreshold (1/2 max power)
    Get_Data_Start_Point = 50;      % Start points ignored
    Brush_Data_Min_Interval = 500;    % Definition of the Minimal Intercal between two brush data
    
    Get_Data_Offset = 10;                % Get more samples before power detection
    
    if(FFT_Length < FFT_Length_BW)
            Find_Brush_Min_Length = FFT_Length_BW*2;    % Minimal Length of Brush Segment (Less the length could be traited as noise)
            Find_Brush_Segment_Max = round(Process_Data_Length/FFT_Length_BW/2);      % Maximal Brush Segment Detection
    else
           Find_Brush_Min_Length = FFT_Length*2;    % Minimal Length of Brush Segment (Less the length could be traited as noise)
           Find_Brush_Segment_Max = round(Process_Data_Length/FFT_Length/2);      % Maximal Brush Segment Detection
    end
    
     
    switch Process_Type
        case 1
            Data_Process_Abs = zeros(Process_Data_Length,1);
            Process_Blocks = floor(Process_Data_Length/Moving_Average_Window);
            for n = 1:Process_Blocks
                Temp_1 = mean(abs(Input_Data((n-1)*Moving_Average_Window+1:n*Moving_Average_Window,1)));
                for m = 1:Moving_Average_Window
                    Data_Process_Abs((n-1)*Moving_Average_Window+m,1) = Temp_1;
                end
            end
            
%             Data_Process_Abs = abs(Input_Data);
%             for n = 1:Process_Data_Length-Moving_Average_Window
%                 Temp_2 = 0;
%                 for m = 1:Moving_Average_Window
%                     Temp_2 = Temp_2 + Data_Process_Abs(n+m-1,1);
%                 end
%                 Data_Process_Abs(n,1) = Temp_2/Moving_Average_Window;
%             end
%             for n = 1:Moving_Average_Window
%                 Data_Process_Abs(Process_Data_Length-n,1) = Data_Process_Abs(Process_Data_Length-Moving_Average_Window-1,1);
%             end
    
            Find_Data_Max = max(Data_Process_Abs);
            Find_Data_Min = mean(Data_Process_Abs);
            Find_Data_Thoreshold = Find_Data_Max/Find_Data_Power_Thoreshold;
            if((Find_Data_Max/Find_Data_Min)>Find_Data_Power_Thoreshold)
                % Signal Detected
                Get_Data_Start = Get_Data_Start_Point;  
                if(Data_Process_Abs(Get_Data_Start_Point,1)>Find_Data_Thoreshold)
                    % Signal at Start, ignore this signal
                    Temp_1 = 1;
                    while(Temp_1>0)
                         Get_Data_Start = Get_Data_Start + 1;
                         if(Get_Data_Start>Process_Data_Length-Brush_Data_Min_Interval)
                            Temp_1 = 0;
                         else               
                            if(Data_Process_Abs(Get_Data_Start,1)<Find_Data_Thoreshold)
                                Get_Data_Start = Get_Data_Start + Brush_Data_Min_Interval;
                                Temp_1 = 0;
                            end
                        end
                    end
                    Find_Data_Max = max(Data_Process_Abs(Get_Data_Start:end,1));
                    Find_Data_Min = mean(Data_Process_Abs(Get_Data_Start:end,1));
                    Find_Data_Thoreshold = Find_Data_Max/Find_Data_Power_Thoreshold;                    
                    
                end
                
                % Count number of signal detected
                Temp_1 = 1;
                Temp_2 = 0;
                Count_Brush_Data = 0;
                Count_Data_Length = zeros(Find_Brush_Segment_Max,2);
                while(Temp_1>0)
                    Get_Data_Start = Get_Data_Start + 1;
                    if(Get_Data_Start>Process_Data_Length)
                        Temp_1 = 0;   
                        if(Temp_2 == 1)
                            Count_Brush_Data = Count_Brush_Data - 1;  
                        end
                    else      
                        if(Data_Process_Abs(Get_Data_Start,1)>Find_Data_Thoreshold)
                            if(Temp_2 == 0)
                                Count_Brush_Data = Count_Brush_Data + 1;
                                Count_Data_Length(Count_Brush_Data,1) = Get_Data_Start + round(Moving_Average_Window/2) - Get_Data_Offset;
                                Temp_2 = 1;
                            end 
                        else
                            if(Temp_2 == 1)
                                Count_Data_Length(Count_Brush_Data,2) = Get_Data_Start + round(Moving_Average_Window/2) + Get_Data_Offset;
                                Get_Data_Start = Get_Data_Start + Brush_Data_Min_Interval; 
                            end
                            Temp_2 = 0;
                        end                    
                     end
                end
                
                Get_Data_Length = 0;
                for n = 1:Count_Brush_Data
                    Get_Data_Length = Get_Data_Length + (Count_Data_Length(n,2)- Count_Data_Length(n,1));
                end
                
                if(Count_Brush_Data>0)
                	if(Count_Data_Length(Count_Brush_Data,2)>Process_Data_Length)
                        Count_Data_Length(Count_Brush_Data,2) = Process_Data_Length;
                    end
                    Input_Data_Segment = zeros(Get_Data_Length,1);
                    Input_Data_Length = zeros(Count_Brush_Data,2);
                    Temp_1 = 1;
                    for n = 1:Count_Brush_Data
                        Temp_2 = Temp_1+(Count_Data_Length(n,2)- Count_Data_Length(n,1));
                        Input_Data_Length(n,1) = Temp_1;
                        Input_Data_Length(n,2) = Temp_2;
                        Input_Data_Segment(Temp_1:Temp_2,1) = Input_Data(Count_Data_Length(n,1):Count_Data_Length(n,2),1);
                        Temp_1 = Temp_2+1;
                    end
                    
                    % Search the Brush Data, find noise segment.
                    
                    Count_Brush_Data_Temp = Count_Brush_Data;
                    for  n = 1:Count_Brush_Data
                        Temp_1 = Input_Data_Length(n,2) - Input_Data_Length(n,1);
                        if(Temp_1<Find_Brush_Min_Length)
                            Input_Data_Length(n,1) = 0;
                            Input_Data_Length(n,2) = 0;
                            Count_Brush_Data_Temp = Count_Brush_Data_Temp - 1;
                        end
                    end
                    
                    if(Count_Brush_Data_Temp>0)
                        Input_Data_Length_Temp = Input_Data_Length;
                        Input_Data_Length = zeros(Count_Brush_Data_Temp,2);
                        Temp_1 = 1;
                        for n = 1:Count_Brush_Data
                            if(Input_Data_Length_Temp(n,1)>0)
                                Input_Data_Length(Temp_1,1) = Input_Data_Length_Temp(n,1);
                                Input_Data_Length(Temp_1,2) = Input_Data_Length_Temp(n,2);
                                Temp_1 = Temp_1 + 1;
                            end
                        end   
                        Count_Brush_Data = Count_Brush_Data_Temp;
                    else
                        Input_Data_Length = zeros(1,2);
                        Input_Data_Length(1,1) = 1;
                        Input_Data_Length(1,2) = Process_Data_Length;
                        Input_Data_Segment = Input_Data;  
                    end
                else
                    Input_Data_Length = zeros(1,2);
                    Input_Data_Length(1,1) = 1;
                    Input_Data_Length(1,2) = Process_Data_Length;
                    Input_Data_Segment = Input_Data;  
                end
            else
                Input_Data_Length = zeros(1,2);
                Input_Data_Length(1,1) = 1;
                Input_Data_Length(1,2) = Process_Data_Length;
                Input_Data_Segment = Input_Data;                  
            end
            
        case 2
            Input_Data_Length = zeros(1,2);
            Input_Data_Length(1,1) = 1;
            Input_Data_Length(1,2) = Process_Data_Length;
            Input_Data_Segment = Input_Data;   
    end
return;