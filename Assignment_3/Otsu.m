%% Binzarization using Otsu algorithm
function [Threshold,f] = Otsu(f)
    %% Variables
    [M,N,ind] = size(f);
    h = zeros (1,256);
    L = 256;
    val = 1000000000;
    
    %% check whether input is rgb
    if ind==3
        f = rgb2gray(f);
    end
    
    %% histogram
    for m = 1 : M
        for n = 1:N
            r = f(m,n);
            h(r+1) = h(r+1)+1;
        end
    end
    S = sum(h);
    
    %% find the cost function of otsu
    for T = 1:256
        %% find summation
        s1 = sum(h(1:T));
        s2 = sum(h(T+1:L));
        %% find probability
        p1 = h(1:T)/s1;
        p2 = h(T+1:L)/s2;
        %% find mean
        m1 = (1:T)*p1';
        m2 = (T+1:L)*p2';
        %% find sigma 
        sigma1 = sum((h(1:T)-m1).^2)/s1;
        sigma2 = sum((h(T+1:L)-m2).^2)/s2;
        %% find cost function
        J(T) = s1/S*sigma1 +s2/S*sigma2;
        %% find minimun of the cost function
        if J(T) < val
            Threshold = T;
            val = J(T);
        else
            continue;
        end 
    end 

end 