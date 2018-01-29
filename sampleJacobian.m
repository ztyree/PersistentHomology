n = 64;
m = 64;
k = 1:(n-1);
alpha = randn(n-1, 1) + 1i*randn(n-1, 1);
beta = randn(m-1, 1) + 1i*randn(m-1, 1);
beta = [beta; zeros(n-m, 1)];

[x,y] = meshgrid(-8:.1:8);
z = x + 1i*y;
U = zeros(length(x), length(y));
V = zeros(length(x), length(y));

for r = 1:length(x)
    for s = 1:length(y)
        U(r, s) = jacobian(alpha, beta, n, z(r, s));
    end
end


loops = 2000;
F(loops) = struct('cdata',[],'colormap',[]);
c = 100000000000000;
for j=1:loops
    V = c*(1-.001*j)*ones(size(U));
    V = min(U, V);
    
  contourf(x ,y , V, c*[1-.001*j,1-.001*j]);
  drawnow
  F(j) = getframe;
  1 -.001*j
end


%figure;
%surf(x, y, U)
