%% In Class: Types in Matlab
% T. Fitzgerald, 19-Jan-2021

clear variables
close all
clc

%% Numerbers default type
a = 1;

%% Arrays of numbers
a = 1:4;

%% Character arrays
c = 'the cat eats food';
d = 'the dog is a good boi';
[c; d]

%% Strings
% these are newer to Matlab (from 2016b) and mostly look and walk like
% character arrays.  See the website for FAQ on differences between strings
% and chars
% https://www.mathworks.com/help/matlab/matlab_prog/frequently-asked-questions-about-string-arrays.html

s1 = "This is a string";
s2 = "the dog is a good boi";
[s1; s2]


%% Structures
% very useful named fields
s.a = 1;
s.b = {'A','B','C'}


%% Cells
% Like a list that can contain anything
c = {"array of anything", 
     'Char array', 
     rand(10,10),
     s}
