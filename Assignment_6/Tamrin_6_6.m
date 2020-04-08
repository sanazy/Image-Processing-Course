%% Clear Enviroment
clc
close all
clear all

%% Make Image
f = zeros(300);
square = ones(100);
square = imrotate(square,45);
f(150-72:150+72,150-72:150+72) = square;

%% Canny Edge Detector
W = 6;
sig = W/6;
Th = 0.05;
Tl = Th / 3;
R = CANNY(f,W,sig,Th,Tl);

%% Hough Transform
[rho,theta,HH] = HOUGH(R);

%% Plot the Results
figure; imshowpair(f,R,'montage'); 
title('Original Image                                Canny Edge Detector');
figure; imagesc(theta,rho,HH); xlabel('Theta'); ylabel('Rho'); axis tight;
figure; mesh(theta,rho,HH); title('Hough Transform');


