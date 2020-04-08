function [] = bilinear (f,scale)

    [M,N] = size(f);
    deltax = 1 / scale;
    deltay = deltax;
    
    p = 0;
    for m =1:deltax:M-1
        p = p+1;
        q = 0;
        for n = 1:deltay:N-1
            q = q+1;
            mm = fix(m);
            nn = fix(n);
            dx = m - mm;
            dy = n - nn;
            p1 = f(mm,nn)*(1-dx) + f(mm+1,nn)*dx;
            p2 = f(mm+1,nn+1)*dx + (1-dx)*f(mm,nn+1);
            g(p,q) = dy*p2 + (1-dy)*p1;
        end 
    end
    
    figure;
    %subplot(1,3,2);
    imshow (g);
    title(['Bilinear Interpolation of Image, Scale = ' num2str(scale)]);
end