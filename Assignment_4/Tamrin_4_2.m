%% Clear the Enviroment
clc
close all
clear all

%% Creating the image
M = 200;
N = 300;
f = zeros(M,N);
f(100,:) = 1;
figure;imshow(f,[]); title('Original Image');

%% Relocating the origin
ff = zeros(M,N);
for i = 1:M
   for j = 1:N
      ff(i,j) = ((-1)^(i+j)) * f(i,j); 
   end
end

%% FFT
F = fft2(ff);
F = log(abs(F)+1);
figure; imshow(F, []); title('FFT of Image');

