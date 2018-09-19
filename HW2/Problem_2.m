%% Machine Vision Homework 2
% Problem 2
% Arthor: Xinyi Cai

%% Part 1

% Housekeeping
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

img_stats = regionprops('table', bwconncomp(img_BW));
centroids = cat(1, img_stats.Centroid);

xc = centroids(1,1); 
yc = centroids(1,2); 

% figure; 
% scatter(x0, y0)
% hold on
% plot(xc, yc, 'b*')
% hold off

%% Calculate the rho-theta signature
x_X = x0 - xc;
y_Y = y0 - yc; 

for i = 1:length(B)
    if (y_Y(i) >= 0) && (x_X(i) >= 0)
        theta(i, :) = atan2(abs(y_Y(i)), abs(x_X(i)))*180/pi; 
        rho(i, :) = sqrt(y_Y(i)^2 + x_X(i)^2);
        
    elseif (y_Y(i) > 0) && (x_X(i) < 0)
        theta(i, :) = 180 - atan2(abs(y_Y(i)), abs(x_X(i)))*180/pi;
        rho(i, :) = sqrt(y_Y(i)^2 + x_X(i)^2);
        
    elseif (y_Y(i) < 0) && (x_X(i) < 0)
        theta(i, :) = atan2(abs(y_Y(i)), abs(x_X(i)))*180/pi + 180;
        rho(i, :) = sqrt(y_Y(i)^2 + x_X(i)^2);
        
    elseif (y_Y(i) < 0) && (x_X(i) > 0)
        theta(i, :) = 360 - atan2(abs(y_Y(i)), abs(x_X(i)))*180/pi;
        rho(i, :) = sqrt(y_Y(i)^2 + x_X(i)^2);
    end
end

%% Find the peaks in the rho-theta graph
[peaks, valleys] = peakdet(rho, 5, theta);

theta_peaks = peaks(:,1); 
rho_peaks = peaks(:,2); 

figure; 
scatter(theta, rho)
hold on;
scatter(theta_peaks, rho_peaks, 30, 'r*');

%% Translate from image coord back to global coord
X0 = zeros(length(peaks), 1); 
Y0 = zeros(length(peaks), 1); 

for i = 1:length(peaks)   
    X0(i) = xc + rho_peaks(i)*cosd(theta_peaks(i)); 
    Y0(i) = yc + rho_peaks(i)*sind(theta_peaks(i)); 
end

%% Plot the graph
figure; 
imshow(img)
hold on; 
scatter(X0, Y0, 80, 'r*')
hold off
