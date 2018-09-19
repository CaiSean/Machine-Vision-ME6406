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
B = bwboundaries(img_BW, 'holes');
B = B{1}; 
x0 = B(:, 2); 
y0 = B(:, 1); 

img_stats = regionprops('table', bwconncomp(img_BW));
centroids = cat(1, img_stats.Centroid);
xc = centroids(1,1); 
yc = centroids(1,2); 

figure; 
scatter(x0, y0)
hold on
plot(xc, yc, 'b*')
hold off

x_X = x0 - xc;
y_Y = y0 - yc; 
for i = 1:length(B)
    theta(i, :) = atan2(y_Y(i), x_X(i))*180/pi; 
    rho(i, :) = sqrt(y_Y(i)^2 + x_X(i)^2);
end

[peaks, valleys] = peakdet(rho, 5, theta);
theta_peaks = peaks(:,1); 
rho_peaks = peaks(:,2); 

figure; 
scatter(theta, rho)
hold on;
plot(theta_peaks, rho_peaks, 'r*');

syms X0 Y0

for i = 1:length(peaks)
    eqn1 = tand(theta_peaks(i))*(X0 - xc) + yc == Y0; 
    eqn2 = sqrt(rho_peaks(i)^2 - (X0 - xc)^2) + yc == Y0; 
    
    sol(i) = solve([eqn1, eqn2], [X0, Y0]); 
end

%% Plot the graph
% rot_angle = 90; 
% R = [cosd(rot_angle), -sind(rot_angle);... 
%      sind(rot_angle), cosd(rot_angle)];
R = 1;  
point1 = [sol(1).X0, sol(1).Y0]*R; 
point2 = [sol(2).X0, sol(2).Y0]*R; 
point3 = [sol(3).X0, sol(3).Y0]*R; 

figure; 
hold on; 
plot(point1(1, 2), point1(1, 1), 'r*');
plot(point2(1, 2), point2(1, 1), 'r*');
plot(point3(1, 2), point3(1, 1), 'r*');
% imshow(img)






















