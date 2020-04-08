function []=KASS(f,W,iter,num_fig)

    %% Get input from user
    figure(num_fig); imshow(f,[])
%     [y1,x1] = getpts(figure(1));
%     Y = [y1;y1(1)];
%     X = [x1;x1(1)];
%     X = floor(X);
%     Y = floor(Y);
    %######################
    %% Make an initial circle instead of get input from user
    centx = 150;
    centy = 150;
    r = 149;
    theta = 0 : 0.2 :(2*pi);
    X = r * cos(theta) + centx;
    Y = r * sin(theta) + centy;
    X = floor(X)';
    Y = floor(Y)';
    %#########################
    hold on; plot (Y,X,'r','linewidth',3); pause(0.5);
    num_dots = length(X) - 1;
    
    %% Calculate & normalizing Gradient
    f = im2double(f);
    [fx,fy] = gradient(f);
    mag_grad = sqrt(fx.^2 + fy.^2);
    
    %% Coefficients Initialization                  
    alfa = 6;
    beta = 16; 
    gama = 4500;
    
    curv_threshold = 0.1;
    grad_threshold = 0.5;
    
    for iteration = 1:iter
        %% Check out of bound
        for i = 1:num_dots
            if Y(i) > size(f,1) - ceil(W/2)
               Y(i) = Y(i) - W; 
            end
            if Y(i) < ceil(W/2)
               Y(i) = Y(i) + W; 
            end
            if X(i) > size(f,2) - ceil(W/2)
               X(i) = X(i) - W; 
            end
            if X(i) < ceil(W/2)
               X(i) = X(i) + W; 
            end 
        end
        
        %% Calculate d
        d = 0;
        for i = 1:num_dots
            d = d + (X(i)-X(i+1))^2 + (Y(i)-Y(i+1))^2 ;        
        end
        d = sqrt(d)/(num_dots);
        
        %% Energies Calculation
        for i = 1:num_dots
            %% Initialization
            Econt = zeros(W,W);
            Ecurv = zeros(W,W);
            %% Calculate Egradient          
            Egrad = mag_grad(Y(i)-fix(W/2):Y(i)+fix(W/2), X(i)-fix(W/2):X(i)+fix(W/2));
            
            for m = 1:W
                for n = 1:W
                    nX = X(i) + m - ceil(W/2);
                    nY = Y(i) + n - ceil(W/2);
                    %% Calculate Econtinuty
                    diff_x = nX - X(i+1);
                    diff_y = nY - Y(i+1);
                    %Econt(m,n) = abs(d - sqrt( diff_x^2 + diff_y^2 ));
                    Econt(m,n) = sqrt( diff_x^2 + diff_y^2 );
                    
                    %% Calculate Ecurvature
                    if i == 1, prev = num_dots;
                    else    prev = i - 1;   end

                    diff_x = X(prev) - 2*nX + X(i+1);
                    diff_y = Y(prev) - 2*nY + Y(i+1);
                    Ecurv(m,n) = sqrt( diff_x^2 + diff_y^2 );
                end
            end
            
            %% Evaluate Sharp Edge
            c = ceil(W/2);
            %previous curv.
            prev_1 = i - 1;
            prev_2 = i - 2;
            if i==1, prev_1=num_dots; prev_2=num_dots-1; end
            if i==2, prev_2 = num_dots; end
            prev_curv = sqrt(((X(prev_2) - 2*X(prev_1) + X(i))^2) + ((Y(prev_2) - 2*Y(prev_1) + Y(i))^2));
            %next curv.
            next_1 = i + 1;
            next_2 = i + 2;
            if i == num_dots, next_1 = 1; next_2 = 2; end
            if i == num_dots-1, next_2 = 1; end
            next_curv = sqrt(((X(i) - 2*X(next_1) + X(next_2))^2) + ((Y(i) - 2*Y(next_1) + Y(next_2))^2));
            
            if (Ecurv(c,c) > prev_curv && Ecurv(c,c) > next_curv && ...
                Ecurv(c,c) > curv_threshold && ...
                Egrad(c,c) > grad_threshold )
                    beta = 0;
            else
                    beta = 16;
            end
                  
            %% Energies Normalization
            %% Normalization of Econtinuity
            Econt_max = max(Econt(:));
            Econt_min = min(Econt(:));
            if Econt_max == Econt_min,  D = 1;
            else    D = Econt_max - Econt_min;  end
            Econt = (1/D)* (Econt - Econt_min);
            
            % Normalization of Ecurvature
            Ecurv_max = max(Ecurv(:));
            Ecurv_min = min(Ecurv(:));
            if Ecurv_max == Ecurv_min,  D = 1;
            else    D = Ecurv_max - Ecurv_min;  end
            Ecurv = (1/D)* (Ecurv - Ecurv_min);
            
            %% Summation of Energies
            E = alfa*Econt + beta*Ecurv - gama*Egrad;
            
            %% Minimize the Summation of Energies
            [m,n] = find ( E == min(E(:)) );
            %% Use First Minimum Values
            x = m(1); y = n(1);
            %% Update Pointes
            X(i,1) = X(i,1)+(x-ceil(W/2));
            Y(i,1) = Y(i,1)+(y-ceil(W/2));
            if i == 1 %wrap the polygon
                X(num_dots+1,1) = X(i,1);
                Y(num_dots+1,1) = Y(i,1);
            end
        end

        %% Plot New Contour
        figure(num_fig); imshow(f,[]); hold on; plot(Y,X,'linewidth',3); 
        title(['Number of Iteration : ', num2str(iteration)]); pause(0.01);
        if iteration < iter, clf; end
    end
end

