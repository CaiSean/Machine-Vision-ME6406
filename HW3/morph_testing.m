clear all; clc

A = [0 1 0 0; 
     0 1 0 0; 
     0 1 1 0; 
     1 0 0 0];

B = strel('rectangle', [1 2]); 

img_dil = imdilate(A, B);


C = [0 0 0 0 1 0 0; 
     0 1 1 1 1 0 0; 
     0 1 0 0 1 0 0; 
     1 1 1 1 1 0 0; 
     0 1 0 1 1 1 1; 
     0 1 1 1 1 0 0;
     0 1 1 1 1 0 0]; 

D = [1 1 1; 
     1 0 0; 
     1 1 1]; 
 
img_ero = imerode(C, D); 
imshow(img_ero)