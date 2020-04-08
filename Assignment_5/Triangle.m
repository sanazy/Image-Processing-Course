%% Triangle
function [triangle1 , triangle2] = Triangle(M,N)
    
    triangle1 = ones(M,N);    
    triangle2 = triangle1;
    for i=1:M
        if i > M/2
            for j=1:N-i
                triangle1(i,j) = 0;
                triangle2(j,i) = 0;
            end 
            for j=i:N
                triangle1(i,j) = 0;
                triangle2(j,i) = 0;
            end 
        else
            for j=1:i
                triangle1(i,j) = 0;
                triangle2(j,i) = 0;
            end 
            for j=N-i:N
                triangle1(i,j) = 0;
                triangle2(j,i) = 0;
            end 
        end
    end
end