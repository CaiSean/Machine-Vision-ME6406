%% Machine Vision Homework 2
% Problem 2 Part b
% Arthor: Xinyi Cai

%% Housekeeping
clc; 
clear all; 

%% Import the image and low level processing
img = imread('HW2.bmp'); 
img_gray = rgb2gray(img); 
img_BW = imbinarize(img_gray); 
img_BW = imcomplement(img_BW); 
img_edge = edge(img_BW);
B = bwboundaries(img_BW, 'holes');
B = B{1}; 
x0 = B(:, 2); 
y0 = B(:, 1); 



%%
gaus_fun = @(s, sigma) 1/(sigma*sqrt(2*pi))*exp(-s^2/(2*sigma^2)); 

sigma = 3; 
for i = 1:length(x0)-1
    gaus(i, 1) = gaus_fun(x(i), sigma); 
    
    X(i, 1) = x0(i+1) - x0(i); 
    Y(i, 1) = y0(i+1) - y0(i); 
    
    X(i, 1) = conv(x0(i), gaus(i), 'same'); 
    Y(i, 1) = conv(y0(i), gaus(i), 'same'); 
end

for i = 1:length(X)-1
    X_dot(i, 1) = X(i+1) - X(i); 
    Y_dot(i, 1) = Y(i+1) - Y(i); 
end

for i = 1:length(X_dot)-1
    X_ddot(i, 1) = X_dot(i+1) - X_dot(i); 
    Y_ddot(i, 1) = X_dot(i+1) - X_dot(i); 
end

for i = 1:length(X_ddot)
    K(i, :) = X_dot(i)*Y_ddot(i)-Y_dot(i)*X_ddot(i)/...;
              (X_dot(i)^2+Y_dot(i)^2)^(3/2); 
end


%% Plot the diagram
%%scatter(s(1:length(K)), K)



















