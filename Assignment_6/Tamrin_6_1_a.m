%% Clear Enviroment
clc
close all
clear all

%% Original Image
M = 200;
N = 200;
f = zeros(M,1);
A = 10;

for m = 21:20:M
    f(m:m+19,1) = f(m-20:m-1,1)+A; 
end

figure; plot(f); title('Stair on x axis');