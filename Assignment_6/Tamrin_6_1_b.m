%% Clear Environment
clc
close all
clear all

%% Original Image
M = 200;
N = 200;
f = zeros(M,N);
A = 10;

for m = 21:20:M
    f(m:m+19,:) = f(m-20:m-1,:) + A; 
end

%% Canny Edge Detector
W = 6;
sig = W/6;
Th = 0.05;
Tl = Th / 3; %canny recommendation : Th/Tl ~ 3 or 2 
R = CANNY(f,W,sig,Th,Tl);

%% Plot the Results
figure; imshowpair(f,R,'montage');
title('Original Image                         Canny Edge Detector Result');

