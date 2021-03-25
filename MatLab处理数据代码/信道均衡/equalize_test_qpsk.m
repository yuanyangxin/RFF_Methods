clc;
clear;

load('tx.mat');
load('rx.mat');

tx = x(10:635);
rx = y3_chan(12:637);

% figure;
% subplot(2,1,1); 
% stem(real(x))
% title('Equalizer Tap Weights')
% subplot(2,1,2); 
% stem(imag(y3_chan))




numSymbols = length(tx);
numTrainingSymbols = floor(numSymbols / 10);

% Create a linear equalizer System object and display the default configuration. Adjust the reference tap to 1. Check the maximum permitted step size. Equalize the impaired symbols.

eq = comm.LinearEqualizer;

eq.ReferenceTap = 1;

mxStep = maxstep(eq,rx);
% mxStep = 0.3154
[y,err,weights] = eq(rx,tx(1:numTrainingSymbols));
% Plot the constellation of the impaired and equalized symbols.

constell = comm.ConstellationDiagram('NumInputPorts',2);
constell(rx,y);

% Plot the equalizer error signal and compute the error vector magnitude (EVM) of the equalized symbols.
plot(abs(err))
grid on; xlabel('Symbols'); ylabel('|e|');title('Equalizer Error Signal')

errevm = comm.EVM;
evm = errevm(tx,y);
% evm = 11.7710

% Plot the equalizer tap weights.
subplot(3,1,1); 
stem(real(weights)); ylabel('real(weights)'); xlabel('Tap'); grid on; axis([0 6 -0.5 1])
title('Equalizer Tap Weights')
subplot(3,1,2); 
stem(imag(weights)); ylabel('imag(weights)'); xlabel('Tap'); grid on; axis([0 6 -0.5 1])
subplot(3,1,3); 
stem(abs(weights)); ylabel('abs(weights)'); xlabel('Tap'); grid on; axis([0 6 -0.5 1])