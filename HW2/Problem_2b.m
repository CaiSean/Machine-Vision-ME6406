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

img_gau = imgaussfilt(img_gray, 3); 

for i = 1:length(x0)-5
    for j = 1:5
        s_x(i, j) = x0(i+j); 
        s_y(i, j) = y0(i+j); 
    end
end


gaus_fun = @(s, sigma) 1/(sigma*sqrt(2*pi))*exp(-s^2/(2*sigma^2)); 

for i = 1:length(s_x)
    for j = 1:5
        gaus_x = gaus_fun(s_x(i, j), 3); 
        temp_X(j) = conv(s_x(i, j), gaus_x); 

        gaus_y = gaus_fun(s_y(i, j), 3); 
        temp_Y(j) = conv(s_y(i, j), gaus_y); 
    end
    X(i, :) = sum(temp_X); 
    Y(i, :) = sum(temp_Y);
end

for i = 1:length(X)-1
    X_dot(i, :) = X(i)-X(i+1); 
    Y_dot(i, :) = Y(i)-Y(i+1); 
end

for i = 1:length(X_dot)-1
    X_ddot(i, :) = X_dot(i)-X_dot(i+1); 
    Y_ddot(i, :) = X_dot(i)-X_dot(i+1); 
end

for i = 1:length(X_ddot)
    K(i, :) = X_dot(i)*Y_ddot(i)-Y_dot(i)*X_ddot(i); 
end





















