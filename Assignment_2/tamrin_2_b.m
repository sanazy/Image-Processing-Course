clc
close all
clear all

M = 400;
N = 400;
f = zeros(M,N);

for m = 1:M
   for n = 1:N
        d = sqrt((m - M/2)^2 + (n - N/2)^2);
        val = 2;
        f(m,n) = cos((2*pi/10) * val * d);
   end
end

figure;
imshow (f,[]);
title ('Original Image');

%% Neighborhood Interpolation
neighbor(f,1);
%% Bilinear Interpolation
bilinear (f,0.9);
%% Spline Interpolation
spline(f,0.7);