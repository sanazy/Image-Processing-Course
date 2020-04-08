%% Clear Enviroment
clc
% close all
% clear all

%% Part 2-b
f = imread('retina1.jpg');
f = rgb2gray(f);
f = im2double(f);
[M,N] = size(f);
g = f + 0.1*randn(M,N);

%% Non-Linear Diffusion
alfa=1; dx=1; dt=0.125; K=0.05; iter=10;
y = nonLinDiff_2D(g,1,iter,dt,dx,K,alfa);

% figure; imshow(g); title('Noisy Image');
figure; imshow(y); title('Denoised Image using Nonlinear Diffusion');
