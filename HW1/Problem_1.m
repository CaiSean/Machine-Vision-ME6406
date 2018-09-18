%% Machine Vision Homework 1
% Problem 1
% Arthor: Xinyi Cai

%% Housekeeping
clc; 
clear all; 

%% Symbols
syms D_1 D_2 s; 

%% Variables
lambda = 4; 

%% Delta_A/Delta_O
n = 1; 

for S = -0.5:0.01:0.5
    ratio(n, 1) = (2/pi)*(0.5*acos(2*S)-S*sqrt(1-4*S.^2))+...
            (lambda^2/pi)*(asin((2/lambda)*sqrt(0.25-S.^2)-0.5*sin(2*asin((2/lambda)*sqrt(0.25-S.^2))))); 
    n = n+1; 
end


%% Plot the graph
S = [-0.5:0.01:0.5]; 
plot(S, ratio)
xlabel("S"); 
ylabel("\delta A / \delta O"); 
title("Problem 1: Pin-hole optics"); 
grid on
