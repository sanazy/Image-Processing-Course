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
    f(m:m+19,:) = f(m-20:m-1,:)+A; 
end

%% Define fprime
fprime = f + f';

%% Define g
n = 4*rand(200);
g = fprime + n;

%% Map g to [0,1]
min_g = min(min(g));
max_g = max(max(g));
for m = 1 : 200
    for n = 1 : 200
        g(m,n) = (g(m,n) - min_g) / (max_g - min_g);
    end
end

%% Susan Algorithm
T = 6;
B = SUSAN(g,T);

%% Show the Result
figure; imshowpair(g,B,'montage');
title('Image g                                Susan Algorithm on Image g');

