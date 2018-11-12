%% Machine Vision Homework 4
% * Problem 1
% * Author: Xinyi Cai

%% Housekeeping
clear all; clc

%% Load training data files
load training_data.mat

H_input(1, :) = training_data_1{1, 1}; 

%% Parameters
H_out = [1 0 0 0]; 

Nq = 4; Np = 15; Nj = 25; 

%% FP: Initialize weights
initial_weight_pj = 0.0001*randi([-10000, 10000], Np, Nj);
initial_weight_qp = 0.0001*randi([-10000, 10000], Nq, Np);

%% FP: Layer P
for i = 1:Np
    for j = 1:Nj
        temp(j) = initial_weight_pj(i, j)*H_input(1, j);
    end
    y_P(i) = sigmf(sum(temp), [1 0]); 
end
clear temp

%% FP: Layer Q
for i = 1:Nq
    for j = 1:Np
        temp(j) = initial_weight_qp(i, j)*y_P(j);
    end
    y_Q(i) = sigmf(sum(temp), [1 0]); 
end
clear temp

%% BP: Layer Q
alpha = 0.3; 
weight_qp = zeros(Nq, Np); 

for i = 1:Nq
    delta_Q(i) = y_Q(i)*(1-y_Q(i))*(H_out(i)-y_Q(i));
end

for i = 1:Nq
    for j = 1:Np
        delta_weight_qp(i, j) = alpha*delta_Q(i)*y_P(j); 
        weight_qp(i, j) = initial_weight_qp(i, j)+delta_weight_qp(i, j); 
    end
end

%% BP: Layer P
alpha = 0.3; 

for i = 1:Np
    for j = 1:Nq
        temp(j) = weight_qp(j, i)*delta_Q(j);
    end
    delta_P(i) = y_P(i)*(1-y_P(i))*sum(temp);
end
clear temp

for i = 1:Np
    for j = 1:Nj
        delta_weight_pj(i, j) = alpha*delta_P(i)*H_input(1, j); 
        weight_pj(i, j) = initial_weight_pj(i, j)+delta_weight_pj(i, j); 
    end
end






















