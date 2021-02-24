%%
clear variables
close all
clc

%%
A = [1,0,2;
    -4, 6, 0;
    0, -1,2];
B = [-1; 2; 0];
C = eye(3);

%%
Ts = 1;
Tp = 0.3;

%%
sx = [-4/Ts+1j*pi/Tp, 
    -4/Ts-1j*pi/Tp,
    -5*4/Ts]

d = poly(sx)

%%
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
eig(Abar-Bbar*K)

%%
T = ss(Abar-Bbar*K,Bbar,Cbar,0)

%%
step(T)