%% Machine Vision Homework 3
% Problem 2 Part b
% Arthor: Xinyi Cai

%% Parameters
% Input:
% n: Rotation axis
% theta: degrees around the rotation axis

% Outputs: 
% Pr: Rotation axis
% R: Rotation Matrix

function [Pr, R] = rot_axis(n, theta)

Pr = 2*sind(theta/2)*n; 

alpha = sqrt(4-abs(Pr)'*abs(Pr));

R = (1-0.5*abs(Pr)'*abs(Pr))*eye(3)+0.5*(Pr*Pr'+alpha*skew(Pr)); 