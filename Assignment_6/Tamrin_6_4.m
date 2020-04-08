%% Clear Enviroment
clc
close all
clear all

%% Image : f
M = 200;
N = 200;
f = zeros(M,N);
A = 10;

for m = 21:20:M
    f(m:m+19,:) = f(m-20:m-1,:) + A; 
end

%% Image : fprime
fprime = f + f';
[M,N] = size(fprime);

%% Pseudocolor functions
aux_B = zeros(256,1);  aux_B(1:31) = 255;
aux_G = zeros(256,1); aux_G(32:61) = 255;
aux_R = zeros(256,1); aux_R(62:91) = 255;

%% PseudoColor
R = zeros(M,N);
G = zeros(M,N);
B = zeros(M,N);
for i = 1:M
	for j = 1:N
		r = fprime(i,j);
        R(i,j) = aux_R(r+1);
        G(i,j) = aux_G(r+1);
        B(i,j) = aux_B(r+1);
	end
end
%% Concatenate all RGB Matric
I = cat(3,R,G,B);

%% Plot the Result
figure; 
plot(aux_B/255,'b--'); axis tight; hold on; 
plot(aux_G/255,'g-.'); axis tight; hold on;
plot(aux_R/255,'r'); axis tight; legend('Blue','Green','Red');
xlim([1 120]); ylim([0 1.1]);

figure; imshowpair(fprime,I,'montage'); 
title('f+f^T                            Psudocolored Image');

