%% Machine Vision Homework 2
% Problem 2
% Arthor: Xinyi Cai

%% Part 1

% Housekeeping
clc; 
clear all; 

% Solution
img = imread('HW2.bmp'); 
img_gray = rgb2gray(img); 
img_BW = imbinarize(img_gray); 
img_BW = imcomplement(img_BW); 
img_edge = edge(img_BW);
B = bwboundaries(img_edge, 'holes');
B = B{1}; 

img_stats = regionprops('table', bwconncomp(img_BW));
centroids = cat(1, img_stats.Centroid);

% figure; 
%scatter(B(:, 2), B(:, 1))
% plot(centroids(:,1),centroids(:,2), 'b*')

for i = 1:length(B)
    x_X = B(i, 2) - centroids(1,1); 
    y_Y = B(i, 1) - centroids(1,2); 
    theta(i) = atan2(y_Y, x_X)*180/pi; 
    rho(i) = sqrt(y_Y^2 + x_X^2); 
end

figure; 
scatter(theta, rho)

[peaks, valleys] = peakdet(rho, 5, theta);
hold on;
plot(peaks(:,1), peaks(:,2), 'r*');

syms x0 y0

for i = 1:length(peaks)
    eqn1 = sqrt(peaks(i, 1)^2 - (y0 - centroids(1,2))^2) == x0 - centroids(1,1); 
    eqn2 = (x0 - centroids(1,1))*tan(peaks(i, 2)*pi/180) == y0 - centroids(1,2); 
    
   sol(i) = solve([eqn1, eqn2], [x0, y0]); 
end

%% Plot the graph

figure; 
imshow(img)
hold on; 
plot(sol(1).x0, sol(1).y0, 'r*');
plot(sol(2).x0, sol(2).y0, 'r*');
plot(sol(3).x0, sol(3).y0, 'r*');






















