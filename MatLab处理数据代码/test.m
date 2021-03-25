clc
close all
clear


fs = 3.84e6; % Hz
pathDelays = [0 200 800 1200 2300 3700]*1e-9; % sec
avgPathGains = [0 -0.9 -4.9 -8 -7.8 -23.9]; % dB
fD = 50; % Hz

ricianChan = comm.RicianChannel('SampleRate',fs, ...
    'PathDelays',pathDelays, ...
    'AveragePathGains',avgPathGains, ...
    'KFactor',10, ...
    'MaximumDopplerShift',fD, ...
    'Visualization','Impulse and frequency responses', ...
    'DopplerSpectrum',doppler('Flat'));

x = randi([0 1],1000,1);
y = ricianChan(x);