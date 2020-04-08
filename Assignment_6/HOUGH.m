function [rho,theta,hspace] = HOUGH(f)

    [M,N] = size(f);
    %% Theta Range
    dtheta = 0.5;
    theta = (0:dtheta:180-dtheta);
    theta_rad = theta*pi/180;
    ntheta = numel(theta_rad);
    %% rho Rage
    rlimit = ceil(sqrt(M^2 + N^2)) + 1;
    rho = (-rlimit:1:rlimit);
    nrho = numel(rho);
    %% Hough Space
    hspace = zeros(nrho, ntheta);
   
    %% Process binary image
    for m = 1 : M
        for n = 1 : N
            if f(m,n) == 1
               for th = 1 : ntheta
                   p = m*cos( theta_rad(th) ) + n*sin( theta_rad(th) );
                   p_ind = round(p) + rlimit + 1;
                   hspace(p_ind,th) = hspace(p_ind,th) + 1;
               end
            end
        end
    end
end