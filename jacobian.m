function[j] = jacobian(a, b, n, z)
k = 1:(n-1);
j = abs(sum(a'.*z.^(k-1) ./ (factorial(k).^.5)))^2 - ...
    abs(sum(b'.*z.^(k-1) ./ (factorial(k).^.5)))^2;