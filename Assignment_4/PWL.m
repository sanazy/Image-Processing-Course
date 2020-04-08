%% Piecewise Linear Function
function [g] = PWL(f,a,b)

    [M,N] = size(f);     
    %% pdf
    h = zeros(1,256);
    for m = 1:M
        for n = 1:N
            r = round(f(m,n));
            h(r+1) = h(r+1) + 1;
        end
    end
    nh = h/sum(h);

    %% CDF
    F = zeros(1,256);
    F(1) = nh(1);
    for k = 2:256
        F(k) = F(k-1) + nh(k);
    end
    figure ; plot (255*F);
   
    %% Piecewise Linear
    F = zeros(1,256);
    for r = 1:256
        if r <= a(1)
            m = b(1)/a(1);
            F(r) = m * r;
        elseif r > a(1) && r <= a(2)
            m = (b(2)-b(1)) / (a(2)-a(1));
            F(r) = m * (r - a(1)) + b(1);
        else 
            m = (256-b(2)) / (256-a(2));
            F(r) = m * (r - a(2)) + b(2);
        end
    end
    hold on; plot(F,'m--');
    title('CDF of Image(blue), PWL of Image(dashed)');

    %% Image Remapping  
    for m = 1:M
        for n = 1:N
            r = f(m,n);
            g(m,n) = F(r)/256;
        end
    end
    
end
