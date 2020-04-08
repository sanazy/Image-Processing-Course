%% Clear Enviroment
clc
close all
clear all
 
%% Part 2-b
f = imread('retina1.jpg');
f = rgb2gray(f);
f = im2double(f);
[M,N] = size(f);
g = f + 0.1*randn(M,N);
 
%% Non-Linear Diffusion
alfa=1; dx=1; dy=1; dt=0.025; K=0.08; iter=70;
y1 = nonLinDiff_2D(g,1,iter,dt,dy,dx,K,alfa);
alfa=1; dx=1; dy=1; dt=0.01; K=0.1; iter=100;
y2 = nonLinDiff_2D(g,2,iter,dt,dy,dx,K,alfa);
 
figure; imshow(g); title('Noisy Image');
figure; imshow(y1); title('Nonlinear Diffusion : Type 1');
figure; imshow(y2); title('Nonlinear Diffusion : Type 2');
