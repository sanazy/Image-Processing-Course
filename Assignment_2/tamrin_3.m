clc
clear all
close all

f = imread ('interpolation\baby2.jpg');
f = rgb2gray(f);
figure;
imshow (f);
title('Original Image');

num = 14;
[M,N] = size(f);

%% Uniform Quantization

level = 14;
qnum = round (256/level);


for m = 1: M
    for n = 1:N
        r = f(m,n);
        g(m,n) = fix(r/qnum);
    end  
end

subplot (1,2,1);
imshow (g,[]);
title('Uniform Quantized Image');

%% Max-Loyd Quantization 

% initialize tk
L = 20;
t = zeros(1,L);
tt = zeros(1,L);
r = zeros(1,L);
h = zeros(1,L);

for k = 1:L
    t(k) = k*round(256/L);
end

bool = 1; 
iter = 0;

% determine PDF
h = zeros (1,256);
for m = 1 : M
    for n = 1:N
        val = f(m,n);
        h(val+1) = h(val+1)+1;
    end
end

while (bool) 
    iter = iter +1;
    
    % determine rk
    r(L) = 255;
    r(1) = 0;
    for k = 2:L-1
        v = h(t(k):t(k+1));
        s = sum(v);
        p = v/s;
        num = p*(t(k):t(k+1))';
        r(k) = num/sum(p);
    end
    r = round(r);
    
    % update tk
    tt(1) = t(1);
    for k = 2:L
       tt(k) = (r(k-1) + r(k)) /2 ;
    end
    % check stopping criteria
    epsilon = sum ((tt(k)-t(k)).^2);
    if (epsilon < 0.01 || iter >= 1000)
       fprintf('r : ');
       fprintf('%d, ',r);
       fprintf('\nt : ');
       fprintf('%d, ',tt);
       stem(tt,r);
       bool = 0;
       break
    end
    
    tt(L) = 255;
    t = round(tt);
end

new_img = zeros([M N]);
for i = 1:M
    for j = 1:N
        val = f(i,j);
        app_t = find(t >= val);
        new_val = r(app_t(1));
        new_img(i,j) = new_val;
    end
end

subplot (1,2,2);
imshow(new_img,[]);
title('Nonuniform Quantized Image');


