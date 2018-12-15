n = 100;
x = [2 * randn(n,1) randn(n,1)];
X = x - repmat(mean(x), [n, 1]);
[t, v] = eigs(x' * X, 1); % compute svd 

figure; clf; hold on; axis([-6 6 -6 6]);
plot(X(:,1), x(:,2), 'rx');
plot(9*[-t(1) t(1)], 9 * [-t(2) t(2)]);
