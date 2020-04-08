function [f1] = cubic_spline (f,scale)
        
    [N,M] = size(f);    
    deltax = 1 / scale;
    p = 0;
    for mm = 2:deltax:M-2
        p = p+1;
        m = fix(mm);
        dx = mm-m;
        %% Second Differential
        A = [5 1;1 4];
        index1 = f(m-1)-2*f(m)  +f(m+1);
        index2 = f(m)  -2*f(m+1)+f(m+2);
        Matrix = [6*index1 ; 6*index2]\A;
        %% Coeficients
        a = (Matrix(2) - Matrix(1))/6;
        b =  Matrix(1) / 2;
        c =  f(m+1) - f(m) - ((Matrix(2) + 2*Matrix(1))/6);
        d =  f(m);
        %% Output
        f1(p) = a*(dx)^3 + b*(dx)^2 + c*(dx) + d;
        
    end
end