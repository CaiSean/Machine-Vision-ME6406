%% Machine Vision Homework 3
% * Problem 3
% * Author: Xinyi Cai

%% Housekeeping
clc; 
clear all; 

%% Step 1
A = 4; B = 0; C = 1; 
D = -4; E = -1; F = -11; 
f = 0.1; 

C_mtx = [A, B, D/f;... 
         B, C, E/f;... 
         D/f, E/f, F/(f^2)]; 

%% Step 2
[P_mtx, D_mtx] = eig(C_mtx/16);
temp = diag(D_mtx); 
temp_mtx = P_mtx; 

temp = sort(temp); 
a = 1/sqrt(temp(2)); 
b = 1/sqrt(temp(3)); 
c = 1/sqrt(-temp(1)); 

P_mtx = [temp_mtx(:, 2), temp_mtx(:, 3), temp_mtx(:, 1)];

clear temp temp_mtx
%% Step 4
r = 1; 

tan_alpha = (c/b)*sqrt((1-(b/a)^2)/(1+(c/a)^2));
cos_alpha_1 = (b/a)*sqrt((1+(a/c)^2)/(1+(b/c)^2));
cos_alpha_2 = -cos_alpha_1; 

gamma_1 = r*c/(a*cos_alpha_1)*sqrt((1-(b/c)^2*tan_alpha^2)/(1+tan_alpha^4));
gamma_2 = r*c/(a*cos_alpha_2)*sqrt((1-(b/c)^2*tan_alpha^2)/(1+tan_alpha^4));

if gamma_1 > 0
    alpha = acos(cos_alpha_1);
    gamma = gamma_1; 
elseif gamma_2 > 0
    alpha = acos(cos_alpha_2);
    gamma = gamma_2; 
end

clear gamma_1 gamma_2 tan_alpha cos_alpha_1 cos_alpha_2

%% Step 3
K1 = 1/a^2; 
K2 = cos(alpha)^2/b^2-sin(alpha)^2/c^2;
K3 = (1/b^2+1/c^2)*sin(2*alpha)*gamma; 
K4 = (sin(alpha)^2/b^2-cos(alpha)^2/c^2)*gamma;

%% Step 5
Oc = P_mtx*rotx(alpha*180/pi)'*[0 -K3/(2*K2) gamma]'

Nc = P_mtx*rotx(alpha*180/pi)'*[0 0 1]'