%% Let's make a figure
% I'll make a figure in Matlab, export it, and include it in my example
% LaTeX document.

clear variables
close all
clc

%%
% I'll define a funky function to plot
f0 = 1/2;
f1 = 4;
T = 5;
c = (f1-f0)/T;
f = @(t) sin( 2*pi*(c/2*t.^2 + f0*t) );

%%
% Next we'll plot
fig = figure();
ax = axes('Parent', fig);
h = fplot(ax, f, [0,T]);
xlabel(ax, 'Time t [s]');
ylabel(ax, 'Signal [-]');
grid(ax, 'on');

%%
% Now we'll export the figure to a pdf.  I'll use the `saveas` function
% which is not considered to be the highest quality method to do this, but
% it is built-in and is functional.  Many Matlab users prefer the
% user-contributed project called export_fig:
% <https://github.com/altmany/export_fig>.
%
% Matlab being Matlab makes this next step very verbose.  We need all this
% junk in order to size the output pdf:
width  = 3.5;
height = 2.2;
fig.PaperUnits    = 'inches';
fig.PaperPosition = [0 0 width height];
fig.PaperSize     = [width height];

saveas(fig,'chirp.pdf')
