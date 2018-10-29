%% Machine Vision Homework 3
% Problem 3
% Arthor: Xinyi Cai

%% Housekeeping
clc; 
clear all; 

%% Step 1
A = 4; B = 0; C = 1; 
D = -4; E = -1; F = -9; 
f = 0.1; 

C_mtx = [A B D/f;... 
     B C E/f;... 
     D/f E/f F/f^2]; 

%% Step 2
[P_mtx, D_mtx] = eig(C_mtx); 

temp = diag(D_mtx); 
a = 1/sqrt(temp(1)); 
b = 1/sqrt(temp(2)); 
c = 1/sqrt(-temp(3)); 
clear temp

%% Step 4
alpha_1 = atan((c/b)*sqrt((1-(b/a)^2)/(1+(c/a)^2)));
alpha_2 = -alpha_1; 

