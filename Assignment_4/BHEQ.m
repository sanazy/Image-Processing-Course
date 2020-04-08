%% Bi-Histogram Equalization
function [g] = BHEQ(f)
    
    [M,N] = size(f);    
    %% PDF
    o_mean = round(mean(f(:)));                                                                            
    h_l = zeros(1,256);
    h_u = zeros(1,256);
    for m = 1:M
        for n = 1:N
            r = round(f(m,n));
            if r <= o_mean
                h_l(r+1) = h_l(r+1) + 1;
            else
                h_u(r+1) = h_u(r+1) + 1;
            end
        end
    end

    %% NORMALIZED HISTOGRAM OR PDF                                                                          
    nh_l = h_l/sum(h_l);
    nh_u = h_u/sum(h_u);
    
    %% CDF
    hist_l_cdf = zeros(1,256);
    hist_u_cdf = zeros(1,256);
    hist_l_cdf(1) = nh_l(1);
    hist_u_cdf(1) = nh_u(1);
    for k = 2:256
       hist_l_cdf(k) =  hist_l_cdf(k-1) + nh_l(k);
       hist_u_cdf(k) =  hist_u_cdf(k-1) + nh_u(k);
    end
    
    %% Image Remapping                                                                                  
    a = hist_u_cdf(1);
    for k = 2:256
        if k <= o_mean
            F(k) = hist_l_cdf(k);
        else
            F(k) = hist_u_cdf(k) + (1-a);
        end    
    end
    F = F/2;
%     hold on; plot(F,'r');
    
    for m = 1:M
        for n = 1:N
            r = f(m,n);
            g(m,n) = F(r+1);
        end
    end
    
end