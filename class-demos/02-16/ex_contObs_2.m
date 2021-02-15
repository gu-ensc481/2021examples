%% Example 2: More plotting
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


%% Diagonalize the system
[P,~] = eig(A);

Abar = P\A*P
Bbar = P\B
Cbar = C*P

%% Some tests
% while we certainly could use 'ss' and 'initial' for this, I'm going to
% stick to ode45
x0 = [1; -1; 2; -2];
tspan = [0, 2];
u = @(t) 0;
xdot = @(t,x) A*x + B*u(t);

sol_x = ode45(xdot, tspan, x0);

%%
% now I'm going to make a fancy plot
fig = figure();
color_set = lines(4);

ax1 = subplot(2,2,1, 'Parent', fig);
plot(ax1, sol_x.x, sol_x.y, '-', 'marker', '.');
xlabel(ax1, "Time t [s]");
ylabel(ax1, "State values");
legend(ax1, 'show', ["x_1", "x_2", "x_3", "x_4"])
grid(ax1, "on")
hold(ax1,"on")

ax2 = subplot(2,2,3:4,'Parent', fig);
fplot(ax2, @(t) C*deval(sol_x,t), tspan, ...
    "LineWidth", 2, "DisplayName", "x states")
grid(ax2, 'on')
xlabel(ax2, "Time t [s]");
ylabel(ax2, "Output y(t)");
hold(ax2', 'on')
legend(ax2, 'show')

%% What does it look like in terms of z?
z0 = P\x0;
zdot = @(t,z) Abar*z + Bbar*u(t);
sol_z = ode45(zdot, tspan, z0);

ax3 = subplot(2,2,2,'Parent', fig);
plot(ax3, sol_z.x, sol_z.y, '-', 'marker', '.');
xlabel(ax3, "Time t [s]");
ylabel(ax3, "State values");
legend(ax3, 'show', ["z_1", "z_2", "z_3", "z_4"])
grid(ax3, "on")
hold(ax3,"on")

fplot(ax2, @(t) Cbar*deval(sol_z,t), tspan, ...
    "--", "LineWidth", 2, "DisplayName", "z states")

%% What happens when we preturb the initial conditions?
z0 = z0 + [-3; -3; 0; 0];
x0 = P*z0;

sol_x = ode45(xdot, tspan, x0);
for i = 1:length(x0)
    plot(ax1, sol_x.x, sol_x.y(i,:), '--', 'marker', '*',...
        "DisplayName", sprintf("alt x0: x_%d",i), ...
        "Color", color_set(i,:));
end

sol_z = ode45(zdot, tspan, z0);
for i = 1:length(x0)
    plot(ax3, sol_z.x, sol_z.y(i,:), '--', 'marker', '*',...
        "DisplayName", sprintf("alt x0: x_%d",i), ...
        "Color", color_set(i,:));
end


fplot(ax2, @(t) C*deval(sol_x,t), tspan, ...
    ":", "LineWidth", 1, "Marker", "^", ...
    "DisplayName", "alt x0: x states")


fplot(ax2, @(t) Cbar*deval(sol_z,t), tspan, ...
    ":", "LineWidth", 1, "Marker", "o", ...
    "DisplayName", "alt z0: z states")
