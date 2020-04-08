%% Clear Enviroment
clc
% close all
clear all

%% Part 1-a
f = ones(50,1);
for m = 1:5
    g(:,m) = (2^m)*f;
end
I = g(:);

%% Check Noise Effect
% I = I + randn(250,1);

%% Part 1-b
dt = 0.25; dx =1; K = 0.2; alfa = 1;
[I1] = nonLinDiff_1D(I,1,100,dt,dx,K,alfa);
[I2] = nonLinDiff_1D(I,1,1000,dt,dx,K,alfa);
[I3] = nonLinDiff_1D(I,1,10000,dt,dx,K,alfa);
[I4] = nonLinDiff_1D(I,1,100000,dt,dx,K,alfa);

% Plot the results
fig_D1 = figure; subplot(511); plot(I);  title('Original Signal');
figure(fig_D1);  subplot(512); plot(I1); title('Denoised by D1, iteration = 100');
figure(fig_D1);  subplot(513); plot(I2); title('Denoised by D1, iteration = 1000');
figure(fig_D1);  subplot(514); plot(I3); title('Denoised by D1, iteration = 10000');
figure(fig_D1);  subplot(515); plot(I4); title('Denoised by D1, iteration = 100000');

%% Part 1-c
[I5] = nonLinDiff_1D(I,2,100,dt,dx,K,alfa);
[I6] = nonLinDiff_1D(I,2,1000,dt,dx,K,alfa);
[I7] = nonLinDiff_1D(I,2,10000,dt,dx,K,alfa);
[I8] = nonLinDiff_1D(I,2,100000,dt,dx,K,alfa);

% Plot the results
fig_D2 = figure; subplot(511); plot(I);  title('Original Signal');
figure(fig_D2);  subplot(512); plot(I5); title('Denoised by D2, iteration = 100');
figure(fig_D2);  subplot(513); plot(I6); title('Denoised by D2, iteration = 1000');
figure(fig_D2);  subplot(514); plot(I7); title('Denoised by D2, iteration = 10000');
figure(fig_D2);  subplot(515); plot(I8); title('Denoised by D2, iteration = 100000');

