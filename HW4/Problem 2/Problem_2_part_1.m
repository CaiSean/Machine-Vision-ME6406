%% Machine Vision Homework 4
% * Problem 2 Part 1 Subpart 2
% * Author: Xinyi Cai

%% Housekeeping
clear all; clc

%% Parameters
sig_c = 1; 
sig_s = 10; 

img_target = zeros(100, 100, 3, 'uint8'); 
img_noise = zeros(100, 100, 3, 'uint8'); 

target_color = [100, 96, 215]; 
noise_color = [101, 100, 149]; 

for i = 1:100
    for j = 1:100
        for k = 1:3
            img_target(i, j, k) = target_color(k); 
            img_noise(i, j, k) = noise_color(k);
        end
    end
end

img = [img_target, img_noise]; 

%% LOGIC
h1 = ACC_trans(img, 'h1');
h2 = ACC_trans(img, 'h2');
h3 = ACC_trans(img, 'h3');
ha = ACC_trans(img, 'ha');
hb = ACC_trans(img, 'hb');
hc = ACC_trans(img, 'hc');

% Original Image
subplot(5, 2, 1:2); imshow(img)
title('Original Image')

% 1-2-3
h_123 = combined_mtx(h1, h2, h3);
subplot(5, 2, 3); imshow(h_123)
title('1-2-3')

% 1-2-c
h_12c = combined_mtx(h1, h2, hc);
subplot(5, 2, 4); imshow(h_12c)
title('1-2-c')
        
% 1-b-3
h_1b3 = combined_mtx(h1, hb, h3);
subplot(5, 2, 5); imshow(h_1b3)
title('1-b-3')

% 1-b-c
h_1bc = combined_mtx(h1, hb, hc);
subplot(5, 2, 6); imshow(h_1bc)
title('1-b-c')

% a-2-3
h_a23 = combined_mtx(ha, h2, h3);
subplot(5, 2, 7); imshow(h_a23)
title('a-2-3')

% a-2-c
h_a2c = combined_mtx(ha, h2, hc);
subplot(5, 2, 8); imshow(h_a2c)
title('a-2-c')

% a-b-3
h_ab3 = combined_mtx(ha, hb, h3);
subplot(5, 2, 9); imshow(h_ab3)
title('a-b-3')

% a-b-c
h_abc = combined_mtx(ha, hb, hc);
subplot(5, 2, 10); imshow(h_abc)
title('a-b-c')