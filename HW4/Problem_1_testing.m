%% Machine Vision Homework 4
% * Problem 1
% * Author: Xinyi Cai

%% Housekeeping
clear all; clc
%% Load calculated weights file
load calculated_weights.mat

%% Load testing data file
load testing_data.mat

H_testing = testing_data{1, 1}; 
E_testing = testing_data{1, 2}; 
L_testing = testing_data{1, 3}; 
O_testing = testing_data{1, 4}; 
%% Calculation
[y_P_H_test, y_Q_H_test] = Forward_Phase(H_testing, weight_pj_H, weight_qp_H); 
[y_P_E_test, y_Q_E_test] = Forward_Phase(E_testing, weight_pj_E, weight_qp_E); 
[y_P_L_test, y_Q_L_test] = Forward_Phase(L_testing, weight_pj_L, weight_qp_L); 
[y_P_O_test, y_Q_O_test] = Forward_Phase(O_testing, weight_pj_O, weight_qp_O); 

output = [y_Q_H_test; y_Q_E_test; y_Q_L_test; y_Q_O_test]