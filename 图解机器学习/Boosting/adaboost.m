n = 50; x = randn(n, 2);
y = 2 * (x(:,1)>x(:,2)) - 1;
b = 5000; a = 50; Y = zeros(a, a); yy = zeros(size(y)); w = ones(n,1)/n;
X0 = linspace(-3, 3, a); [X(:, :, 1), X(:,:,2)] = meshgrid(X0);

for j = 1 : b
    wy = w.* y; d = ceil(2 * rand); [xs, xi] = sort(x(:,d));
    el = cumsum(wy(xi)); eu = cumsum(wy(xi(end:-1:1)));
    e = eu(end-1:-1:1)-el(1:end-1);
    [em,ei] = max(abs(e)); c = mean(xs(ei:ei+1)); s = sign(e(ei));
    yh = sign(s*x(:,d)-c);R = w'*(1-yh.*y)/2;
    t = log((1-R)/R)/2; yy = yy + yh * t; w = exp(-yy.*y); w = w / sum(w);
    Y = Y + sign(s*(X(:,:,d)-c))*t;
end

figure; clf; hold on; axis([-3 3 -3 3]);
colormap([1 0.7 1; 0.7 1 1]); contourf(X0, X0, sign(Y));
plot(x(y==1,1), x(y==1,2), 'bo');
plot(x(y==-1,1), x(y==-1,2), 'rx');