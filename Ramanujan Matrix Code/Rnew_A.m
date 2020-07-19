function arr = Rnew_A(M)
    arr = zeros([M,M]);
    for q = 1:M
        for j = 1:M
            arr(q,j) = seeq(q, (mod(j-1,q))+1);
            arr(q,j) = arr(q,j)/(M*totient(q));
        end
    end
end