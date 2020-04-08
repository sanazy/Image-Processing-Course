function [] = spline (f,scale)
        
    [M,N] = size(f);    
    deltax = 1 / scale;
    deltay = deltax;
    g = zeros(M,4);
    g1 = zeros(4,1);
    A = [-.5 1.5 -1.5 .5;1 -2.5 2 -.5;-.5 0 .5 0;0 1 0 0];
    
    p = 0;
    for mm = 2:deltax:M-2
        p = p+1;
        q = 0;
        for nn = 2:deltay:N-2
            q = q+1;
            m = fix(mm);
            n = fix(nn);
            dx = mm-m;
            dy = nn-n;
            
            v = f(m-1:m+2,n-1);
            v = double(v);
            g(m,:) = A*v;
            f1(m,n-1) = g(m,1)*(dx)^3 + g(m,2)*(dx)^2 + g(m,3)*(dx) + g(m,4);
            
            v = f(m-1:m+2,n);
            v = double(v);
            g(m,:) = A*v;
            f1(m,n  ) = g(m,1)*(dx)^3 + g(m,2)*(dx)^2 + g(m,3)*(dx) + g(m,4);
            
            v = f(m-1:m+2,n+1);
            v = double(v);
            g(m,:) = A*v;
            f1(m,n+1) = g(m,1)*(dx)^3 + g(m,2)*(dx)^2 + g(m,3)*(dx) + g(m,4);
            
            v = f(m-1:m+2,n+2);
            v = double(v);
            g(m,:) = A*v;
            f1(m,n+2) = g(m,1)*(dx)^3 + g(m,2)*(dx)^2 + g(m,3)*(dx) + g(m,4);
            
            v1 = f1(m,n-1:n+2);
            v1 = double(v1);
            g1 = A*v1';
            
            I(p,q) = g1(1,1)*(dy)^3 + g1(2,1)*(dy)^2 + g1(3,1)*(dy) + g1(4,1);
            
        end 
    end
    
    figure;
    %subplot(1,3,3);
    imshow (I,[]);
    title(['Cubic Spline Interpolation Image, Scale = ' num2str(scale)]);
end