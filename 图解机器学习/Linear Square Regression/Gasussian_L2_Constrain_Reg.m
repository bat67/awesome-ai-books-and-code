% rand('state', 0); randn('state', 0);
n = 200; a = linspace(0, 4 * pi, n/2);
u = [a .* cos(a), (a+pi).*cos(a)]' + 1 * rand(n,1);
v = [a .* sin(a), (a+pi).*sin(a)]' + 1 * rand(n,1);
x = [u, v]; y = [ones(1,n/2), -ones(1,n/2)]';

x2 = sum(x.^2, 2); hh = 2*1^2; l = 0.01;
k = exp(-(repmat(x2,1,n)+repmat(x2',n,1)-2*(x*x'))/hh);
t = (k^2+1*eye(n)) \ (k*y);

m = 100; X = linspace(-15,15,m)'; X2 = X.^2;
U = exp(-(repmat(u.^2,1,m)+repmat(X2',n,1)-2*u*X')/hh);
V = exp(-(repmat(v.^2,1,m)+repmat(X2',n,1)-2*u*X')/hh);

figure; clf; hold on; axis([-15 15 -15 15]);
contourf(X,X,sign(V'*(U.*repmat(t,1,m))));
plot(x(y==1,1),x(y==1,2),'bo');
plot(x(y==-1,1),x(y==-1,2),'rx');
colormap([1,0.7,1;0.7,1,1]);
