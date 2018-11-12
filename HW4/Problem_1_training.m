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

%% Calculation Letter H
int_weight_pj_H = initial_weight_pj; 
int_weight_qp_H = initial_weight_qp; 

for i = 1:3
    [y_P_H, y_Q_H] = Forward_Phase(H_input(i, :), int_weight_pj_H, int_weight_qp_H);
    [weight_pj_H, weight_qp_H] = Backward_Phase(H_input(i, :), H_out,...
        y_P_H, y_Q_H, int_weight_pj_H, int_weight_qp_H, alpha);

    for j = 1:iteration
        [y_P_H, y_Q_H] = Forward_Phase(H_input(i, :), weight_pj_H, weight_qp_H);
        [weight_pj_H, weight_qp_H] = Backward_Phase(H_input(i, :), H_out,...
        y_P_H, y_Q_H, weight_pj_H, weight_qp_H, alpha);
        error_H(i, j) = error_cal(H_out, y_Q_H);
    end
    
    int_weight_pj_H = weight_pj_H; 
    int_weight_qp_H = weight_qp_H; 
    
end

%% Calculation Letter E
int_weight_pj_E = initial_weight_pj; 
int_weight_qp_E = initial_weight_qp; 

for i = 1:3
    [y_P_E, y_Q_E] = Forward_Phase(E_input(i, :), int_weight_pj_E, int_weight_qp_E);
    [weight_pj_E, weight_qp_E] = Backward_Phase(E_input(i, :), E_out,...
        y_P_E, y_Q_E, int_weight_pj_E, int_weight_qp_E, alpha);

    for j = 1:iteration
        [y_P_E, y_Q_E] = Forward_Phase(E_input(i, :), weight_pj_E, weight_qp_E);
        [weight_pj_E, weight_qp_E] = Backward_Phase(E_input(i, :), E_out,...
        y_P_E, y_Q_E, weight_pj_E, weight_qp_E, alpha);
        error_E(i, j) = error_cal(E_out, y_Q_E);
    end
    
    int_weight_pj_E = weight_pj_E; 
    int_weight_qp_E = weight_qp_E; 
end

%% Calculation Letter L
int_weight_pj_L = initial_weight_pj; 
int_weight_qp_L = initial_weight_qp; 

for i = 1:3
    [y_P_L, y_Q_L] = Forward_Phase(L_input(i, :), int_weight_pj_L, int_weight_qp_L);
    [weight_pj_L, weight_qp_L] = Backward_Phase(L_input(i, :), L_out,...
        y_P_L, y_Q_L, int_weight_pj_L, int_weight_qp_L, alpha);

    for j = 1:iteration
        [y_P_L, y_Q_L] = Forward_Phase(L_input(i, :), weight_pj_L, weight_qp_L);
        [weight_pj_L, weight_qp_L] = Backward_Phase(L_input(i, :), L_out,...
        y_P_L, y_Q_L, weight_pj_L, weight_qp_L, alpha);
        error_L(i, j) = error_cal(L_out, y_Q_L);
    end
    
    int_weight_pj_L = weight_pj_L; 
    int_weight_qp_L = weight_qp_L; 
end

%% Calculation Letter O
int_weight_pj_O = initial_weight_pj; 
int_weight_qp_O = initial_weight_qp; 

for i = 1:3
    [y_P_O, y_Q_O] = Forward_Phase(O_input(i, :), int_weight_pj_O, int_weight_qp_O);
    [weight_pj_O, weight_qp_O] = Backward_Phase(O_input(i, :), O_out,...
        y_P_O, y_Q_O, int_weight_pj_O, int_weight_qp_O, alpha);

    for j = 1:iteration
        [y_P_O, y_Q_O] = Forward_Phase(O_input(i, :), weight_pj_O, weight_qp_O);
        [weight_pj_O, weight_qp_O] = Backward_Phase(O_input(i, :), O_out,...
        y_P_O, y_Q_O, weight_pj_O, weight_qp_O, alpha);
        error_O(i, j) = error_cal(O_out, y_Q_O);
    end
    
    int_weight_pj_O = weight_pj_O; 
    int_weight_qp_O = weight_qp_O; 
end

%% Plot data
subplot(221)
plot(1:3*iteration, reshape(error_H', [1 3*iteration]))
xlim([0 300])
title('Letter H')
xlabel('Iteration')
ylabel('Error')

subplot(222)
plot(1:3*iteration, reshape(error_E', [1 3*iteration]))
xlim([0 300])
title('Letter E')
xlabel('Iteration')
ylabel('Error')

subplot(223)
plot(1:3*iteration, reshape(error_L', [1 3*iteration]))
xlim([0 300])
title('Letter L')
xlabel('Iteration')
ylabel('Error')

subplot(224)
plot(1:3*iteration, reshape(error_O', [1 3*iteration]))
xlim([0 300])
title('Letter O')
xlabel('Iteration')
ylabel('Error')

%% Save weight files
save calculated_weights.mat weight_pj_H weight_qp_H ...
    weight_pj_E weight_qp_E weight_pj_L weight_qp_L...
    weight_pj_O weight_qp_O  

