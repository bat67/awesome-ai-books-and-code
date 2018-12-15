n = 100; x = randn(n,1); y = randn(n,1); y(n) = 5;
hhs = 2 * [1 5 10].^2; m = 5;
x2 = x.^2; xx = repmat(x2,1,n) + repmat(x2',n,1) - 2 * x * x';
y2 = y.^2; yx = repmat(y2,1,n) + repmat(x2',n,1) - 2 * y * x';
u = floor(m * [0:n-1]/n) + 1; u = u (randperm(n));

for hk = 1 : length(hhs)
    hh = hhs(hk);k = exp(-xx/hh); r = exp(-yx/hh);
    for i = 1 : m
        g(hk, i) = mean(k(u==i, :)*KLIEP(k(u~=i,:),r));
    end
end
    
[gh, ggh] = max(mean(g,2)); HH = hhs(ggh);
k = exp(-xx/HH); r = exp(-yx/HH); s = r* KLIEP(k, r);

figure; clf; hold on; plot(y,s,'rx');

