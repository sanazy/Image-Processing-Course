%% Calculate threshold using iterative method
function [T]=iterative(f,error,maxiter)
    %% Read Input
    [M,N,ind] = size(f);
    % check whether input is rgb
    if ind==3
        f = rgb2gray(f);
    end
    
    %% Histogram
    h = zeros(1,256);
    for m=1:M
        for n=1:N
            r = f(m,n);
            h(r+1)= h(r+1)+1;
        end
    end
    
    %% Finding Threshold
    L = 256;
    T = L/2;
    iter = 0;
    bool = 1;
     
    while (bool)
        iter = iter +1;
        m1 = ((1:T-1)*h(1:T-1)')/sum(h(1:T-1));
        m2 = ((T:L)*h(T:L)')/sum(h(T:L));
        TT = fix((m1+m2)/2);
        epsilon = abs(T-TT);
        if (epsilon < error || iter >= maxiter)
            bool = 0;
            break;
        end
        T = TT;
    end
    
end