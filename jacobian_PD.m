    function [ max_radius ] = jacobian_PD(num_birth_times,varargin)

% grid 

x=-10:0.1:10;
y=-10:0.1:10;
[X,Y]=meshgrid(x,y);

w = X + 1i*Y;
Z = zeros(length(Y), length(Y));

n = 100;
m = 100;
k = 1:(n-1);
alpha = randn(n-1, 1) + 1i*randn(n-1, 1);
beta = randn(m-1, 1) + 1i*randn(m-1, 1);
beta = [beta; zeros(n-m, 1)];

for r = 1:length(x)
    for s = 1:length(y)
        Z(r, s) = jacobian(alpha, beta, n, w(r, s));
    end
end

%Z=Z/max(max(abs(Z)));

% to view function -- put extra argument in function call
if nargin > 0
    figure
    surf(X,Y,Z)
    caxis([0,1])
    view(2)
end

counter=1;
for i=1:size(X,1)
    for j=1:size(X,2)     
        % apply mask
        % k=10;
        % mask(i,j)=mask_kernel([X(i,j) Y(i,j)],k/20,(k+1)/20,[0 0]);
        mask=ones(size(Z));
        % super-level sets
        output(counter)=ceil(num_birth_times*mean(mean(Z))*(1-Z(i,j)*mask(i,j)))+1;
        counter=counter+1;
    end
end
% [dim #horizontal-cubes #vertical-cubes output]
output=[2 100 100 output]';

fid=fopen('cubgrid.txt','wt');
for i=1:length(output)
    fprintf(fid,'%g\n',output(i));
end    
fclose(fid);
    
% to view masked function -- put extra argument in function call
% if nargin > 1
%     figure
%     surf(X,Y,Z.*ZK)
%     caxis([0,1])    
%     view(2)
% end 

system('../perseusLin cubtop cubgrid.txt output');

% if you want to look at the PDs -- put an argument in function call
if nargin > 0
    persdia('output_0.txt');
    persdia('output_1.txt');
end    

    end
    
