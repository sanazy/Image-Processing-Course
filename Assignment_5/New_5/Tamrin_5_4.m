%% Part 4
%% Clear Enviroment
clc
close all
clear all
 
%% Define Size of Window
M = 318; N = M;
 
%% Square_1
square1 = zeros(M,N);
square1(1:M/2-1,1:N/2-1) = 1;
square1(M/2+1:M,N/2+1:N) = 1;
 
%% Square_2
square2 = ones(M,N);
square2(1:M/2,1:N/2) = 0;
square2(M/2+1:M,N/2+1:N) = 0;
 
%% f1 & f2
[f1,f2] = Triangle(M,N);
 
%% Triangle_1 & Triangle_2
 M = M*2; N = M;
 [triangle1,triangle2] = Triangle(M,N);
 
%% Z1 to Z4
z1 = f1.*square1;
z2 = f1.*square2;
z3 = f2.*square1;
z4 = f2.*square2;
 
%% Y11 to Y24
[M,N] = size(triangle1);
MM = M/4; NN = N/4;
for i = -MM:MM-1
    for j = -NN:NN-1
        y11(i+MM+1,j+NN+1) = triangle1(i+j+MM+NN+1 , j+MM+NN+1);
        y12(i+MM+1,j+NN+1) = triangle1(i-j+MM+NN+1 , j+MM+NN+1);
        y13(i+MM+1,j+NN+1) = triangle1(i  +MM+NN+1 , i+j+MM+NN+1);
        y14(i+MM+1,j+NN+1) = triangle1(i  +MM+NN+1 ,-i+j+MM+NN+1);
        
        y21(i+MM+1,j+NN+1) = triangle2(i+j+MM+NN+1 , j+MM+NN+1);
        y22(i+MM+1,j+NN+1) = triangle2(i-j+MM+NN+1 , j+MM+NN+1);
        y23(i+MM+1,j+NN+1) = triangle2(i  +MM+NN+1 , i+j+MM+NN+1);
        y24(i+MM+1,j+NN+1) = triangle2(i  +MM+NN+1 ,-i+j+MM+NN+1);
    end
end
 
%% Q1 to Q8
q1 = y11.*square2;  quinqunx(:,:,1) = q1;
q2 = y12.*square1;  quinqunx(:,:,2) = q2;
q3 = y13.*z4;       quinqunx(:,:,3) = q3;
q4 = y14.*z3;       quinqunx(:,:,4) = q4;
q5 = y21.*z2;       quinqunx(:,:,5) = q5;
q6 = y22.*z1;       quinqunx(:,:,6) = q6;
q7 = y23.*square2;  quinqunx(:,:,7) = q7;
q8 = y24.*square1;  quinqunx(:,:,8) = q8; 
 
%% Read Input
retina = imread('retina1.jpg');
retina = rgb2gray(retina);
retina = im2double(retina);
[M,N] = size(retina);
 
%% Noisy Retinal
noisy_retina = retina + 0.1*randn(M,N);
 
%% Denoised Retina
x = noisy_retina(:,77:394);
[M,N] = size(x);
X = fft2(x);
X = fftshift(X);
 
retina_sum = zeros(M,N);
figure;
for k = 1 : 8
    partial_X = X .* quinqunx(:,:,k);
    partial_x = real(ifft2(ifftshift(partial_X)));
    retina_sum = retina_sum +  partial_x;
    subplot(2,4,k); imshow(partial_x,[]); title(['filtered retina for k = ', num2str(k)]); 
end
 
%% Plot the Results
fig_basic_4 = figure; subplot(2,2,1); imshow(square1);   title('Square1');
figure(fig_basic_4);  subplot(2,2,2); imshow(square2);   title('Square2');
figure(fig_basic_4);  subplot(2,2,3); imshow(triangle1); title('Triangle1');
figure(fig_basic_4);  subplot(2,2,4); imshow(triangle2); title('Triangle2');
 
fig_qq_4 = figure;  subplot(2,2,1); imshow(z1); title('z1');
figure(fig_qq_4);   subplot(2,2,2); imshow(z2); title('z2');
figure(fig_qq_4);   subplot(2,2,3); imshow(z3); title('z3');
figure(fig_qq_4);   subplot(2,2,4); imshow(z4); title('z4');
 
fig_basic_8 = figure; subplot(2,4,1); imshow(y11); title('y11');
figure(fig_basic_8);  subplot(2,4,2); imshow(y12); title('y12');
figure(fig_basic_8);  subplot(2,4,3); imshow(y13); title('y13');
figure(fig_basic_8);  subplot(2,4,4); imshow(y14); title('y14');
figure(fig_basic_8);  subplot(2,4,5); imshow(y21); title('y21');
figure(fig_basic_8);  subplot(2,4,6); imshow(y22); title('y22');
figure(fig_basic_8);  subplot(2,4,7); imshow(y23); title('y23');
figure(fig_basic_8);  subplot(2,4,8); imshow(y24); title('y24');
 
fig_qq_8 = figure; subplot(2,4,1); imshow(q1); title('q1');
figure(fig_qq_8);  subplot(2,4,2); imshow(q2); title('q2');
figure(fig_qq_8);  subplot(2,4,3); imshow(q3); title('q3');
figure(fig_qq_8);  subplot(2,4,4); imshow(q4); title('q4');
figure(fig_qq_8);  subplot(2,4,5); imshow(q5); title('q5');
figure(fig_qq_8);  subplot(2,4,6); imshow(q6); title('q6');
figure(fig_qq_8);  subplot(2,4,7); imshow(q7); title('q7');
figure(fig_qq_8);  subplot(2,4,8); imshow(q8); title('q8');
 
fig_retina = figure; subplot(1,2,1); imshow(x,[]); title('Noisy Retina');
figure(fig_retina);  subplot(1,2,2); imshow(retina_sum,[]); title('Denoised Retina');
