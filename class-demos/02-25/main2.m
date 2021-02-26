%% Example: using an observer
% By T. Fitzgerald
clear variables
close all
clc


%% Let's define a 3rd order system
A = [1,0,2;
    -4, 6, 0;
    0, -1,2];
B = [-1; 2; 0];
C = [1,0,0];
D = 0;

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
% Let's push the observer poles farther to the left in the complex plane.
% I'll try 5 to start
sxO = 5*sx;

L = controllerDesign(A', C', sxO )';

%%
% This is the initial condition of the system
x0 = [-1; 0; 1];

%% 
% Initial condition of the observer, basically our guess on what x0 is.

xhat0 = [0;0;0];  % when all else fails, let's assume zero

%% 
% If we make the initial condition close to the real one, the error
% converges much faster.

% xhat0 = x0+0.01; 


%% Solve for the response
w0 = [x0; xhat0];
tspan = [0,1.25];
r = @(t) 0;

sol = ode45(@(t,w) syswobs(t,w,A, B, C, D, K, L, r), tspan, w0);

%%
% Let's generate a plot.  This is a coarse one.  We'll work on making plots
% look better when we revisit ode solvers later.

line_colors = lines(3);
plot( sol.x, sol.y(1:3,:), '-', 'LineWidth', 2);
hold on
plot( sol.x, sol.y(4:6,:), '--', 'LineWidth', 2);

xlabel("Time t")
legend('show', {'x_1', 'x_2', 'x_3', 'xhat_1', 'xhat_2', 'xhat_3'})
grid("on")