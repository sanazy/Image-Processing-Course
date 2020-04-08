%% Local Histogram Equalization
function [g] = LHEQ(f,W)
       
    [M,N] = size(f);
    %% Image Zero-Padding  
    ff = [zeros(W,N+2*W);zeros(M,W),f,zeros(M,W);zeros(W,N+2*W)];
    [MM,NN] = size(ff);
    
    %% Image Remapping
    for i = W:MM-W
        for j = W:NN-W 
            %% PDF
            h = zeros(1,256);
            for m = i:i+W
                for n = j:j+W
                    r = ff(m,n);
                    h(r+1) = h(r+1) + 1;
                end
            end
            nh = h/sum(h);

            %% CDF
            F = zeros(1,256);
            for k = 2:256
                F(k) = F(k-1) + nh(k);
            end

            %% Remapping Each Window
            r = ff(i+round(W/2),j+round(W/2));
            g(i+round(W/2),j+round(W/2)) = F(r+1);
            
        end
    end
    
end