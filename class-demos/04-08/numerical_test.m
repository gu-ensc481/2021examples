%% Numerical simulation
% Let's simulate the equations of motion we got from the contrained form of
% Lagrange's equation of the simple pendulum

clear variables
close all
clc

%%
g = 9.81; %[m/s^2]
l = 0.5; %[m]
tspan = [0,10]; %[s]


%% build initial conditions
% We have lots of options here  I'll pick an initial angle, and zero
% initial angular velocity
theta0 = 30*pi/180;

x0 = l*sin(theta0);
y0 = -l*cos(theta0);

xd0 = 0;
yd0 = 0;

% states z = [x,y,xd,yd]
z0 = [x0; y0; xd0; yd0];


%% Integrate the solution
sol = ode45( @(t,z) odesys(t,z,g), tspan, z0);


%% Plots
% Let's build some plots
x = @(t) deval(sol, t, 1);
y = @(t) deval(sol, t, 2);

constraint_err = @(t) ( sqrt( x(t).^2 + y(t).^2 ) - l)/l;

figure
subplot(3,1,1)
fplot(x, tspan, 'DisplayName', 'x(t) [m]', 'LineWidth', 2)
hold on
fplot(y, tspan, 'DisplayName', 'y(t) [m]', 'LineWidth', 2)
xlabel('Time t [s]')
ylabel('Position [m]')
legend('show')

subplot(3,1,2)
fplot( constraint_err, tspan, 'LineWidth', 2, ...
    'Color', [0.6350,0.0780,0.1840])
hold on
xlabel('Time t [s]')
ylabel('Rel. Error ( l(t) - l_0 )/l_0')

subplot(3,1,3)
fplot( x, y, tspan, 'Color', [0.4660,0.6740,0.1880], 'LineWidth', 2);
xlabel('x [m]');
ylabel('y [m]');


%% Animation
fig = figure();
ax = axes('Parent', fig);
hold(ax, 'on');
ax.DataAspectRatio = [1,1,1];
xlabel(ax, "x [m]");
ylabel(ax, "y [m]");
grid(ax, 'on');

Nframes = 200;
ts = linspace(0,tspan(2),Nframes);

ymin = min(y(ts))*1.1;
ymax = max([y(ts), 0.1*l])*1.1;
xmax = max( abs( x(ts) ) )*1.1;

xlim(ax, [-1,1]*xmax);
ylim(ax, [ymin, ymax]);

h_ground = line(ax, l/5*[-1, 1], [0,0],'Color', 'k', 'LineStyle', '--', 'LineWidth', 2);
h_rod = line(ax, [0,x(0)], [0, y(0)], 'Color', [1,1,1]*0.8, 'LineWidth', 2);
h_trace = plot( ax, x(0), y(0), 'LineStyle', 'none', 'marker', '.', ...
    'MarkerSize', 8, ...
    'MarkerEdgeColor', [0.4660,0.6740,0.1880],...
    'MarkerFaceColor', [0.4660,0.6740,0.1880]);
h_mass = plot(ax, x(0), y(0), 'LineStyle', 'none', 'marker', 'o', ...
    'MarkerEdgeColor', [0.4940, 0.1840, 0.5560], ...
    'MarkerFaceColor', [0.4940, 0.1840, 0.5560], ...
    'MarkerSize', 20);



for i = 1:Nframes
    
    h_rod.XData = [0, x( ts(i) )];
    h_rod.YData = [0, y( ts(i) )];
    
    h_mass.XData = x( ts(i) );
    h_mass.YData = y( ts(i) );
    
    h_trace.XData = x( ts(1:i) );
    h_trace.YData = y( ts(1:i) );
    
    drawnow()
    pause(0.1);
end


%%
function dz = odesys(t,z,g)

    x = z(1);
    y = z(2);
    xd = z(3);
    yd = z(4);
    
    xdd = (g*y - xd^2 - yd^2)*x./(x^2 + y^2);
    ydd = -(g*x^2 + y*xd^2 + y*yd^2)./(x^2 + y^2);
    
    dz = [xd; yd; xdd; ydd];

end