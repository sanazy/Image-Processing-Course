clc 
clear all
close all

%% Part 1
figure ();
Img = imread('img.jpg');
probDensFunc(Img);
title('PDF of arbitrary I');

%% Part 2
I1 = randn(200)+4;
I2 = 0.5 * randn(200)+10;
I = [I1,I2];
[M,N] = size (I);

minValue = min(min(I));
maxValue = max(max(I));

for m = 1:M
    for n = 1:N
        f(m,n) = ((I(m,n) - minValue) * 255) / (maxValue - minValue);
        f(m,n) = round(f(m,n));
    end
end

figure();
subplot(2,2,1);
hist(f);  
axis tight;
title('Histogram of [I1,I2]');

subplot(2,2,2);
probDensFunc(f);
axis tight;
title('PDF of [I1,I2]');

%% Part 3
I1 = randn(200)+4;
I2= 0.5 *randn (200)+10;
I = I1 + I2;

[M,N] = size (I)
minValue = min(min(I));
maxValue = max(max(I));

for m = 1:M
    for n = 1:N
        f(m,n) = ((I(m,n) - minValue) * 255) / (maxValue - minValue);
        f(m,n) = round(f(m,n));
    end
end

subplot(2,2,3);
hist(f); 
axis tight;
title('Histogram of I1+I2');

subplot(2,2,4);
probDensFunc(f);
axis tight;
title('PDF of I1+I2');
