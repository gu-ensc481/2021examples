%% Example: Controls - controllability
clear variables
close all
clc

%% Define the state-space system
% This is the system in terms of coordinates $$x$$
%
% $$ \dot x = Ax + Bu $$
% $$ y = Cx $$
%
A = [-5.5, -1.1, -1.8, -2.6;
      1.0, -3.6,  0.7,  0.9;
      0.5,  0.9, -2.8,  0.4;
      0.0,  0.4,  0.7, -2.1];

B = [-0.2;
      0.3;
     -0.2;
      0.3];

C = [3, 5, 7, 5];


%% Convert to a transfer function
syms s
G = C*( (s*eye(4)-A)\B )

%%
% but wait, what happens here?
simplify(G)

%% Diagonalize the system
[P,~] = eig(A);

Abar = P\A*P
Bbar = P\B
Cbar = C*P

%%
rref([B, A*B, A^2*B, A^3*B])
rref([C; C*A; C*A^2; C*A^3])
