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

alpha = 0.5; 
iteration = 1000;

%% Generate random weights
Nj = 25; Np = 15; Nq = 4; 

initial_weight_pj = 0.0001*randi([-20000, 20000], Np, Nj);
initial_weight_qp = 0.0001*randi([-20000, 20000], Nq, Np);

%% Calculation
[weight_pj_H, weight_qp_H, error_H] = training(H_input, H_out,...
    initial_weight_pj, initial_weight_qp, alpha, iteration);

[weight_pj_E, weight_qp_E, error_E] = training(E_input, E_out,...
    initial_weight_pj, initial_weight_qp, alpha, iteration);

[weight_pj_L, weight_qp_L, error_L] = training(L_input, L_out,...
    initial_weight_pj, initial_weight_qp, alpha, iteration);

[weight_pj_O, weight_qp_O, error_O] = training(O_input, O_out,...
    initial_weight_pj, initial_weight_qp, alpha, iteration);

error = [error_H; error_E; error_L; error_O]; 

%% Plot data
str = {'H', 'E', 'L', 'O'}; 

for i = 1:length(str)
    subplot(2, 2, i)
    plot(1:3*iteration, reshape(error(i*3-2:i*3, :)', [1 3*iteration]))
    xlim([0 300])
    title(['Letter ', str{i}])
    xlabel('Iteration')
    ylabel('Error')
end

%% Save weight files
save calculated_weights.mat weight_pj_H weight_qp_H ...
    weight_pj_E weight_qp_E weight_pj_L weight_qp_L...
    weight_pj_O weight_qp_O  



