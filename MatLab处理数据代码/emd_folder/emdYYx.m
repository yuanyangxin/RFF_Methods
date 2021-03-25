clc;
clear;
close all;
load 'F:\东大毕设\data\Signal0-10dB-8个一组\SignalZero_Device_2_100.mat'

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

result = [recoverReal;recoverImag];



