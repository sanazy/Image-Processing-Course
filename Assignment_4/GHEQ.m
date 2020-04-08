%% Global Histogram Equalization
function [g] = GHEQ(f)

    [M,N] = size(f);
    %% PDF
    h = zeros(1,256);
    for m = 1:M
        for n = 1:N
            r = round(f(m,n));
            h(r+1) = h(r+1) + 1;
        end
    end
%     figure; plot(h/(M*N));
    nh = h/sum(h);

    %% CDF
    F = zeros(1,256);
    F(1) = nh(1);
    for k = 2:256
        F(k) = F(k-1) + nh(k);
    end
%     figure; plot(F);

    %% Image Remapping  
    for m = 1:M
        for n = 1:N
            r = f(m,n);
            g(m,n) = F(r+1);
        end
    end
    
end
