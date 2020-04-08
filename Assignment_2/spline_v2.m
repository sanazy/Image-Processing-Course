function [f1] = spline_v2 (f,scale)
        
    [N,M] = size(f);    
    deltax = 1 / scale;
    A = [-0.5 1.5 -1.5 0.5;
          1  -2.5  2  -0.5;
         -0.5 0    0.5 0  ;
          0   1    0   0 ];
    
    p = 0;
    for mm = 2:deltax:M-2
        p = p+1;
        m = fix(mm);
        dx = mm-m;
        
        v = f(m-1:m+2);
        g = A*v';
        f1(p) = g(1,1)*(dx)^3 + g(2,1)*(dx)^2 + g(3,1)*(dx) + g(4,1);
        
    end
end