%%
clear variables
close all
clc


%%
%% Let's define a 3rd order system
A = [1,0,2;
    -4, 6, 0;
    0, -1,2];
B = [-1; 2; 0];
C = [1,0,0];

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


%% Let's build the controllers:
K = controllerDesign(A,B,sx);

%% Let's build the observer
sxO = 5*sx

L = controllerDesign(A', C', sxO )';


