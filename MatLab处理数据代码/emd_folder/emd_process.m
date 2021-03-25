clc;
clear;
close all;

for Process_Device_Index = 1:54
    for round = 1: 150
            str= strcat ('F:\东大毕设\data\Signal0-30dB-8个一组\SignalZero_Device_', int2str(Process_Device_Index) , '_',int2str(round), '.mat');
            load(str, 'y');
            X = y;

            realPart = real(X);
            imagPart = imag(X);
            t = 1: length(X);

            % 对实部做HHT
            [imf,residual,info] = emd(realPart);
            [b,c] = size(imf)
            % emd_visu(realPart,t,imf(1:b,:));

            recoverReal = hilbert(imf(1,:));
            for i = 2: b
               recoverReal = recoverReal + hilbert(imf(i,:));
            end

            % 对虚部做HHT
            [imf2,residual2,info2] = emd(imagPart);
            [b2,c2] = size(imf2)
            % emd_visu(imagPart,t,imf2(1:b2,:));

            recoverImag = hilbert(imf2(1,:));
            for i = 2: b2
               recoverImag = recoverImag + hilbert(imf2(i,:));
            end

            
            real1 = real(recoverReal);
            imag1 = imag(recoverReal);
            real2 = real(recoverImag);
            imag2 = imag(recoverImag);
            result = [real1;imag1;real2;imag2];
            
            saveFileName = strcat ('F:\东大毕设\data\HHT数据\30dB\每部分做希尔伯特\SignalZero_Device_', int2str(Process_Device_Index) , '_', int2str(round) ,'.mat')  
            save(saveFileName, 'result');
    end
end