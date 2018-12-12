rand('state', 0); randn('state', 0);
n = 50;
N = 1000;
x = linspace(-3, 3, n)';
X = linspace(-3, 3, N)';
pix = pi * x; y = sin(pix)./(pix) + 0.1 * x + 0.05 * randn(n, 1);
p(:, 1) = ones(n, 1);
P(:, 1) = ones(N, 1);

for j = 1 : 15
    p(:,2*j) = sin(j/2*x); p(:,2*j+1) = cos(j/2*x);
    P(:,2*j) = sin(j/2*X); P(:,2*j+1) = cos(j/2*X);
end

t1 = p \ y;  F1 = P * t1;
t2 = (p*diag([ones(1, 11) zeros(1, 20)])) \ y; F2 = P * t2;

figure; clf; hold on; axis([-2.8 2.8 -0.8 1.2]);
plot(X, F1, 'g-'); plot(X, F2, 'r--'); plot(x,y,'bo');
legend('LS', 'Subspace-Constrained LS');
