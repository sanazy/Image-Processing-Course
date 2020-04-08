function [I] = nonLinDiff_1D(I,type,iter,dt,dx,K,alfa)
    
    k= dt/(dx^2);
    L = length(I);
    for t = 1:iter
        for x = 2:L-1
            
            I1 = I(x-1)-I(x);
            I2 = I(x+1)-I(x);
            if type == 1
                D1 = 1/(1+(abs(I1)/K)^(alfa+1));
                D2 = 1/(1+(abs(I2)/K)^(alfa+1));
            elseif type == 2
                D1 = exp(-abs((I1/K)^(alfa+1)));
                D2 = exp(-abs((I2/K)^(alfa+1)));   
            end
            I(x) = I(x) + k*(D1*I1 + D2*I2);
        end
    end
        
end

