clc
clear all
close all

%% part 1
x1 = ones(100,100);
subplot(2,2,1);
imshow (x1,[]);
title ('ones matrix');

%% part 2
x2 = zeros(100,100);
subplot(2,2,2);
imshow (x2,[]);
title ('zeros matrix');

%% part 3
x3 = magic(100);
subplot(2,2,3);
imshow (x3,[]);
title ('magic matrix');

%% part 4
x4 = eye(100);
subplot(2,2,4);
imshow (x4,[]);
title ('eye matrix');