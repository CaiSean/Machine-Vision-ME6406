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
     D/f E/f F/(f^2)]; 

%% Step 2
[P_mtx, D_mtx] = eig(C_mtx); 
temp = diag(D_mtx); 
temp_mtx = P_mtx; 


c = 1/sqrt(-temp(1)); 
if temp(3) >= temp(2)
    a = 1/sqrt(temp(2)); 
    b = 1/sqrt(temp(3)); 
    P_mtx = [temp_mtx(:, 2), temp_mtx(:, 3), temp_mtx(:, 1)];
else
    a = 1/sqrt(temp(3)); 
    b = 1/sqrt(temp(2)); 
    P_mtx = [temp_mtx(:, 3), temp_mtx(:, 2), temp_mtx(:, 1)];
end

clear temp

%% Step 4
r = 1; 

alpha_1 = atan((c/b)*sqrt((1-(b/a)^2)/(1+(c/a)^2)));
alpha_2 = -alpha_1;

gamma = r*c/(a*cos(alpha_1))*sqrt((1-(b/c)^2*tan(alpha_1)^2)/(1+tan(alpha_1)^4));

%% Step 3
K1_1 = 1/a^2; 
K2_1 = cos(alpha_1)^2/b^2-sin(alpha_1)^2/c^2;
K3_1 = (1/b^2+1/c^2)*sin(2*alpha_1)*gamma; 
K4_1 = (sin(alpha_1)^2/b^2-cos(alpha_1)^2/c^2)*gamma;

K1_2 = 1/a^2; 
K2_2 = cos(alpha_2)^2/b^2-sin(alpha_2)^2/c^2;
K3_2 = (1/b^2+1/c^2)*sin(2*alpha_2)*gamma; 
K4_2 = (sin(alpha_2)^2/b^2-cos(alpha_2)^2/c^2)*gamma;


%% Step 5
Oc_1 = P_mtx*rotx(alpha_1*pi/180)'*[0 -K3_1/(2*K2_1) gamma]';
Oc_2 = P_mtx*rotx(alpha_2*pi/180)'*[0 -K3_2/(2*K2_2) gamma]';

if Oc_1(3) > 0
    Oc_1
else
    Oc_2
end











