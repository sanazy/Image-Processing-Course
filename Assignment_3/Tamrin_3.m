%% All the parts of assignment 3 is written here

%% Clearing Enviroment
clc
clear all
close all

%% Part 1
%% Part 1-a
f = ones(100);
I = IntegImg(f);
figure; imshow(I,[]);
title('Integral Image of f=ones(100)');

%% Part 1-b
M = round (255/sqrt(2));
N = M;
for m=1:M
    for n=1:N
        g(m,n) = sqrt(m^2+n^2);
        g(m,n) = round(g(m,n));
    end
end
figure; imshow(g,[]);
title('Image with M = N = round(255/sqrt(2))');

%% Part 1-c
T1 = 127;
TH1 = g > T1;
figure; imshow(TH1);
title('Threshold with T =127');

%% Part 1-d
[T2] = iterative(g,0.01,1000);% epsilon = 0.01 , maximum iteration = 1000
TH2 = g > T2;
figure; imshow(TH2);
title(['Iterative Method, T = ' num2str(T2)]);

%% Part 1-e
% Reading text Image
f = imread('text_10.jpg');

% Sauvola Algorithm
S = Sauvola(f);
figure; imshow(S,[]);
title('Binarization with Sauvola Algorithm');
 
% Niblack Algorithm
N = Niblack(f);
figure; imshow(N,[]);
title('Binarization with Niblack Algorithm');

% OTSU Method
[T3,O1] = Otsu(f);
TH3 = O1 > T3;
figure; imshow(TH3,[]);
title(['Otsu Method, T = ' num2str(T3)]);

% Iterative Method
[T4] = iterative(f,0.01,1000);
TH4 = O1 > T4;
figure; imshow(TH4,[]);
title(['Iterative Method, T = ' num2str(T4)]);

%% Part 2
%% Part 2-a
% Error Diffusion
g = g/255;
err = errDif(g);
figure; imshow(err,[]);
title('Halftoning: Error Diffusion of round(255/sqrt(2))');

% Dot Diffusion
[dot] = dotDif(g);
figure; imshow(dot,[]);
title('Halftoning: Dot Diffusion of round(255/sqrt(2))');

%% Part 2-b
% Reading Baby Image
f = imread('baby2.jpg');

% Error Diffusion
[E1] = errDif(f);
figure; imshow(E1);
title('Error Diffusion of Baby Image');
E2 = imcrop(E1);
figure; imshow (E2);
title('Error Diffusion of Baby Forhead');

% Dot Diffusion
[D1] = dotDif(f);
figure; imshow(D1,[]);
title('Dot Diffusion of Baby Image');
D2 = imcrop(D1);
figure; imshow(D2);
title('Dot Diffusion of Baby Forhead');
