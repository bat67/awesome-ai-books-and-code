n = 40; x = [randn(1, n/2)-15, randn(1,n/2)-5; randn(1,n)]';
y = [ones(n/2,1); -ones(n/2,1)];
x(1:2,1) = x(1:2,1) + 60; x(:,3) = 1;

l = 0.01; e = 0.01; t0 = zeros(3,1);
for o = 1 : 1000    
    m = (x*t0).*y; v = m + min(1, max(0,1-m));
    a = abs(v-m); w = ones(size(y)); w(a>e) = e./a(a>e);
    t = (x' * (repmat(w,1,3).*x)+l*eye(3)) \ (x' * (w.*v.*y));
    if norm(t - t0) < 0.001
        break;
    end
    t0 = t;
end

figure; clf; hold on; z = [-20 50]; axis([z -2 2]);
plot(x(y==1,1),x(y==1,2),'bo');
plot(x(y==-1,1),x(y==-1,2),'rx');
plot(z,-(t(3)+z*t(1))/t(2), 'k-');
