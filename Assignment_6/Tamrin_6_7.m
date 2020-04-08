%% Clear Enviroment
clc
clear all
close all

%% Original Image
f = imread('fence.jpg');

%% Sauvola Binarization
g = Sauvola(f,12);

%% Dilating
s = strel('rectangle',[30 1]);
dilate = imdilate(g,s);

%% Eroding
s = strel('rectangle',[30 2]);
erote = imerode(dilate,s);

%% Plot the Results
figure; imshowpair(g,erote,'montage');
title('Binary Image of Fence                                        Detected Vertical Fences');



