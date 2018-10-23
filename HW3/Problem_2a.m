%% Machine Vision Homework 3
% Problem 2 Part a
% Arthor: Xinyi Cai

%% Housekeeping
clc; 
clear all; 

%% Given values
load hand_eye_data.mat

%% Part a
H_c12 = Hc2*inv(Hc1); 
H_c23 = Hc3*inv(Hc2);

R_c12 = H_c12(1:3, 1:3);
T_c12 = H_c12(1:3, 4);

R_c23 = H_c23(1:3, 1:3);
T_c23 = H_c23(1:3, 4);

R_g12 = Hg12(1:3, 1:3);
T_g12 = Hg12(1:3, 4);

R_g23 = Hg23(1:3, 1:3);
T_g23 = Hg23(1:3, 4);

%% Part b
[n_c12, theta_c12] = eq_angle_axis(R_c12);
[n_c23, theta_c23] = eq_angle_axis(R_c23);

[n_g12, theta_g12] = eq_angle_axis(R_g12);
[n_g23, theta_g23] = eq_angle_axis(R_g23);

Pr_c12 = rot_axis(n_c12, theta_c12);
Pr_c23 = rot_axis(n_c23, theta_c23);
[Pr_g12, R_g12_ver1] = rot_axis(n_g12, theta_g12);
[Pr_g23, R_g23_ver1] = rot_axis(n_g23, theta_g23);

% Verfication
[R_g12_ver2] = rot_verification_eq8(n_g12, theta_g12);
[R_g23_ver2] = rot_verification_eq8(n_g23, theta_g23);

%% Part c
A = [skew(Pr_g12+Pr_c12); skew(Pr_g23+Pr_c23)];
B = [Pr_c12-Pr_g12; Pr_c23-Pr_g23];
P_cg_ = pinv(A)*B;
theta_cg = 2*atand(abs(rssq(P_cg_)));
P_cg = 2*P_cg_/sqrt(1+abs(P_cg_)'*abs(P_cg_))

alpha = sqrt(4-abs(P_cg)'*abs(P_cg));
R_cg = (1-0.5*abs(P_cg)'*abs(P_cg))*eye(3)+0.5*(P_cg*P_cg'+alpha*skew(P_cg))

C = [R_g12-eye(3); R_g23-eye(3)]; 
D = [R_cg*T_c12-T_g12; R_cg*T_c23-T_g23]; 
T_cg = pinv(C)*D
