%% CLS Filter
function [fhat] = CLS(sigma,gamma,iter,a,b,f,G,H)

    [M,N] = size(f);
    norm_n = M * N * sigma^2;
   
    p = zeros(M,N);
    L = [1  1  1
         1 -8  1
         1  1  1];
    p(1:3,1:3) = L;
    P = fft2(p);

    for t = 1:iter
        for u = 1:M
            for v = 1:N
                Fhat(u,v) = H(u,v)'*G(u,v)/(abs(H(u,v)).^2 + gamma*abs(P(u,v)^2));
            end
        end
%         norm_val = norm(G - H.*Fhat);
%         if norm_val > norm_n + a
%             gamma = gamma - b;
%         elseif norm_val < norm_n - a
%             gamma = gamma + b;
%         else
%             break;
%         end
    end
    fhat = real(ifft2(Fhat));
    
end