n = 50; x = randn(n, 2);
y = 2 * (x(:,1)>x(:,2)) - 1;
b = 5000; a = 50; Y = zeros(a,a);
X0 = linspace(-3, 3, a); [X(:, :, 1), X(:,:,2)] = meshgrid(X0);

for j = 1 : b
    db = ceil(2 * rand); r = ceil(n * rand(n,1));
    xb = x(r,:);
    yb = y(r); [xs, xi] = sort(xb(:,db));
    el = cumsum(yb(xi)); eu = cumsum(yb(xi(end:-1:1)));
    e = eu(end-1:-1:1) - el(1:end-1);
    [em,ei] = max(abs(e)); c = mean(xs(ei:ei+1));
    s = sign(e(ei)); Y = Y + sign(s*(X(:,:,db)-c)) / b;
end

figure; clf; hold on; axis([-3 3 -3 3]);
colormap([1 0.7 1; 0.7 1 1]); contourf(X0, X0, sign(Y));
plot(x(y==1,1), x(y==1,2), 'bo');
plot(x(y==-1,1), x(y==-1,2), 'rx');
