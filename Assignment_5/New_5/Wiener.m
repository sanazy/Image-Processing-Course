%% Wiener Filter
function [fhat] = Wiener(K,f,G,H)
    
    [M,N] = size(f);
    for u = 1:M
        for v = 1:N
            Fhat(u,v) = H(u,v)'*G(u,v)/(abs(H(u,v))^2 + K); 
        end
    end
 
    %% Inverse Fourier Transform of Reconstructed Image
    fhat = ifft2(Fhat);
    fhat = real(fhat);
    
end
