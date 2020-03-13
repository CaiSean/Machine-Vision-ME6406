%% Machine Vision Homework 4
% * Problem 3 Part 1
% * Author: Xinyi Cai

%% Housekeeping
clear all; clc

%% Parameters
A1 = [1000 0 360; 
      0 1000 220; 
      0 0 1]; 
A2 = A1; 

theta = 70; 
b_len = 150; 

%% Subpart 1
R1 = roty(0); 
R2 = roty((90-theta)*2);
t1 = zeros(3, 1); 
t2 = [-b_len*sind(theta); 0; b_len*cosd(theta)]; 

P1 = A1*[R1, t1]
P2 = A2*[R2, t2]

%% Subpart 2
u1 = 189; v1 = 99; 
u2 = 531; v2 = 99; 

mp1 = [u1; v1; 1]; 
mp2 = [u2; v2; 1]; 

v = [skew(mp1)*P1; skew(mp2)*P2];
v1 = v(:, 1); v2 = v(:, 2); v3 = v(:, 3); v4 = v(:, 4); 

XYZ = pinv([v1, v2, v3])*(-v4);
Xw = XYZ(1)
Yw = XYZ(2)
Zw = XYZ(3)