%% Machine Vision Homework 1
% Problem 4
% Arthor: Xinyi Cai

%% Housekeeping
clc;
clear all; 

%% Load the image
img = imread('nut_and_shell.png');

%% Convert the image from RGB to Gray
img_gray = rgb2gray(img);
[pixelCounts, grayLevels] = imhist(img_gray); 

figure(1)
imhist(img_gray)
title("Histogram of the Input Picture")
ylim([0 1.8e4])
ylabel("Number of Pixels")

%% Convert the image from gray to BW
img_BW = zeros(665, 918); % initiate the BW image
threshold = [120, 170, 145]; 

for n = 1:3
    for i = 1:1:665
        for j = 1:1:918
            if (img_gray(i, j) > threshold(n))
                img_BW(i, j) = 1; 
            else 
                img_BW(i, j) = 0; 
            end
        end
    end
    figure(2)
    subplot(1, 3, n)
    imshow(img_BW)
    title(['The threshold = ' num2str(threshold(n))]);
end


%% Low-level information processing
img_stats = regionprops('table', bwconncomp(img_BW));
centroids = cat(1, img_stats.Centroid);

[B, L] = bwboundaries(img_BW, 'holes'); 

%% Plot the image
figure(3)
imshow(img)
hold on

plot(centroids(:,1),centroids(:,2), 'b*')

for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 3); 
   
  %randomize text position for better visibility
  rndRow = ceil(length(boundary)/(mod(rand*k,7)+1));
  col = boundary(rndRow,2); 
  row = boundary(rndRow,1);
  h = text(col+1, row-1, num2str(L(row,col)));
  set(h,'Color','blue','FontSize',14,'FontWeight','bold');
end

hold off