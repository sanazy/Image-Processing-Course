%% Clear Enviroment
clc
close all
clear all

%% Part 2-a
f = imread('cat1.jpg');
f = rgb2gray(f);
f = im2double(f);
[M,N] = size(f);
g = f + 0.2*randn(M,N);

%% Denoising with Gausiian Window
W = 13;
% Gaussin window
gauss_window = fspecial('gaussian',W,W/6);
% Zero Padding
zeroPad_g = [zeros(W,N+2*W);zeros(M,W) , g , zeros(M,W);zeros(W,N+2*W)];
[MM,NN] = size(zeroPad_g);
% Gaussian filter
x = imfilter(zeroPad_g,gauss_window);
% cropped_lamp = imcrop(x);
m = [24 81];
n = [523 637];
crop_gauss = x(m(1):m(2) , n(1):n(2));
sigma_gauss = std2(crop_gauss)

%% Non-Linear Diffusion
alfa=1; dx=1; dt=0.125; K=0.1; iter=20;
y = nonLinDiff_2D(g,1,iter,dt,dx,K,alfa);
crop_nonLinDiff = y(m(1)-W:m(2)-W , n(1)-W:n(2)-W);
sigma_nonLinDiff = std2(crop_nonLinDiff)

%% Plot
figure; imshow(g); title('Noisy Image');
figure; imshow(crop_gauss); title('crop gauss');
figure; imshow(crop_nonLinDiff); title('crop nonlinear');
figure; imshow(x); title('Denoised Image using Gaussian Window');
figure; imshow(y); title('Denoised Image using Nonlinear Diffusion');
