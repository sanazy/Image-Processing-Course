function [M,N]= probDensFunc (I)   
    
    [M,N] =size(I);
    f = zeros (1,256);
    for m = 1 : M
        for n = 1:N
            r = I(m,n);
            f(r+1) = f(r+1)+1;
        end
    end
    plot (f/(M*N));  
    
end