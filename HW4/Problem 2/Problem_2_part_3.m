%% Machine Vision Homework 4
% * Problem 2 Part 3 
% * Author: Xinyi Cai

%% Housekeeping
clear all; clc

%% Load the image
img_RGB = imread('wingtip.jpg'); 

%% Solution
X_R = double(img_RGB(:, :, 1)); X_R = X_R(:); 
X_G = double(img_RGB(:, :, 2)); X_G = X_G(:);
X_B = double(img_RGB(:, :, 3)); X_B = X_B(:); 
 
U = [covariance(X_R, X_R), covariance(X_R, X_G), covariance(X_R, X_B);
     covariance(X_G, X_R), covariance(X_G, X_G), covariance(X_G, X_B);
     covariance(X_B, X_R), covariance(X_B, X_G), covariance(X_B, X_B)];

[V, D] = eig(U);

[temp, idx] = sort(diag(D), 'descend'); 
D = diag(temp);

temp_mtx = V; 
V = [temp_mtx(:, idx(1)), temp_mtx(:, idx(2)), temp_mtx(:, idx(3))];

T = V'*[X_R-mean(X_R), X_G-mean(X_G), X_B-mean(X_B)]';

T1 = T(1, :); T2 = T(2, :); T3 = T(3, :); 
range = [0 255]; 
T1_mapped = linear_mapping(T1, range);
T2_mapped = linear_mapping(T2, range);
T3_mapped = linear_mapping(T3, range);

figure
T1_reshaped = reshape(T1_mapped, [720 960]);
T1_reshaped = uint8(T1_reshaped);
subplot(131); imshow(T1_reshaped)
title('PC_1')

T2_reshaped = reshape(T2_mapped, [720 960]);
T2_reshaped = uint8(T2_reshaped);
subplot(132); imshow(T2_reshaped)
title('PC_2')

T3_reshaped = reshape(T3_mapped, [720 960]);
T3_reshaped = uint8(T3_reshaped);
subplot(133); imshow(T3_reshaped)
title('PC_3')