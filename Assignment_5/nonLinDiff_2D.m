function [I] = nonLinDiff_2D(I,type,iter,dt,dx,K,alfa)
    
    k= dt/(dx^2);
    [M,N] = size(I);
    
    for t = 1:iter
        for m = 2:M-1
            for n = 2:N-1
                dI(1) = I(m-1,n-1)-I(m,n);
                dI(2) = I(m-1,n)-I(m,n);
                dI(3) = I(m-1,n+1)-I(m,n);
                dI(4) = I(m,n-1)-I(m,n);
                dI(5) = I(m,n+1)-I(m,n);
                dI(6) = I(m+1,n-1)-I(m,n);
                dI(7) = I(m+1,n)-I(m,n);
                dI(8) = I(m+1,n+1)-I(m,n);
                if type ==1
                    for i = 1:8
                        D(i) = 1/(1+(abs(dI(i))/K)^(alfa+1));
                    end
                elseif type ==2
                    for i = 1:8
                        D(i) = exp(-abs((dI(i)/K)^(alfa+1)));
                    end
                end     
                I(m,n) = I(m,n) + k*(D*(dI'));
            end
        end
    end   
    
end