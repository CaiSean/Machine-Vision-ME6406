%% Machine Vision Homework 2
% Problem 2
% Arthor: Xinyi Cai

%% Part 1

% Housekeeping
clc; 
clear all; 

x_t = [0, 2, 5]; 
y_t = [0, 7, 3]; 

X_c = 0.5*(max(x_t)-min(x_t)); 
Y_c = 0.5*(max(y_t)-min(y_t)); 

k = 2; 
theta = 20; 
x_d = 3; 
y_d = 7; 

q1 = k * cosd(theta); 
q2 = k * sind(theta); 
q3 = X_c + x_d; 
q4 = Y_c + y_d; 

for i = 1:3
    X_i(i) = q1 * x_t(i) - q2 * y_t(i) + q3; 
    Y_i(i) = q1 * y_t(i) + q2 * x_t(i) + q4; 
end

figure; 
plot([x_t, x_t(1)], [y_t, y_t(1)], 'r')
hold on 
plot([X_i, X_i(1)], [Y_i, Y_i(1)], 'g')
legend('Original Triangle', 'Transformed Triangle')
