n = 200; x = randn(n, 1); y = randn(n,1)+1;

hhs = 2 * [0.5 1 3].^2; ls = 10.^[-2 -1 0]; m = 5;
x2 = x.^2; xx = repmat(x2,1,n) + repmat(x2',n,1) - 2 * x * x';
y2 = y.^2; yx = repmat(y2,1,n) + repmat(x2',n,1) - 2 * y * x';
u = floor(m * [0:n-1]/n) + 1; u = u(randperm(n));
v = floor(m * [0:n-1]/n) + 1; v = v(randperm(n));

g = zeros(length(hhs), length(ls), m);
for hk = 1 : length(hhs)
    hh = hhs(hk); k = exp(-xx/hh); r = exp(-yx/hh);
    U = (pi * hh/2)^(1/2) * exp(-xx/(2*hh));
    for i = 1 : m
        vh = mean(k(u~=i,:))' - mean(r(v~=i,:))';
        z  = mean(k(u==i,:))  - mean(r(v==i,:));
        for lk = 1 : length(ls)
            l = ls(lk); a = (U + 1 * eye(n)) \ vh;
            g(hk, lk, i) = a' * U * a - 2 * z *a;
        end
    end
end

[gl, ggl] = min(mean(g, 3), [], 2); [ghl, gghl] = min(gl);
L = ls(ggl(gghl)); HH = hhs(gghl);
k = exp(-xx/HH); r = exp(-yx / HH); vh = mean(k)' - mean(r)';
U = (pi * HH / 2)^(1/2)*exp(-xx / (2 * HH));
a = (U + L * eye(n)) \ vh; s = [k;r] * a; L2 = 2 * a' * vh - a' * U * a;

figure; clf; hold on; plot([x;y],s,'rx');
