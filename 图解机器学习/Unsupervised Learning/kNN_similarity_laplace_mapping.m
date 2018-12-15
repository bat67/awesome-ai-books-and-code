n = 1000; k = 10; a = 3 * pi * rand(n, 1);
x = [a.*cos(a) 30 * rand(n,1) a.*sin(a)];
x = x - repmat(mean(x), [n,1]); x2 = sum(x.^2, 2);
d = repmat(x2,1,n) + repmat(x2',n,1)-2*x*x'; [p, i] = sort(d);
W = sparse(d<=ones(n,1)*p(k+1,:)); W = (W+W' ~= 0);
D = diag(sum(W,2)); L = D - W; [z, v] = eigs(L,D,3,'sm');

figure(1); clf; hold on; view([15 10]);
scatter3(x(:,1), x(:,2), x(:,3), 40, a, 'o');
figure(2); clf; hold on; scatter(z(:,2), z(:,1), 40, a, 'o');
