function [ BW ] = SUSAN( f, T )
    
    %% Image size
    f = double(f);
    [M,N] = size(f);
    T = T / 255;
    %% Create circular mask
    
    C_msk = [ 0 1 1 1 0 
              1 1 1 1 1 
              1 1 1 1 1 
              1 1 1 1 1 
              0 1 1 1 0];

    W = size(C_msk,1);
    n_max = sum(sum(C_msk));
    hW = (W-1)/2;
    
    %% Initial edge respone
    R = zeros(M,N);
    MX = zeros(M,N);
    MY = zeros(M,N);
    MXY = zeros(M,N);
    
    %% Theta matrix
    theta = zeros(M,N);
    
    %% Process each pixel
    for m = hW+1 : M-hW
       for n = hW+1 : N-hW
           %cut the USAN Area
           c = f(m-hW:m+hW, n-hW:n+hW);
           %compute similar pixels
           c = abs(c - c(hW,hW));
           c = (c < T);
           %apply circular mask
           c = c .* C_msk;
           cnt = sum(sum(c));
           %initial edge response
           r = (3/4)*n_max - cnt;
           if(r > 0), R(m,n) = r; else R(M,N) = 0; end
           %compute moment
           if R(m,n) == 0, continue; end
           x0 = hW + 1;
           y0 = hW + 1;
           Mx  = 0;
           My  = 0;
           Mxy = 0;
           for i = 1 : W
               for j = 1 : W
                   Mx =   Mx + (i-x0)*(i-x0)*c(i,j);
                   My =   My + (j-y0)*(j-y0)*c(i,j);
                   Mxy = Mxy + (i-x0)*(j-y0)*c(i,j);
               end
           end
           MX(m,n) = Mx;
           MY(m,n) = My;
           MXY(m,n) = Mxy;
           %compute theta
           if Mxy >= 0, sign = 1; else sign = -1; end
           theta(m,n) = sign * atan(My/Mx);
           %adjust theta
           if theta(m,n) < 0, theta(m,n) = theta(m,n) + pi; end
           %rad to degree
           theta(m,n) = theta(m,n)*180/pi;
           %quantize theta
           theta(m,n) = 45 * round(theta(m,n)/45);
       end
    end
    
    %% Non-Max Suppression
    BW = zeros(M,N);
    for m = 2 : M - 1
       for n = 2 : N - 1
           if(R(m,n) == 0 || theta(m,n) == -1), continue; end
           r1 = 0; c1 = 0;
           r2 = 0; c2 = 0;
           if theta(m,n) == 0
               r1 = 0; c1 = -1;
               r2 = 0; c2 = 1;
           end
           if theta(m,n) == 45
               r1 = -1; c1 = -1;
               r2 = 1; c2 = 1;
           end
           if theta(m,n) == 90
                r1 = -1; c1 = 0;
                r2 = 1; c2 = 0;
           end
           if theta(m,n) == 135
               r1 = -1; c1 = 1;
               r2 = 1; c2 = -1;
           end
           
           if R(m,n) > R(m+r1,n+c1) && R(m,n) > R(m+r2,n+c2)
               BW(m,n) = 1;
           end
       end
    end
    
end

