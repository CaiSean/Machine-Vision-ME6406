%% Machine Vision Homework 3
% Problem 2 Part a
% Arthor: Xinyi Cai

%% Housekeeping
clc; 
clear all; 

%% Load the image
img = imread('chip.jpg');

%% Image Process
SE_lead = ones(5, 11);
SE_chip = ones(147, 82);

% Path 1
img_BW_1 = im2bw(img, 0.36); 
img_BW_1 = imcomplement(img_BW_1);
img_morph_1 = imdilate(img_BW_1, SE_lead);
img_morph_1 = imcomplement(img_morph_1); 
img_morph_1 = imerode(img_morph_1, SE_lead);
% img_morph_1 = imcomplement(img_morph_1); 
% img_morph_1 = imerode(img_morph_1, SE_chip);
% img_morph_1 = imerode(img_morph_1, SE_lead);
% img_morph_1 = imerode(img_morph_1, SE_lead);
imshow(img_morph_1)
img_morph_1 = bwmorph(img_morph_1, 'shrink');

img_morph_1 = imdilate(img_morph_1, SE_lead);

%imshow(img_morph_1)

% Path 2
img_BW_2 = im2bw(img, 0.65);
img_morph_2 = bwmorph(img_BW_2, 'open');
img_morph_2 = imdilate(img_morph_2, SE_lead);
img_morph_2 = imcomplement(img_morph_2);
img_morph_2 = imdilate(img_morph_2, SE_lead);
img_morph_2 = bwmorph(img_morph_2, 'shrink');
% imshow(img_morph_2)

% Path 1 + Path 2
img_morph = img_morph_1 + img_morph_2; 
img_morph = imdilate(img_morph, SE_lead);
% imshow(img_morph)