%%
clear variables
close all
clc

%%
i = [1,  1, 2, 1];
j = [1,  2, 2, 4];
v = [4, -1, 4, -1];

A = sparse(i,j,v,9,9);

%%

x = linspace(-1,2,200);
y = 2*x - 1;

y_noise = awgn(