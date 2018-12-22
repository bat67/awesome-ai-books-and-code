x = randn(50, 2);
y = 2 * (x(:,1)>x(:,2)) - 1;
X0 = linspace(-3, 3, 50); [X(:, :, 1), X(:,:,2)] = meshgrid(X0);

d = ceil(2 * rand); [xs, xi] = sort(x(:,d));
el = cumsum(y(xi)); eu = cumsum(y(xi(end:-1:1)));
e = eu(end-1:-1:1) - el(1:end-1);
[em,ei] = max(abs(e)); c = mean(xs(ei:ei+1)); s = sign(e(ei));
Y = sign(s * (X(:,:,d)-c));

figure; clf; hold on; axis([-3 3 -3 3]);
colormap([1 0.7 1; 0.7 1 1]); contourf(X0, X0, Y);
plot(x(y==1,1), x(y==1,2), 'bo');
plot(x(y==-1,1), x(y==-1,2), 'rx');
