n = 200; x = [randn(1,n/2)-5 randn(1,n/2)+5; 5*randn(1,n)]';
y = [ones(n/2,1); -ones(n/2,1)];
x(:,3) = 1; p = randperm(n); x = x(p, :); y = y(p);

t = zeros(3,1); l = 1;
for i = 1 : length(x)
    xi = x(i,:)'; yi = y(i);
    t = t + yi*max(0,1-t'*xi*yi)/(xi'*xi+l)*xi;
end

figure; clf; hold on; axis([-10 10 -10 10]);
plot(x(y==1,1), x(y==1,2), 'bo');
plot(x(y==-1,1), x(y==-1,2), 'rx');
plot([-10 10], -(t(3)+[-10 10]*t(1))/t(2), 'k-');
