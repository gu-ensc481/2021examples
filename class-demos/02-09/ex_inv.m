%%
clear variables
close all
clc

%%
A = [ 2,  1, -1;
     -3, -1,  2;
     -2,  1,  2];
b = [8; -11; -3];


%%
B = [ A, b, eye(3) ]


%% Gaussian Elimination

B(3,:) = B(3,:) + B(1,:);
B(2,:) = B(2,:) + 3/2*B(1,:);
B(3,:) = B(3,:) - 4*B(2,:);
B(3,:) = -B(3,:);
B(2,:) = B(2,:) - 0.5*B(3,:);
B(1,:) = B(1,:) + B(3,:);
B(2,:) = B(2,:)*2;
B(1,:) = B(1,:) - B(2,:);
B(1,:) = B(1,:)/2;
B
x = B(:,4)
Ainv = B(:,5:7)

%%
% checks
A*x - b

Ainv*A

A*Ainv

%% Compare to some built-in functions
B2 = [ A, b, eye(3) ]
rref(B2)

% the bad way in matlab to solve for x:
x2 = inv(A)*b

% The good way:
x3 = A\b

