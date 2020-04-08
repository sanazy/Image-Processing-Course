function [I] = nonLinDiff_2D(I,type,iter,dt,dy,dx,K,alfa)
    [M,N] = size(I);
    for t = 1 : iter
       %% compute grad. magnitude
       Grad = zeros(M,N);
       for m = dy+1 : M - dy
          for n = dx+1 : N - dx
              dyy = (I(m+dy,n) - I(m-dy,n)) / (2*dy);
              dxx = (I(m,n+dx) - I(m,n-dx)) / (2*dx);
              Grad(m,n) = sqrt(dyy^2 + dxx^2);
          end
       end
       %% compute g (diffusity function)
       g = zeros(M,N);
       for m = 1 : M
           for n = 1 : N
               if type == 1
                   g(m,n) = 1 / (1 + (Grad(m,n)/K)^(alfa + 1)); %D1
               else
                   g(m,n) = exp(-((Grad(m,n)/K)^(alfa+1))); %D2
               end
           end
       end
       %% compute changes for every pixel
       %% discretization of partial derivative
       D = zeros(M,N);
       for m = dy+1 : M - dy
          for n = dx+1 : N - dx
              g1 = ((g(m+dy,n) + g(m,n)) / (2*dy));
              g2 = ((g(m-dy,n) + g(m,n)) / (2*dy));
              g3 = ((g(m,n+dx) + g(m,n)) / (2*dx));
              g4 = ((g(m,n-dx) + g(m,n)) / (2*dx));
              chng =        ((g(m+dy,n) + g(m,n)) / (2*dy)) * I(m+dy,n);
              chng = chng + ((g(m-dy,n) + g(m,n)) / (2*dy)) * I(m-dy,n);
              chng = chng + ((g(m,n+dx) + g(m,n)) / (2*dx)) * I(m,n+dx);
              chng = chng + ((g(m,n-dx) + g(m,n)) / (2*dx)) * I(m,n-dx);
              chng = chng - (g1 + g2 + g3 + g4) * I(m,n);
              D(m,n) = chng;
          end
       end
       I = I + dt*D; %apply changes
    end
end
