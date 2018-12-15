n = 100; x = [(rand(n/2,2)-0.5)*20; randn(n/2,2)]; x(n,1) = 14;
k = 3; x2 = sum(x.^2,2);
[s, t] = sort(sqrt(repmat(x2,1,n)+repmat(x2',n,1)-2*x*x'),2);

for i = 1 : k + 1
    for j = 1 : k
        RD(:,j) = max(s(t(t(:,i),j+1),k), s(t(:,i),j+1));
    end
    LRD(:,i) = 1./mean(RD, 2);
end
LOF = mean(LRD(:,2:k+1), 2)./LRD(:, 1);

figure; clf; hold on;
plot(x(:,1), x(:,2), 'rx');
for i = 1 : n
    plot(x(i,1),x(i,2), 'bo', 'MarkerSize', LOF(i)*10);
end

