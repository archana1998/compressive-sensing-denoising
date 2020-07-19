function mu = sng_mu(n)

if n == 1, mu = 1; return; end

p = factor(n);
r = histc(p, unique(p));

if all(r < 2)
mu = (-1)^length(unique(p));
else
mu = 0;
end
