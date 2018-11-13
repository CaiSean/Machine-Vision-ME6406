%% Machine Vision Homework 4
% * Problem 1
% * Author: Xinyi Cai

%% Housekeeping
clear all; clc

%% Load training data files
load training_data.mat

input = training_data; 

%% Parameters
output = [eye(4); eye(4); eye(4)]; 

alpha = 0.5; 
iteration = 1000; 

%% Generate random weights
Nj = 25; Np = 15; Nq = 4; 

initial_weight_pj = 0.0001*randi([-20000, 20000], Np, Nj);
initial_weight_qp = 0.0001*randi([-20000, 20000], Nq, Np);

%% Calculation

[weight_pj, weight_qp] = training(input, output,...
    initial_weight_pj, initial_weight_qp, alpha, 1); 
[weight_pj, weight_qp, error] = training(input, output,...
    weight_pj, weight_qp, alpha, iteration); 

figure
plot(1:iteration, error)

%% Save weight files
save calculated_weights.mat weight_pj weight_qp 

