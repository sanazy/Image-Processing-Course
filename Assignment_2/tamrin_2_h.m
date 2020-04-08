clc 
close all
clear all

scale = 10;
f = imread ('interpolation\street2.jpg');
f = rgb2gray(f);
imshow (f);
title('Original Image');

g = imcrop (f);
imshow(g);
title('Cropped Image');

%% Neighborhood Interpolation
neighbor(g,scale);
%% Bilinear Interpolation
bilinear (g,scale);
%% Spline Interpolation
spline(g,scale);
