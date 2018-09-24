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

for i = 1:(length(x0) - 1)
    s(i, :) = sqrt((x0(i) - x0(i+1))^2 + (y0(i) - y0(i+1))^2); 
end

%%
gaus_fun = @(s, sigma) 1/(sigma*sqrt(2*pi))*exp(-s^2/(2*sigma^2)); 

for i = 1:length(s)
    gaus(i, 1) = gaus_fun(s(i), 5); 
    
    X(i, 1) = conv(x0(i), gaus(i)); 
    Y(i, 1) = conv(y0(i), gaus(i)); 
end

for i = 1:length(X)-1
    X_dot(i, :) = (X(i+1)-X(i))/(s(i+1)-s(i)); 
    Y_dot(i, :) = (Y(i+1)-Y(i))/(s(i+1)-s(i)); 
end

for i = 1:length(X_dot)-1
    X_ddot(i, :) = (X_dot(i+1)-X_dot(i))/(s(i+1)-s(i)); 
    Y_ddot(i, :) = (X_dot(i+1)-X_dot(i))/(s(i+1)-s(i)); 
end

for i = 1:length(X_ddot)
    K(i, :) = X_dot(i)*Y_ddot(i)-Y_dot(i)*X_ddot(i)/...
              (X_dot(i)^2+Y_dot(i)^2)^(3/2); 
end


%% Plot the diagram
scatter(s(1:length(K)), K)




















