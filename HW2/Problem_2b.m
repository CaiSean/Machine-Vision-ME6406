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


gaus_fun = @(s, sigma) 1/(sigma*sqrt(2*pi))*exp(-s^2/(2*sigma^2)); 

for i = 1:length(x0)
    gaus_x(i, :) = gaus_fun(x0(i), 3); 
    X(i, :) = conv(x0(i), gaus_x(i, :)); 
    
    gaus_y(i, :) = gaus_fun(y0(i), 3); 
    Y(i, :) = conv(y0(i), gaus_y(i, :)); 
end


