function [] = neighbor (f,scale)

    [M,N] = size(f);
    deltax = 1 / scale;
    deltay = deltax;
    p = 0;
    for m =1:deltax:M
        p = p+1;
        q = 0;
        for n = 1:deltay:N
            q = q+1;
            m1 = round(m);
            n1 = round(n);
            g(p,q) = f(m1,n1);
        end 
    end
    
    figure;
    %subplot(1,3,1);
    imshow (g);
    title(['Neighbor Interpolation of Image, Scale = ' num2str(scale)]);
end