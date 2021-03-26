clc
clear
close all
% SignalZero_Device_54_794
data = [];
for i=1:54
%     for j=1:1000
%     for j=1:150
    for j=1:251
        i
        j
        str= strcat ('F:\东大毕设\data\Signal0-30dB-4个一组\SignalZero_Device_', int2str(i) , '_', int2str(j) ,'.mat');   % Test, get file name
        load(str);
        a = y.';
%         b = [real(a) i];
%         b = [imag(a) i];
        b = [real(a) imag(a) i];
        data = [data; b]; 
    end
end
save('data30dB_4个0.mat','data')
