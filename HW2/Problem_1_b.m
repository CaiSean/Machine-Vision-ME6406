%% Machine Vision Homework 2
% Problem 1
% Arthor: Xinyi Cai

%% Part b 

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
[rows, columns] = size(img_BW);
[Gy, Gx] = imgradientxy(img_BW);

XY_array = zeros(length(B), 2); 

% Calculates the X0 and Y0
for i = 1:length(B)
    x = B(i, 1); 
    y = B(i, 2);
    
    vu = (x*Gx(x, y)+y*Gy(x, y))/(Gx(x, y)^2+Gy(x, y)^2);
    XY_array(i, :) = vu*[Gx(x, y), Gy(x, y)]; 
end

% Find the centeroids of clusteres
[cluster_idx,cluster_centroid] = kmeans(XY_array, 3, 'replicates', 50);

% Plot the cluster figure
figure(1);
hold on
plot(XY_array(cluster_idx==1,1),XY_array(cluster_idx==1,2),'r.','MarkerSize',12)
plot(XY_array(cluster_idx==2,1),XY_array(cluster_idx==2,2),'b.','MarkerSize',12)
plot(XY_array(cluster_idx==3,1),XY_array(cluster_idx==3,2),'g.','MarkerSize',12)
plot(cluster_centroid(:,1),cluster_centroid(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3) 
 
% Convert from X0, Y0 plane to XY plane
X = 1:1:columns; 

slope1 = -cluster_centroid(1, 1)/cluster_centroid(1, 2);
slope2 = -cluster_centroid(2, 1)/cluster_centroid(2, 2);
slope3 = -cluster_centroid(3, 1)/cluster_centroid(3, 2);

Y1 = slope1*(X-cluster_centroid(1, 1))+cluster_centroid(1, 2); 
Y2 = slope2*(X-cluster_centroid(2, 1))+cluster_centroid(2, 2); 
Y3 = slope3*(X-cluster_centroid(3, 1))+cluster_centroid(3, 2); 

% Plot the detected edge back to the original image
figure(2); 
imshow(img)
hold on
plot(Y1, X, 'r', 'LineWidth',3)
plot(Y2, X, 'b', 'LineWidth',3)
plot(Y3, X, 'g', 'LineWidth',3)

%% part c

% Solution
B = bwboundaries(img_edge,'holes');
B = B{2}; 

% figure; 
% scatter(B(:, 1), B(:, 2))

XY_array = zeros(length(B), 2); 

radius = (max(B(:, 1)) - min(B(:, 1))) / 2; 

% Calculates the X0 and Y0
for i = 1:length(B)
    x = B(i, 1); 
    y = B(i, 2);
    
    if Gx(x, y) ~= 0 || Gy(x, y) ~= 0
        cos_theta = Gx(x, y)/sqrt((Gx(x, y)^2 + Gy(x, y)^2));
        sin_theta = Gy(x, y)/sqrt((Gx(x, y)^2 + Gy(x, y)^2));

        xc = x+radius*sin_theta; 
        yc = y+radius*cos_theta; 
    end
    
    XY_array(i, :) = [xc, yc]; 
end

% Find the centeroids of clusteres
[cluster_circle_idx,cluster_circle_centroid] = kmeans(XY_array, 1, 'replicates', 50);

% Plot the cluster figure
figure(1);
plot(XY_array(cluster_circle_idx==1,1),XY_array(cluster_circle_idx==1,2),'c.','MarkerSize',12)
plot(cluster_circle_centroid(:,1),cluster_circle_centroid(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3) 
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Centorid', 'Cluster 4')
title 'Cluster Assignments and Centroids'
hold off
 
% Convert from X0, Y0 plane to XY plane
X_circle = (min(B(:, 1))-1):1:(max(B(:, 1)+1)); 

Y1_circle = sqrt((radius^2-(X_circle-cluster_circle_centroid(1, 1)).^2))+cluster_circle_centroid(1, 2); 
Y2_circle = -sqrt((radius^2-(X_circle-cluster_circle_centroid(1, 1)).^2))+cluster_circle_centroid(1, 2);

% Plot the detected edge back to the original image
figure(2); 
plot(Y1_circle, X_circle, 'c', 'LineWidth',3)
plot(Y2_circle, X_circle, 'c', 'LineWidth',3)

title('Edge detection on the image')
hold off
