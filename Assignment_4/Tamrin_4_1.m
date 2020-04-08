%% Clear Enviroment 
clc
clear all
close all

%% Part 1-a
%% Read Input - goat Image
goat = imread('goat.jpg');
goat = rgb2gray(goat);
% plot
figure; imshow(goat,[]);
title ('Original Image - Goat');
%% Read Input - lowcontrast3 Image
lowcontrast = imread('lowcontrast3.jpg');
lowcontrast = rgb2gray(lowcontrast);
% plot
figure; imshow(lowcontrast,[]);
title ('Original Image - Lowcontrast3');

%% Global Histogram
%% goat
global_goat = GHEQ(goat);
% plot
figure; imshow(global_goat,[]);
title ('Global Histogram Equalization - Goat');
%% lowcontrast3
global_lowcontrast = GHEQ(lowcontrast);
% plot
figure; imshow(global_lowcontrast,[]);
title ('Global Histogram Equalization - Lowcontrast3');

%% Bi-Histogram Equalization
%% goat
bihistogram_goat = BHEQ(goat);
% plot
figure; imshow(bihistogram_goat,[]);
title ('Bi-Histogram Equalization - Goat');
%% lowcontrast3
bihistogram_lowcontrast = BHEQ(lowcontrast);
% plot
figure; imshow(bihistogram_lowcontrast,[]);
title ('Bi-Histogram Equalization - Lowcontrast3');

%% Part_1_b
%% Local Histogram Equalization
%% window 13*13
local_goat_13 = LHEQ(goat,13);
% plot
figure; imshow(local_goat_13,[]);
title ('Local Histogram Equalization - Window 13*13');

%% window 27*27
local_goat_27 = LHEQ(goat,27);
% plot
figure; imshow(local_goat_27,[]);
title ('Local Histogram Equalization - Window 27*27');

%% Part_1_c
%% Piecewise Linear Function
a = [110 230];
b = [20  250];
piecewise_linear_goat = PWL(goat,a,b);
% plot
figure ; imshow(piecewise_linear_goat);
title(['(a1,b1)=(' num2str(a(1)) ',' num2str(b(1)) ')   '...
       '(a2,b2)=(' num2str(a(2)) ',' num2str(b(2)) ')']);    
