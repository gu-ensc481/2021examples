%%
clear variables
close all
clc

%%
n1 = 10000;
n2 = 20000;


%%
% tic
% for i = 1:n1
%     for j = 1:n2
%         B(i,j) = i+j;     
%     end
% end
% toc
% 
% 
% %%
% 
% tic
% A = zeros(n1,n2);
% for i = 1:n1
%     for j = 1:n2
%         A(i,j) = i+j;     
%     end
% end
% toc
% 
% 
% %%
% 
% tic 
% A = nan(n1,n2);
% for i = 1:n1
%     for j = 1:n2
%         A(i,j) = i+j;     
%     end
% end
% toc

%%

A = rand(20,20);
B = rand(20,20);

A*B
