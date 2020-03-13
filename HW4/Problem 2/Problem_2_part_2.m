%% Machine Vision Homework 4
% * Problem 2 Part 2 
% * Author: Xinyi Cai

%% Housekeeping
clear all; clc

%% Load the image
img_RGB = imread('wingtip.jpg'); 

%% Step 1: RGB -> Lab
img_Lab = rgb2lab(img_RGB);

%% Step 2: Clustering in a-b domain
[rows, columns, depth] = size(img_Lab); 
for i = 1:rows
    for j = 1:columns
        img_L(i, j) = img_Lab(i, j, 1); 
        img_a(i, j) = img_Lab(i, j, 2); 
        img_b(i, j) = img_Lab(i, j, 3); 
    end
end

img_ab = [img_a(:), img_b(:)]; 

% Find the centeroids of clusteres
% [idx, centroid, sumd, D] = kmeans(img_ab, 4, 'replicates', 50);
% save Problem_2_data.mat idx centroid sumd D

load Problem_2_data.mat

color1 = [img_ab(idx==1, 1), img_ab(idx==1, 2)]; % Dark Blue
color2 = [img_ab(idx==2, 1), img_ab(idx==2, 2)]; % White/ Gray
color3 = [img_ab(idx==3, 1), img_ab(idx==3, 2)]; % Light Blue
color4 = [img_ab(idx==4, 1), img_ab(idx==4, 2)]; % Red

% Plot the cluster figure
figure
hold on
plot(color1(:, 1), color1(:, 2), 'r.', 'MarkerSize', 12)
plot(color2(:, 1), color2(:, 2), 'b.', 'MarkerSize', 12)
plot(color3(:, 1), color3(:, 2), 'g.', 'MarkerSize', 12)
plot(color4(:, 1), color4(:, 2), 'c.', 'MarkerSize', 12)
plot(centroid(:, 1), centroid(:, 2), 'kx',...
     'MarkerSize', 15, 'LineWidth', 3) 
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Centorids',...
       'location', 'northwest')
title('Cluster Assignments and Centroids')
xlabel('a'); ylabel('b')
hold off

%% Step 3
% Color Segmentation
idx = reshape(idx, [rows, columns]); 
img_seg_C = zeros(rows, columns, 3, 'uint8');

for i = 1:rows
    for j = 1:columns
        if idx(i, j) == 4
            img_seg_BW(i, j) = 1; 
            for k = 1:3
                img_seg_C(i, j, k) = img_RGB(i, j, k); 
            end
        else
            img_seg_BW(i, j) = 0; 
            img_seg_C(i, j, :) = [0; 0; 0]; 
        end
    end
end

% Erode the noises
SE = strel('square', 3); 
img_seg_BW_1 = imopen(img_seg_BW, SE); 

%% Plotting
figure
subplot(2, 2, 1)
imshow(img_RGB)
title('Origial Image')

subplot(2, 2, 2)
imshow(img_seg_BW)
title('Segmented target BW')

subplot(2, 2, 3)
imshow(img_seg_BW_1)
title('Segmented target BW Opened')

subplot(2, 2, 4)
imshow(img_seg_C)
title('Segmented target Color')