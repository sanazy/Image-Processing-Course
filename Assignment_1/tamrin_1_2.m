clc
clear all
close all

M = 400;
N = 400;
iter = 50;

z = zeros(M,N);
for m = 1:M
   for n=1:N
       for t = 1:iter
           mhat = (3*(m-1))/(M-1)- 2;
           nhat = (3*(n-1))/(N-1)- 1.5;
           c = mhat + 1i*nhat;
           z(t+1) = z(t)^2 + c;
           if (abs(z(t+1)) <= 2)
               f(m,n) = 0;
           else 
               f(m,n) = t;
           end  
       end
   end
end

x = ind2rgb(4*f , jet);
imshow(x);
