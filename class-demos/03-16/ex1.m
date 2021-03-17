%%
clear variables
close all
clc

%%
p = [0.7, 0.1, -2.5, 0, 1];
pp = polyder(p);

% [x1,x2] = [x,y]
f = @(x) [ x(1)^2/4 + x(2)^2 - 1;
           polyval(p,x(1)) - x(2)];
       
J = @(x) [ 1/2*x(1), 2*x(2);
           polyval(pp,x(1)), -1];
       
       
%%
figure

fplot( @(x) sqrt(1-x.^2/4),[-2,2], 'LineWidth', 2)
xlabel('x')
ylabel('y')
hold on
fplot( @(x) -sqrt(1-x.^2/4),[-2,2], 'LineWidth', 2)

fplot( @(x) polyval(p,x), [-2,2], 'LineWidth', 2)

       
%% Let's do Newton's Method

% guess:
% x0 = [0.5;0];

% tol = 1e-8;
% 
% maxIter = 1000;
% i = 0;
% 
% flag = 0;
% 
% fn = f(x0);
% xn = x0;
% while flag == 0
%    
%     i = i + 1;
%     
%     Jn = J(xn);
%     delta_x = -Jn\fn;
%     
%     xn = xn + delta_x;
%     
%     fn = f(xn);
%     
%     if norm(fn) <= tol
%         flag = 1;
%         
%     elseif i >= maxIter
%         flag = -1;
%         error('Failed to converge')
%     end
%     
% end


%%

x = [0.1;1.1];
[x,iter] = NewtonsMethod(f,J,x)
plot(x(1), x(2), 'ko', ...
    'MarkerSize', 10, 'MarkerFaceColor', 'cyan')

%%
x = [ 1.2; -0.7];
[x,iter] = NewtonsMethod(f,J,x)
plot(x(1), x(2), 'ko', ...
    'MarkerSize', 10, 'MarkerFaceColor', 'cyan')

