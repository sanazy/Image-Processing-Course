%% Binzarization using Sauvola algorithm
function [g] = Sauvola(f,W)

    %% Variables
    K = 0.5;
    WW = 2*W+1; 
    R = 128;
    [M,N,ind] = size(f);
    
    %% check whether input is rgb
    if ind ==3
        f = rgb2gray(f);
    end
    f = im2double(f);

    %% Zero-padding the Image
    MM = M+2*W;
    NN = N+2*W;
    ff = zeros(M+2*W,N+2*W);
    for m = 1:M
        for n = 1:N
            ff(m+W,n+W) = f(m,n);
        end
    end  

    %% Take Integral Image from input
    f1 = IntegImg(ff);
    f2 = ff.^2;
    f3 = IntegImg(f2);

    %% Calculate Sauvola Parameters
    g = zeros(MM,NN);
    for m = W+2:MM-W
        for n = W+2:NN-W 
            %% find mean
            S  = f1(m+W,n+W) - f1(m+W,n-W) - f1(m-W,n+W) + f1(m-W,n-W); 
            Ave = S/(WW * WW); 
            %% find simga
            SS = f3(m+W,n+W) - f3(m+W,n-W) - f3(m-W,n+W) + f3(m-W,n-W);
            sigma2 = (1/W^2).*SS - (Ave^2);
            sigma = sqrt(sigma2);
            %% find threshold
            T = Ave * (1 + K*((sigma/R)-1));
            %% compare every pixels in one block with threshold
            if ff(m,n) > T
                g(m,n) = 1;
            end  
        end
    end
    
end
