%% Dot Diffusion
function [b]= dotDif(f)

    [M,N,ind] = size(f);
    
    %% check whether input is rgb
    if ind ==3
        f = rgb2gray(f);
    end
    f = im2double(f);
    
    %% Zero-padding the Image
    MM = M + (8 - mod(M,8))*(mod(M,8) > 0);
    NN = N + (8 - mod(N,8))*(mod(N,8) > 0);
    ff = zeros(MM, NN);
    ff(1:M, 1:N) = f(1:M, 1:N);  
    
    %% Class Matrix
    C = [35 49 41 33 30 16 24 32
         43 59 57 54 22 6  8  11
         51 63 62 46 14 2  3  19
         39 47 55 38 26 18 10 27
         29 15 23 31 36 50 42 34
         21 5  7  12 44 60 58 53
         13 1  4  20 52 64 61 45
         25 17 9  28 40 48 56 37];

    %% Zero-padding C matrix
    CC = zeros(10,10);
    for i = 1:8
        for j = 1:8
           CC(i+1,j+1) = C(i,j); 
        end
    end
  
    %% implement Weighted Matrix
    for k = 1:64
        % find indices of each element in C 
        [m(k),n(k)] = find (CC==k);
        % weighted matrix
        S(:,:,k) = CC(m(k)-1:m(k)+1,n(k)-1:n(k)+1);
        S(:,:,k) = S(:,:,k) > CC(m(k),n(k));
        D = [1 2 1
             2 1 2 
             1 2 1];
        S(:,:,k) = S(:,:,k).*D; 
        summ = sum(sum(S(:,:,k)));
        if summ > 0
            S(:,:,k) = S(:,:,k)./summ;
        else
            S(:,:,k) = 0;
        end
    end
    
    %% Building final Image
    b = zeros(M,N);
    for i = 1:8:MM
        for j =1:8:NN 
            %cut & process 8*8 window
            W = zeros(10,10);
            bb = zeros(10,10);
            W(2:9,2:9) = ff(i:i+7,j:j+7);

            for k = 1 : 64            
                x = m(k);
                y = n(k);
                bb(x,y) = W(x,y) >= 0.5;
                e = bb(x,y) - W(x,y);
                W(x-1:x+1, y-1:y+1) = W(x-1:x+1, y-1:y+1) - e.* S(:,:,k);
            end
            %save the result
            b(i:i+7, j:j+7) = bb(2:9,2:9);
            ff(i:i+7, j:j+7) = W(2:9,2:9);
        end
    end
       
end