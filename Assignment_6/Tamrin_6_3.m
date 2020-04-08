%% Clear Enviroment
clc
close all
clear all

% %% Train System
% num_people_train = 15;
% num_points = 10;
% index = 1;
% for i = 1:num_people_train
%     s = sprintf('Faces/Train/%d.jpg', i);
%     f = imread(s);
%     I = f;
%     I = im2double(I);
%     imshow(f);
% 
%     [m(i,:),n(i,:)] = ginput(num_points);
%     for j = 1:num_points
%         A(index,:) = impixel(f,m(i,j),n(i,j));
%         index = index + 1;
%     end
% end
% save('Faces/Train/A.mat','A'); close;

%% Load Train Matrix A
load('Faces/Train/A.mat');
NN = size(A,1);

%% Define Ahat
mean_A = mean(A);
Ahat(:,1) = (A(:,1) - mean_A(1));
Ahat(:,2) = (A(:,2) - mean_A(2));
Ahat(:,3) = (A(:,3) - mean_A(3));

%% Scatter Plot of Ahat
figure;
scatter3(Ahat(:,1),Ahat(:,2),Ahat(:,3));
title('Data Points'); xlabel('Red'); ylabel('Green'); zlabel('Blue');
figure;
subplot(1,3,1); scatter(Ahat(:,1),Ahat(:,2)); title('R-G');
subplot(1,3,2); scatter(Ahat(:,1),Ahat(:,3)); title('R-B');
subplot(1,3,3); scatter(Ahat(:,2),Ahat(:,3)); title('G-B');

%% Corolation Matrix
Zigma = (1/NN) * (Ahat' * Ahat);
ZigmaInverse = pinv(Zigma);

%% Show mean and corolation matrix in output
fprintf('Mean Vector = \n%d, %d, %d \n',mean_A(1),mean_A(2),mean_A(3));
[Msig,Nsig] = size(Zigma);
fprintf('Zigma Matrix = \n');
for i = 1:Msig
    for j = 1:Nsig
        fprintf('%d ',Zigma(i,j));
    end
    fprintf('\n');
end

%% Test System
test = figure;
clse = figure;
num_people_test = 16;
st = strel('disk',10);
for k = 1:num_people_test
    s = sprintf('Faces/Test/%d.jpg',k);
    I = imread(s);
    [M,N,Dim] = size(I);

    bin = zeros(M,N);
    D0 = 2.5;

    for i = 1:M
        for j = 1:N
            r = I(i,j,1);
            g = I(i,j,2);
            b = I(i,j,3);
            pixel = double([r g b]);
            D = sqrt((pixel - mean_A)*ZigmaInverse*((pixel-mean_A)'));
            if D < D0
                bin(i,j) = 1;
            end
        end
    end
    if k==16,    break;   end
    figure(test); subplot(4,4,k); imshowpair(I,bin,'montage');
    title(['Train:',num2str(k),'           Test:',num2str(k)]);
    figure(clse); subplot(4,4,k); imshowpair(I,imclose(bin,st),'montage');
    title(['Train:',num2str(k),'           Test:',num2str(k)]);
end

%% Family Image Just Used as Test, and Saved as 16.jpg
st = strel('disk',10);
fig1 = figure; imshowpair(I,bin,'montage');
title('Family Image                                         Binarized Family Image');
cls = imclose(bin,st);
fig2 = figure; imshowpair(I,imclose(bin,st),'montage');
title('Family Image                                         Imclosed Binarized Family Image');

I = im2double(I);
I1 = I(:,:,1) .* cls;
I2 = I(:,:,2) .* cls;
I3 = I(:,:,3) .* cls;
It = cat(3 , I1, I2 , I3);
fig3 = figure; imshowpair(I,It,'montage');
title('Family Image                                         Extracted Faces of Family Image');

