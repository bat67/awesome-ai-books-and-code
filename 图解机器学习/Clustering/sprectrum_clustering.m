n = 500; c = 2; k = 10; t = randperm(n); a =linspace(0, 2 * pi, n/2)';
x = [a.*cos(a) a.*sin(a); (a+pi).*cos(a) (a+pi).*sin(a)];
x = x + rand(n, 2); x = x - repmat(mean(x),[n,1]); x2 = sum(x.^2,2);
d = repmat(x2,1,n) + repmat(x2',n,1)-2*x*x'; [p,i] = sort(d);
W = sparse(d<=ones(n,1)*p(k+1,:)); W = (W+W'~=0);
D = diag(sum(W,2)); L = D - W; [z, v] = eigs(L,D,c-1,'sm');

m = z(t(1:c), :); s0(1:c, 1) = inf; z2 = sum(z.^2, 2);
for o = 1 : 1000
    m2 = sum(m.^2,2);
    [u, y] = min(repmat(m2,1,n)+repmat(z2',c,1)-2*m*z');
    for t = 1 : c
        m(t,:) = mean(z(y==t,:)); s(t,1) = mean(d(y==t));
    end
    if norm(s-s0) < 0.001
        break;
    end
    s0 = s;
end

figure; clf; hold on; axis([-10 10 -10 10]);
plot(x(y==1, 1), x(y==1, 2), 'bo');
plot(x(y==2, 1), x(y==2, 2), 'rx');
