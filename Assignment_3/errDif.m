%% Error Diffusion
function [b] = errDif(f)
    
    [M,N,ind] = size(f);
    
    %% check whether input is rgb
    if ind ==3
        f = rgb2gray(f);
    end
    f = im2double(f);
    
    %% Zero-padding the Image
    MM = M + (8 - mod(M,8))*(mod(M,8) > 0);
    NN = N + (8 - mod(N,8))*(mod(N,8) > 0);
    ff = zeros(MM, NN);
    ff(1:M, 1:N) = f(1:M, 1:N);   

    %% Halftoning the Image
    h = [0   0    7/16
        3/16 5/16 1/16];
    
    for m = 2:M-1
        for n = 2:N-1
           b(m,n) = (ff(m,n) >= 0.5);
           e = b(m,n) - ff(m,n);
           s = e.*h;
           ff(m:m+1,n-1:n+1) = ff(m:m+1,n-1:n+1) - s ;  
        end 
    end
end
