%% Clear Environment
clc
close all
%clear all

%% Define f
M = 200;
N = 200;
f = zeros(M,N);
A = 10;

for m = 21:20:M
    f(m:m+19,:) = f(m-20:m-1,:) + A; 
end

%% Define fprime
fprime = f + f';

%% Define g
n = 4*rand(200);
g = fprime + n;
min_g = min(min(g));
max_g = max(max(g));
for m = 1 : 200
    for n = 1 : 200
        g(m,n) = (g(m,n) - min_g) / (max_g - min_g);
    end
end

%% Canny Edge Detector
W = 6;
sig = W/6;
Th = 0.05;
Tl = Th / 3;
R = CANNY(g,W,sig,Th,Tl);

%% Plot the Results
figure; imshowpair(g,R,'montage'); 
title('Original Image                         Canny Edge Detector Result');


