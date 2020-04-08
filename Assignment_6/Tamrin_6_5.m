%% Clear Enviroment
clc
% clear all
close all

%% Background
f(1:300,1:300) = 20;

%% Circle 1
C1 = [120,120];
R1 = 80;
for m = 1:300
	for n = 1:300
		D = sqrt((m-C1(1))^2+(n-C1(2))^2);
		if D <= R1
			f(m,n) = 100;
		end		
	end
end

%% Circle 2
C2 = [100,200];
R2 = 50;
for m = 1:300
	for n = 1:300
		D = sqrt((m-C2(1))^2+(n-C2(2))^2);
		if D <= R2
			f(m,n) = 130;
		end		
	end
end

%% Square 
f(180-40:180+40,180-40:180+40) = 230;

%% Gaussian Filter
H = fspecial('gaussian',21,21/6); 
f_gauss = imfilter(f,H);

%% Show result
figure; imshowpair(f,f_gauss,'montag'); 
title('Original Image                            Gaussian Filtered');

%% Kass 
W = 3;
iter = 100;
KASS(f,W,iter,2);
KASS(f_gauss,W,iter,3);

%% Sethian and Oscher
Sethian(f,4);
Sethian(f_gauss,5);
