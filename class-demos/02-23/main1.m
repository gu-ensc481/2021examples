%% Live Example from class
% T. Fitzgerald, 23-Feb-2021

%%
clear variables
close all
clc

%% Let's define a 3rd order system
A = [1,0,2;
    -4, 6, 0;
    0, -1,2];
B = [-1; 2; 0];
C = eye(3);

%%
% Let's assume we want the system to have a 2nd order response with a set
% settle time Ts, and peak time Tp
Ts = 1; % [s]
Tp = 0.3; % [s]

%%
% From controls, we know that places the 3 desired poles here
sx = [-4/Ts+1j*pi/Tp, 
    -4/Ts-1j*pi/Tp,
    -5*4/Ts]

d = poly(sx)

%% Controllable Canonical Form 
% Let's build the transformation P to convert our states to controller
% canonical form

Cont_X = [B, A*B, A^2*B]

%%
a = poly(eig(A))

Abar = diag([1,1],1)
Abar(3,:) = -a(end:-1:2)

Bbar = [0;0;1];

Cont_Z = [Bbar, Abar*Bbar, Abar^2*Bbar]

%%
P = Cont_X/Cont_Z

Cbar = C*P

%% Design the controller:
temp = flip(d - a);
K = temp(1:3)

%%
% Testing to see if the controller shifts the eigenvalues of the
% closed-loop system
eig(Abar-Bbar*K)

%%
% Let's test the system's step response
T = ss(Abar-Bbar*K,Bbar,Cbar,0)

figure
step(T)

%% One last thing
% The above system is in terms of controller canonical form states z, if we
% want to change the controller to still work in x we can relate the
% following
% $$ u = -kz = -k P^{-1} x = -k_x x $$
K_x = K/P
%%
% now we can run the closed-loop system model using the original form of
% A,B,C
T0 = ss(A - B*K_x, B, C, 0);
hold on
step(T0, 'r--')