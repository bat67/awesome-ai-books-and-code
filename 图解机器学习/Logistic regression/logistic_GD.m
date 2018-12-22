rand('state', 0); randn('state', 0);
n = 90; c = 3; y = ones(n/c,1)*[1,c]; y = y(:);
x = randn(n/c, c) + repmat(linspace(-3,3,c),n/c,1); x= x(:);

hh = 2 * 1 ^2; t0 = randn(n,c);

for o = 1 : n*1000
    i = min(ceil(rand*60), 60); yi = y(i); ki = exp(-(x-x(i)).^2/hh);
    ci = exp(ki'*t0); t = t0 - 0.1 * (ki * ci) / (1 + sum(ci));
    t(:,yi) = t(:,yi) + 0.1 *ki;
    if norm(t-t0) < 0.000001
        break
    end
    t0 = t;
end

N = 90; X = linspace(-5,5,N)';
K = exp(-(repmat(X.^2,1,n)+repmat(x.^2,1,N)-2*X*x')/hh);
figure; clf; hold on; axis([-5,5,-0.3,1.8]);
C = exp(K*t); C = C./repmat(sum(C,2),1,c);
plot(X,C(:,1),'b-'); plot(X,C(:,2),'r--');
plot(X,C(:,3),'g:');
plot(x(y==1), -0.1*ones(n/c,1), 'bo'); 
plot(x(y==2), -0.2*ones(n/c,1), 'rx');
plot(x(y==3), -0.1*ones(n/c,1), 'gv');
legend('q(y=1|x)', 'q(y=2|x)', 'q(y=3|x)');
