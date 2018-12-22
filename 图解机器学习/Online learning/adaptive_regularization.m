n = 50; x = [randn(1,n/2)-15 randn(1,n/2)-5; 5*randn(1,n)]';
y = [ones(n/2,1); -ones(n/2,1)]; x(1:2,1) = x(1:2,1)+10;
x(:,3) = 1; p = randperm(n); x = x(p, :); y = y(p);

mu = zeros(3,1); S = eye(3); C = 1;
for i = 1 : length(x)
    xi = x(i,:)'; yi = y(i); z = S * xi; b = xi' * z + C; m = yi * mu' * xi;
    if m < 1
        mu = mu + yi * (1-m) * z/b;
        S = S - z * z'/b;
    end
end

figure; clf; hold on; axis([-20 0 -2 2]);
plot(x(y==1,1), x(y==1,2), 'bo');
plot(x(y==-1,1), x(y==-1,2), 'rx');
plot([-20 0], -(mu(3)+[-20 0]*mu(1))/mu(2), 'k-');
