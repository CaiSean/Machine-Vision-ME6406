%% Machine Vision Homework 3
% Problem 2 Part a
% Arthor: Xinyi Cai

%% Housekeeping
clc; 
clear all; 

%% Load the image
img = imread('chip.jpg');

%% Image Process

SE_lead = strel('rectangle', [5 11]);
SE_chip = strel('rectangle', [147 82]);
SE_1 = strel('rectangle', [5 10]);
SE_2 = strel('rectangle', [8 4]);
SE_3 = strel('rectangle', [3 3]);
SE_4 = strel('rectangle', [4 2]);
SE_5 = strel('rectangle', [2 2]);

% Path 1
img_BW_1 = im2bw(img, 0.5); 
img_morph_1 = imerode(img_BW_1, SE_1);
% img_morph_1 = bwmorph(img_morph_1, 'open');
img_morph_1 = imdilate(img_morph_1, SE_1);

img_morph_1 = bwmorph(img_morph_1, 'branchpoint');
figure; imshow(img_morph_1)
img_morph_1 = bwmorph(img_morph_1, 'thicken', 2);
img_morph_1 = bwmorph(img_morph_1, 'fill', 5);


img_BW_2 = im2bw(img, 0.36); 
img_BW_2 = imcomplement(img_BW_2);
img_morph_2 = imdilate(img_BW_2, SE_1);
img_morph_2 = imcomplement(img_morph_2);
figure; imshow(img_morph_2)

img_morph = img_morph_1-img_morph_2;

img_morph = imdilate(img_morph, SE_3);
img_morph = imdilate(img_morph, SE_3);

figure; imshow(img_morph)