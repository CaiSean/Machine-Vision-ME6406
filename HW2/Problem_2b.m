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

%% Calculate the curvature
gaus_fun = @(s, sigma) 1/(sigma*sqrt(2*pi))*exp(-s.^2/(2*sigma.^2)); 

sigma = 5; 
s = -1000:1:1000;
gaus = gaus_fun(s, sigma);

X_convd = conv([x0; x0; x0], gaus, 'same'); 
Y_convd = conv([y0; y0; y0], gaus, 'same'); 

n = length(x0);
X = X_convd(n:2*n-1); 
Y = Y_convd(n:2*n-1); 

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

%% Plot the K-S diagram and find the peaks and valleys
K_smoothed = smooth(K, 5, 'moving');

[K_peaks,K_idx_peaks] = findpeaks(K_smoothed, 'MinPeakHeight',0.01);

figure; 
plot(1:length(K_smoothed), K_smoothed)
hold on
scatter(K_idx_peaks, K_peaks, 30, 'r', '^');
xlabel('Number of Pixels')
ylabel('Curvature K')
legend('K-S Curve', 'Peaks')
hold off

%% Trace K back and plot the corners on original image
figure; 
imshow(img)
hold on
scatter(x0(K_idx_peaks), y0(K_idx_peaks), 60, 'r*')
hold off