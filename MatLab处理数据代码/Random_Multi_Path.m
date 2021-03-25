function [Channel_Tau, Channel_Gain] = Random_Multi_Path(Channel_Multi_Path_Number)

    Channel_Tau = zeros(1, Channel_Multi_Path_Number);
    Channel_Gain = zeros(1, Channel_Multi_Path_Number);
    
%     Gain_Ratio = - (0.01 + 0.08 * rand);
    Gain_Ratio = - (0.03 + 0.02 * rand);

%     Gain_Ratio = - 0.1;

    for i = 2:Channel_Multi_Path_Number
        if (i == 2)
            Channel_Tau(1, 2) = round(50 + 200 * rand);
%             Channel_Tau(1, 2) = round(50 + 100 * rand);
        else
            Channel_Tau(1, i) = Channel_Tau(1, i - 1) + round(Channel_Tau(1, 2) * (0.3 + 1.7 * rand));    
%             Channel_Tau(1, i) = Channel_Tau(1, i - 1) + round(Channel_Tau(1, 2) * (0.6 + 1.4 * rand));
        end     
        Channel_Gain(1, i) = roundn(Channel_Tau(1, i) * Gain_Ratio * (0.8 + (1.2-0.8) * rand), -1);
    end
    
%     Channel_Tau = Channel_Tau*1e-9;

end
