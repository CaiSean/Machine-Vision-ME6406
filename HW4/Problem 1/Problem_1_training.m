%% Machine Vision Homework 4
% * Problem 1
% * Author: Xinyi Cai

%% Housekeeping
clear all; clc

%% Load training data files
run('Training_data.m')
load training_data.mat

input = training_data; 
clear H E L O

%% Parameters
output = eye(4); 

alpha = 0.5; 
acceptable_error = 0.005; 

%% Generate random weights
Nj = 25; Np = 15; Nq = 4; 

initial_weight_pj = 0.0001*randi([-20000, 20000], Np, Nj);
initial_weight_qp = 0.0001*randi([-20000, 20000], Nq, Np);

%% Calculation

[weight_pj, weight_qp] = training(input, output,...
    initial_weight_pj, initial_weight_qp, alpha, 1); 
tic
[weight_pj, weight_qp, error, iteration] = training(input, output,...
    weight_pj, weight_qp, alpha, acceptable_error); 
toc

%% Plot the graph
figure;
plot(1:iteration, error, 'r')
xlabel('Iteration')
ylabel('Error')
title('Squared Error vs Iteration')
grid on

%% Save weight files
save calculated_weights.mat weight_pj weight_qp 

