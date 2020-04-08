function [] = Sethian(f,num_fig)

    f = im2double(f);

    h = fspecial('gaussian',3,3/6);
    f = imfilter(f,h);

    [fx,fy] = gradient(f);
    grad_mag = sqrt(fx.^2 + fy.^2);
    G_M = 1+20*grad_mag;
    p = double(1./G_M);

    [M,N] = size(f);
    phi = ones(M,N);
    Q = min(M,N);
    for m = 1:M
        for n = 1:N
            D = sqrt((m-fix(M/2))^2+(n-fix(N/2))^2);
            if D <= fix(Q/2)-5
                phi(m,n) = -1;
            end
        end
    end

    e = 0.752;
    for t = 1:100
        narro = find(phi>-1 & phi<1);
        phi(narro) = phi(narro) + e*p(narro);
        figure(num_fig); imshow(f,[]); hold on
        z = contour(phi,[0,0],'r','LineWidth',2); title(['number of iterations = ',num2str(t)]);
        pause(.05);
        phi(phi>0) = 1;
        phi(phi<=0) = -1;
        phi = double((phi > 0).*(bwdist(phi < 0)-0.5) - (phi < 0).*(bwdist(phi > 0)-0.5));
    end
     
end
     