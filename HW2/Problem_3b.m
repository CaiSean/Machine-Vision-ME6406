%% Machine Vision Homework 2
% Problem 3
% Arthor: Xinyi Cai

%% Part 2

% Housekeeping
clc; 
clear all; 

% Given
x_t = [0, 2, 5]; 
y_t = [0, 7, 3]; 
X_i = [5.500,4.470,12.845]; 
Y_i = [10.500,25.024,19.558]; 

X_c = 0.5*(max(x_t)-min(x_t)); 
Y_c = 0.5*(max(y_t)-min(y_t)); 

j = 1:2:5;
k = 2:2:6; 

for i = 1:3
    A(j(i):j(i)+1, 1:4) = [x_t(i), -y_t(i), 1, 0;...
                           y_t(i), x_t(i), 0, 1];
    R(j(i), 1) = X_i(i); 
    R(k(i), 1) = Y_i(i);
end

Q = pinv(A)*R; 

k = sqrt(Q(1)^2+Q(2)^2)
theta = atan2(Q(2), Q(1))*180/pi
x_d = Q(3) - X_c
y_d = Q(4) - Y_c
    