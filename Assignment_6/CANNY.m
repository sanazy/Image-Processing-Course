function [R] = CANNY(f,W,sig,Th,Tl)
    
    [M,N] = size(f);
    %% Gaussian Filter
    h_gauss = fspecial('gaussian',W,sig);
    f_gauss = imfilter(f,h_gauss,'replicate');
    
    %% Diffrential
    sobel_mask = [-1 -2 -1;0 0 0;1 2 1];
    diff_x = imfilter(f_gauss,sobel_mask' ,'replicate');
    diff_y = imfilter(f_gauss,sobel_mask  ,'replicate');
    
    %% Magnitude of Gradient
    grad = sqrt(diff_x.^2 + diff_y.^2);
    
    %% Angle of Gradient
    theta = atan(diff_y./diff_x) * 180/pi;
    theta = theta + (theta < 0)*180;
    theta = 45 * round(theta / 45);
    
    %% Non-Maximum Suppresion
    Mat = zeros(M,N);
    for m = 2:M-1
        for n = 2:N-1
            if theta(m,n) == 0 || theta(m,n) == 180 
                if (grad(m,n) > grad(m,n+1) && grad(m,n) > grad(m,n-1))
                    Mat(m,n) = grad(m,n); 
                end
            end
            if theta(m,n) == 45
                if (grad(m,n) > grad(m+1,n+1) && grad(m,n) > grad(m-1,n-1))
                    Mat(m,n) = grad(m,n); 
                end  
            end
            if theta(m,n) == 90
                if (grad(m,n) > grad(m+1,n) && grad(m,n) > grad(m-1,n))
                    Mat(m,n) = grad(m,n); 
                end
            end
            if theta(m,n) == 135
                if (grad(m,n) > grad(m+1,n-1) && grad(m,n) > grad(m-1,n+1))
                    Mat(m,n) = grad(m,n);                    
                end                
            end
        end
    end

    %% Thresholding
    %Strong edge pixels
    R = Mat > Th;
    %Weak edge pixels tracking
    cont = 1;
    while(cont)
        cont = 0;
        for m = 2:M-1
            for n = 2:N-1
                if R(m,n) == 1
                    if Mat(m-1,n-1) > Tl && R(m-1,n-1) == 0,     R(m-1,n-1) = 1; cont = 1;     end
                    if Mat(m-1,n)   > Tl && R(m-1,n)   == 0,     R(m-1,n)   = 1; cont = 1;     end
                    if Mat(m-1,n+1) > Tl && R(m-1,n+1) == 0,     R(m-1,n+1) = 1; cont = 1;     end
                    if Mat(m,n-1)   > Tl && R(m,n-1)   == 0,     R(m,n-1)   = 1; cont = 1;     end
                    if Mat(m,n+1)   > Tl && R(m,n+1)   == 0,     R(m,n+1)   = 1; cont = 1;     end
                    if Mat(m+1,n-1) > Tl && R(m+1,n-1) == 0,     R(m+1,n-1) = 1; cont = 1;     end
                    if Mat(m+1,n)   > Tl && R(m+1,n)   == 0,     R(m+1,n)   = 1; cont = 1;     end
                    if Mat(m+1,n+1) > Tl && R(m+1,n+1) == 0,     R(m+1,n+1) = 1; cont = 1;     end
                end
            end
        end
    end
end