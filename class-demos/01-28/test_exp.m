%%
clear variables
close all
clc

%%

n = 20000;
x = linspace(-10,10,n);

tic
for i = 1:n
    a = myexp(x(i));
end
toc


%%
tic
for i = 1:n
    a = exp(x(i));
end
toc



%%
tic
for i = 1:n
   a = sqrt(x(i)); 
end
toc

tic
a = sqrt(x);
toc

tic
for i = 1:n
   a = x(i)^(0.5); 
end
toc

b = 0.5+eps;
tic
a = x.^b; 
toc