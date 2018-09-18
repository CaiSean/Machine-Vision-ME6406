%% Machine Vision Homework 1
% Problem 3
% Arthor: Xinyi Cai

%% Part a

% Housekeeping
clc;
clear all; 

% Solution
x = [118, 115, 110, 119, 122, 118, 126, 122, 125]; 
w_x = [-1, -2, -1, 0, 0, 0, 1, 2, 1]; 
w_y = [-1, 0, 1, -2, 0, 2, -1, 0, 1]; 
G_x_a = w_x*x';
G_y_a = w_y*x'; 
G_mag = rssq([G_x_a G_y_a]); 
G_ang = rad2deg(atan(abs(G_y_a/G_x_a)));

%% Part b

% Housekeeping
clc;
clear all; 

% Solution
img_checker = imread('checker.png');
[img_checker_BW,threshOut,G_x_b,G_y_b] = edge(img_checker);
imshow(img_checker_BW)

%% Part c

% Housekeeping
clc;
clear all; 

% Solution
x = -5:0.5:5; 
y = -5:0.5:5; 
[X,Y] = meshgrid(x,y); 

sigma = [1, 2, 5]; 

for n = 1:3
    G = 1/(2*pi*sigma(n)^2)*exp(-(X.^2+Y.^2)/(2*sigma(n)^2));
    subplot(1, 3, n)
    surf(X, Y, G)
    title(['\sigma = ' num2str(sigma(n))]);
end

%% Part d

% Housekeeping
clc;
clear all; 

% Solution
img_SnP_checker = imread('salt_and_pepper_noise.png'); 

sigma = [1, 2, 5]; 

for n = 1:3
    img_smoothed = imgaussfilt(img_SnP_checker, sigma(n)); 
    subplot(1, 3, n)
    imshow(img_smoothed)
    title(['\sigma = ' num2str(sigma(n))]);
end

%% Part e

% Housekeeping
clc;
clear all; 

% Solution
img_checker = imread('checker.png');

img_sigma_1 = imgaussfilt(img_checker, 1); 
img_sigma_5 = imgaussfilt(img_checker, 5); 
DoG = img_sigma_1-img_sigma_5; 
% img_DoG_edge = edge(DoG); 
% imshow(img_DoG_edge)
imshow(DoG)
