%% Machine Vision Homework 4
% * Problem 1
% * Author: Xinyi Cai

%% Housekeeping
% clear all; clc
%% Load calculated weights file
load calculated_weights.mat

%% Load testing data file
load testing_data.mat

H_testing = testing_data{1, 1}; 
E_testing = testing_data{1, 2}; 
L_testing = testing_data{1, 3}; 
O_testing = testing_data{1, 4}; 

%% Calculation
for i = 1:4 
    [y_P_test, y_Q_test] = Forward_Phase(testing_data{1, i}, weight_pj, weight_qp);  
    output(i, :) = y_Q_test;
end

