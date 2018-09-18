%% Machine Vision Homework 1
% Problem 2 part b
% Arthor: Xinyi Cai

%% Housekeeping
clc;
clear all; 

%% Load the image
img = imread('pollen.bmp');

%% Histogram of Original Image
figure(1)
hold on
subplot(221)
imshow(img)
title("Original Image")
subplot(222)
imhist(img)
title("Original Image Histogram")
ylim([0 2e4])
ylabel("Number of Pixels")

%% Histogram of Treated Image
img_histeq = histeq(img); 

subplot(223)
imshow(img_histeq)
title("Histogram Equalized Image")
subplot(224)
imhist(img_histeq)
title("Histogram Equalized Image Histogram")
ylim([0 2e4])
ylabel("Number of Pixels")
hold off

