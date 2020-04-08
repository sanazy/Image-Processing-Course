function [I] = nonLinDiff_1D(I,type,iter,dt,dx,K,alfa)
    L = length(I);
    for it = 1:iter
        %% Compute the gradients
        Grad = zeros(L,1);
        for i = dx+1 : L-dx
           Grad(i) = (I(i+dx) - I(i-dx)) / (2*dx); 
        end
        %% Compute diffusity function g
        g = zeros(L,1);
        for i = 1:L
            grad = abs(Grad(i));
            if type == 1
                g(i) = 1 / (1+(grad/K)^(alfa+1)); %D1
            else
                g(i) =  exp(-((grad/K)^(alfa+1))); %D2
            end
        end
        %% Compute derivatives based on linear interpolation (tylor expansion)
        D = zeros(L,1);
        for i = dx+1:L-dx
            g1 = (g(i+dx) + g(i)) / (2*dx); %dg/di+
            g2 = (g(i-dx) + g(i)) / (2*dx); %dg/di-
            chng =        ((g(i+dx) + g(i)) / (2*dx)) * I(i+1);
            chng = chng + ((g(i-dx) + g(i)) / (2*dx)) * I(i-1);
            chng = chng - (g1 + g2) * I(i);
            D(i) = chng; %gradient
        end
        I = I + dt*D; %apply changes for this iteration with dt time step
    end
end
