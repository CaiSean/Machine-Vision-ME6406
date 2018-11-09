%% Machine Vision Homework 4
% * Problem 1 Training data
% * Author: Xinyi Cai

%% Housekeeping
clear all; clc

%% Data Set 1
H = [1 0 0 0 0; 
     1 0 0 0 1; 
     1 1 1 1 1; 
     1 0 0 0 1; 
     1 0 0 0 1]; 

E = [1 1 1 1 0; 
     1 0 0 0 0; 
     1 1 1 1 0; 
     1 0 0 0 0; 
     1 1 1 1 1]; 

L = [1 0 0 0 0; 
     1 0 0 0 0; 
     1 0 0 0 0; 
     1 0 0 0 0; 
     1 1 1 1 1]; 

O = [0 1 1 1 0; 
     1 0 0 0 1; 
     1 0 0 0 1; 
     1 0 0 0 1; 
     0 1 1 0 0]; 

training_data_1 = {H, E, L, O};

%% Data Set 2
H = [1 0 0 0 1; 
     1 0 0 0 1; 
     1 1 1 1 1; 
     1 0 0 0 1; 
     1 0 0 0 1]; 

E = [1 1 1 1 1; 
     1 0 0 0 0; 
     1 1 1 1 0; 
     1 0 0 0 0; 
     1 1 1 1 1]; 

L = [1 0 0 0 0; 
     1 0 0 0 0; 
     1 0 0 0 0; 
     1 0 0 0 0; 
     1 1 1 1 0]; 

O = [0 1 1 0 0; 
     1 0 0 0 1; 
     1 0 0 0 1; 
     1 0 0 0 1; 
     0 1 1 1 0]; 

training_data_2 = {H, E, L, O};

%% Data Set 3
H = [1 0 0 0 1; 
     1 0 0 0 1; 
     1 1 1 1 1; 
     1 0 0 0 1; 
     0 0 0 0 1]; 

E = [1 1 1 1 1; 
     1 0 0 0 0; 
     1 1 1 1 0; 
     1 0 0 0 0; 
     1 1 1 1 0]; 

L = [1 0 0 0 0; 
     1 0 0 0 0; 
     1 0 0 0 0; 
     1 0 0 0 0; 
     0 1 1 1 1]; 

O = [0 1 1 1 0; 
     1 0 0 0 1; 
     1 0 0 0 1; 
     0 0 0 0 1; 
     0 1 1 1 0]; 

training_data_3 = {H, E, L, O};

%% Test Data Set 1
H = [1 0 0 0 1; 
     1 0 0 0 1; 
     1 1 1 1 1; 
     1 0 0 0 1; 
     1 0 0 0 0]; 

E = [1 1 1 1 1; 
     1 0 0 0 0; 
     1 1 1 1 1; 
     1 0 0 0 0; 
     1 1 1 1 1]; 

L = [1 0 0 0 0; 
     1 0 0 0 0; 
     1 0 0 0 0; 
     1 0 0 0 0; 
     1 1 1 0 0]; 

O = [0 1 1 1 0; 
     1 0 0 0 1; 
     1 0 0 0 1; 
     1 0 0 0 1; 
     0 1 1 1 0]; 

testing_data = {H, E, L, O};

%% Save data
save training_data.mat training_data_1 training_data_2 training_data_3
save testing_data.mat testing_data