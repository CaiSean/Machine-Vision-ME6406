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
x0 = B(:, 1); 
y0 = B(:, 2); 

%% Calculate the curvature
gaus_fun = @(s, sigma) 1/(sigma*sqrt(2*pi))*exp(-s.^2/(2*sigma.^2)); 

sigma = 5; 
s = -100:1:100;
gaus = gaus_fun(s, sigma);
 
x = [x0; x0; x0]; 
y = [y0; y0; y0]; 

X_convd = conv(x, gaus, 'same'); 
Y_convd = conv(y, gaus, 'same'); 

n = length(x0);
X = X_convd(n:2*n); 
Y = Y_convd(n:2*n); 

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
K_smoothed = smooth(K, 20, 'moving');

[peaks, valleys] = peakdet(K_smoothed, 0.01, 1:length(K));

K_idx_peaks = peaks(:,1); 
K_peaks = peaks(:,2); 

K_idx_valleys = valleys(:,1); 
K_valleys = valleys(:,2); 

figure; 
plot(1:length(K_smoothed), K_smoothed)
hold on
scatter(K_idx_peaks, K_peaks, 30, 'r*');
scatter(K_idx_valleys, K_valleys, 30, 'r*');

%% Trace K back
figure; 
imshow(img)
hold on
scatter(y0(K_idx_peaks), x0(K_idx_peaks), 30, 'r*')
scatter(y0(K_idx_valleys), x0(K_idx_valleys), 30, 'r*')














