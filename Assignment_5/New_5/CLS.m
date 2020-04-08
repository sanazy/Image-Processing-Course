%% CLS Filter
function [fhat] = CLS(sigma,gamma,iter,f,G,H)
 
    [M,N] = size(f);
    % Laplasian
    p = zeros(M,N);
    L = [1  1  1
         1 -8  1
         1  1  1];
    p(1:3,1:3) = L;
    P = fft2(p);
    % Filter
    for t = 1:iter
        for u = 1:M
            for v = 1:N
                Fhat(u,v) = H(u,v)'*G(u,v)/(abs(H(u,v)).^2 + gamma*abs(P(u,v)^2));
            end
        end
    end
    fhat = ifft2(Fhat);
    fhat = real(fhat);
    
end
