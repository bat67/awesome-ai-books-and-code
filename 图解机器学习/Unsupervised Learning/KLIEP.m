function a = KLIEP(k, r)

a0 = rand(size(k,2), 1); b = mean(r)'; c = sum(b.^2);
for o = 1 : 1000
    a = a0 + 0.01 * k' * (1./k * a0); a = a + b * (1-sum(b.*a))/c;
    a = max(0, a); a = a / sum(b .* a);
    if norm(a-a0) < 0.001
        break
    end
    a0 = a;
end

end
