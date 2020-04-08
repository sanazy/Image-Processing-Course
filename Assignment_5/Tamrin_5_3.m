%% Part 3-a
%% Clear Enviroment
clc
close all
% clear all

%% Read Input
f = imread('spiral_92.png');
f = rgb2gray(f);
f = im2double(f);
[M,N] = size(f);
F = fft2(f);

%% Determine Noise: N(u,v) 
noise = 0.021*rand(M,N);
Noise = fft2(noise);

%% Determine Motion: H(u,v)
a = 5;
b = 20;
k1 = 2*pi/M;
k2 = 2*pi/N;

for u = 1:M
    for v = 1:N
        u1 = k1*u;
        v1 = k2*v;
        val = (a*u1+b*v1)/2;
        H(u,v) = (1/val) * exp(-1i*val) * sin(val);
    end
end
%% Degraded Image
G = H.*F + Noise; 
g = real(ifft2(G));

%% Wiener Filter
K = 0.001;
fhat1 = Wiener(K,f,G,H);

%% CLS Filter
iter = 1;
gamma = 0.0005;
sigma = 0.01;
% calc_sigma = imcrop(g);
% sigma = std2(calc_sigma);
fhat2 = CLS(sigma,gamma,iter,a,b,f,G,H);

%% Plot the Results 
figure; imshow(f,[]); title('Original Image');
figure; imshow(g,[]); title('Degraded Image with noise and motion');
figure; imshow(fhat1,[]); title('Reconstructed Image using Wiener Filter');
figure; imshow(fhat2,[]); title('Reconstructed Image using CLS Filter');


