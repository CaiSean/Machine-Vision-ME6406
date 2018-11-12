%% Machine Vision Homework 4
% * Problem 1
% * Author: Xinyi Cai

%% Housekeeping
clear all; clc

%% Load training data files
load training_data.mat

H_input(1, :) = training_data_1{1, 1}; 
H_input(2, :) = training_data_2{1, 1}; 
H_input(3, :) = training_data_3{1, 1}; 

E_input(1, :) = training_data_1{1, 2}; 
E_input(2, :) = training_data_2{1, 2}; 
E_input(3, :) = training_data_3{1, 2}; 

L_input(1, :) = training_data_1{1, 3}; 
L_input(2, :) = training_data_2{1, 3}; 
L_input(3, :) = training_data_3{1, 3}; 

O_input(1, :) = training_data_1{1, 4}; 
O_input(2, :) = training_data_2{1, 4}; 
O_input(3, :) = training_data_3{1, 4}; 

%% Parameters
H_out = [1 0 0 0]; 
E_out = [0 1 0 0]; 
L_out = [0 0 1 0]; 
O_out = [0 0 0 1]; 

%% Generate random weights
Nj = 25; Np = 15; Nq = 4; 

initial_weight_pj = 0.0001*randi([-10000, 10000], Np, Nj);
initial_weight_qp = 0.0001*randi([-10000, 10000], Nq, Np);

%% Calculation
alpha = 0.5; 
iteration = 1000;

for i = 1:3
    [y_P, y_Q] = ANN_Forward_Phase(H_input(i, :), initial_weight_pj, initial_weight_qp);
    [weight_pj_new, weight_qp_new] = ANN_Backward_Phase(H_input(i, :), H_out,...
        y_P, y_Q, initial_weight_pj, initial_weight_qp, alpha);

    for j = 1:iteration
        [y_P, y_Q] = ANN_Forward_Phase(H_input(i, :), weight_pj_new, weight_qp_new);
        [weight_pj_new, weight_qp_new] = ANN_Backward_Phase(H_input(i, :), H_out,...
        y_P, y_Q, weight_pj_new, weight_qp_new, alpha);
        Error(j) = error_cal(H_out, y_Q);
    end
end

% plot(1:j, Error)

%% Load training data files
load testing_data.mat

H_testing = testing_data{1, 1}; 

[y_P_test, y_Q_test] = ANN_Forward_Phase(H_testing, weight_pj_new, weight_qp_new)


















