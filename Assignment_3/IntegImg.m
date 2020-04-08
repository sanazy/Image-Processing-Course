%% Calculate Integral Image
function [gg] = IntegImg(f)

    [M,N] = size (f);
    ff = zeros(M+1,N+1);
    g  = zeros(M+1,N+1);
    gg = zeros(M,N);

    p = 1;
    for m = 1:M
        p = p + 1;
        q = 1;
        for n = 1:N
            q = q + 1;
            ff(p,q) = f(m,n);
            g(p,q) = g(p,q-1)+g(p-1,q)-g(p-1,q-1)+ff(p,q);
            gg(p-1,q-1) = g(p,q);
        end
    end       
end