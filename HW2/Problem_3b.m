%% Machine Vision Homework 2
% Problem 3 Part b
% Arthor: Xinyi Cai

%% Part 2

% Housekeeping
clc; 
clear all; 

x_t = [1, 3, 4, 3, 1, 0]'; 
y_t = [0, 0, 3, 5, 4, 2]'; 

x_i = [3.147, 4.748, 6.223, 3.321]'; 
y_i = [9.726, 7.3, 12.453, 12.628]'; 

% Find all possible permutations of vertices to form unique triangles
C_x_t = nchoosek(x_t, 3); 
C_y_t = nchoosek(y_t, 3); 

C_x_i = nchoosek(x_i, 3); 
C_y_i = nchoosek(y_i, 3); 

% Plot the triangles
figure; 
hold on
for i = 1:length(C_x_t)
    plot([C_x_t(i, :), C_x_t(i, 1)], [C_y_t(i, :), C_y_t(i, 1)])
end

for i = 1:length(C_x_i)
    plot([C_x_i(i, :), C_x_i(i, 1)], [C_y_i(i, :), C_y_i(i, 1)])
end

hold off

% Find all possible match
for i = 1:length(C_x_t)
    for j = 1:length(C_x_i)
        
        
        
    end
end
























