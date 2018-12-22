n = 300; c = 3; t = randperm(n);
x = [randn(1, n/3)-2 randn(1, n/3) randn(1,n/3)+2;
     randn(1, n/3)  randn(1,n/3)+4 randn(1,n/3)]';

m = x(t(1:c),:); x2 = sum(x.^2, 2); s0(1:c, 1) = inf;
for o = 1 : 1000
   m2 = sum(m.^2, 2);
   [d, y] = min(repmat(m2,1,n)+repmat(x2',c,1)-2*m*x');
   for t = 1 : c
       m(t,:) = mean(x(y==t,:)); s(t,1) = mean(d(y==t));
   end
   if norm(s-s0) < 0.001
       break;
   end
   s0 = s; 
end
 
figure; clf; hold on;
plot(x(y==1,1), x(y==1,2), 'bo');
plot(x(y==2,1), x(y==2,2), 'rx');
plot(x(y==3,1), x(y==3,2), 'gv');
