rand('state', 0); randn('state', 0);
n = 50;
N = 1000;
x = linspace(-3, 3, n)';
X = linspace(-3, 3, N)';
pix = pi * x; y = sin(pix)./(pix) + 0.1 * x + 0.05 * randn(n, 1);

hh = 2 * 0.3 ^ 2; t0 = randn(n, 1); e = 0.1;
for o = 1 : n * 1000
    i = ceil(rand * n);
    ki = exp(-(x-x(i)).^2/hh); 
    t = t0 - e * ki * (ki' * t0 -y(i));
    if(norm(t - t0) < 0.000001) 
        break
    end
    t0 = t;
end

K = exp(-(repmat(X.^2,1,n)+repmat(x.^2',N,1)-2*X*x')/hh);
F = K*t;

figure; clf; hold on; axis([-2.8 2.8 -0.5 1.2]);
plot(X,F,'g-');
plot(x,y,'bo');





