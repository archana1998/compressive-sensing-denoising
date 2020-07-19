function f = seeq(q,n)
    x = sng_mu(q/(gcd(q,n)))*totient(q);
    f = x/totient(q/(gcd(q,n)));
end
