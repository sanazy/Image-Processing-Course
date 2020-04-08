%% Part 3
%% Clear Enviroment 
clc
clear all
close all

%% Read Input
cubes = imread('cubes.jpg');
cubes = rgb2gray(cubes);
cubes = im2double(cubes);
maxVal = max(max(cubes));
[M,N] = size(cubes);
figure; imshow(cubes);
title('Gray Scale of Original Image');

%% Gamma-Correction 
gamma = 0.3; 
for m = 1:M
    for n = 1:N
        temp = maxVal^(1-gamma);
        gamma_corrected(m,n) = temp .* (cubes(m,n)^ gamma);     
    end
end
figure; imshow(gamma_corrected);
title(['Gamma Corrected Image, \gamma = ', num2str(gamma)]);

%% Gausiian Noise
noisy_image = gamma_corrected + 0.2*randn(M,N);
figure; imshow(noisy_image);
title('Gaussian Noise Added to the Image');

%% Determine Window
W = 11;
W2 = 1/(W^2);
rect_window(1:W,1:W) = W2;

%% Zero Padding
zeroPad_noisy_image = [zeros(W,N+2*W);zeros(M,W),noisy_image,zeros(M,W);zeros(W,N+2*W)];
[MM,NN] = size(zeroPad_noisy_image);

%% Denoising with Avarage Window
a = ceil(W/2);
b = fix(W/2);
for m = a:MM-b
    for n = a:NN-b
        temp = zeroPad_noisy_image(m-b:m+b,n-b:n+b).*rect_window;
        denoise_rect(m,n) = sum(sum(temp));
    end
end
figure; imshow(denoise_rect);
title('Denoised Image with Rectangle Window');

%% Crop the Lamp
% cropped_lamp = imcrop(denoise_rect);
m1 = 95;  m2 = 140;
n1 = 218; n2 = 335;
cropped_lamp_rect = denoise_rect(m1:m2 , n1:n2);
noise_lamp_rect = std2(cropped_lamp_rect);
figure; imshow(cropped_lamp_rect);
title({'Cropped Image Denoised with Rectangle Window' ;...
      ['\sigma = ', num2str(noise_lamp_rect)]});

%% Denoising wiht Gausiian Window
W = 9;
bool = 1;
iter = 0;

while (bool)
    iter = iter + 1;
    %% Determine Window
    W = W + 2;
    gauss_window = fspecial('gaussian',W,W/6);

    %% Zero Padding
    zeroPad_noisy_image = [zeros(W,N+2*W);zeros(M,W) , noisy_image , zeros(M,W);zeros(W,N+2*W)];
    [MM,NN] = size(zeroPad_noisy_image);

    %% Denoising with Gausiian Window
    a = ceil(W/2);
    b = fix(W/2);
    
    %% Convolve to the Gaussian Window
    for m = a:MM-b
        for n = a:NN-b
            temp = zeroPad_noisy_image(m-b:m+b,n-b:n+b).*gauss_window;
            denoise_gauss(m,n) = sum(sum(temp));
        end
    end
    
    cropped_lamp_gauss = denoise_gauss(m1+(iter*2):m2+(iter*2), n1+(iter*2):n2+(iter*2));
    noise_lamp_gauss = std2(cropped_lamp_gauss);
    epsilon = abs(noise_lamp_rect - noise_lamp_gauss); 
    
    if ( epsilon < 0.001)
        bool = 0;
        figure; imshow(cropped_lamp_gauss);
        title({'Cropped Image Denoised with Gaussian Window' ; ...
              ['Window Size = ' , num2str(W)] ;...
              ['\sigma = ' , num2str(noise_lamp_gauss)]});
    end 
end
figure; imshow(denoise_gauss);
title('Denoised Image with Gaussian Window');
