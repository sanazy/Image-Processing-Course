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
sigma_gauss = std2(crop_gauss);
 
%% Non-Linear Diffusion Parameters 
alfa=1; dy=1; dx=1; dt=0.125; K=0.1;
 
%% Using D1 FIlter
iter1 = 0;
g1 = g;
while 1
    iter1 = iter1 + 1;
    g1 = nonLinDiff_2D(g1,1,1,dt,dy,dx,K,alfa);
    crop_nonLin_1 = g1(m(1)-W:m(2)-W , n(1)-W:n(2)-W);
    sigma_nonLin_1 = std2(crop_nonLin_1);
    epsilon1 = abs(sigma_nonLin_1 - sigma_gauss);
    if epsilon1 < 0.001 
        break;
    end
end
 
%% Using D2 FIlter
iter2 = 0;
g2 = g;
while 1
    iter2 = iter2 + 1;
    g2 = nonLinDiff_2D(g2,2,1,dt,dy,dx,K,alfa); 
    crop_nonLin_2 = g2(m(1)-W:m(2)-W , n(1)-W:n(2)-W);
    sigma_nonLin_2 = std2(crop_nonLin_2);
    epsilon2 = abs(sigma_nonLin_2 - sigma_gauss);
    if epsilon2 < 0.001 
        break;
    end  
end
 
%% Output
fprintf('sigma gauss = %d\n', sigma_gauss);
fprintf('sigma nonLin1 = %d\n', sigma_nonLin_1);
fprintf('sigma nonLin2 = %d\n', sigma_nonLin_2);
 
%% Plot
figure; imshow(g);  title('Noisy Image');
figure; imshow(x);  title('Denoised Image using Gaussian Window');
figure; imshow(g1); title(['Nonlinear Diffusion : Type 1, Number of Iteration : ', num2str(iter1)]);
figure; imshow(g2); title(['Nonlinear Diffusion : Type 2, Number of Iteration : ', num2str(iter2)]);
