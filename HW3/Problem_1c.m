%% Machine Vision Homework 3
% Problem 1 Part c
% Arthor: Xinyi Cai

%% Housekeeping
clc; 
clear all; 

%% Given values
load Problem_1ab_data.mat

%% Stage 1
for i = 1:length(X_W)
    A(i, :) = [X_W(i)*Y_u(i), Y_W(i)*Y_u(i), -X_W(i)*X_u(i), -Y_W(i)*X_u(i), Y_u(i)]; 
    
    b(i, :) = X_u(i); 
end

x = A\b; 

r11_ = x(1); 
r12_ = x(2); 
r21_ = x(3); 
r22_ = x(4); 
tx_ = x(5); 

clear A b x

%% Stage 2
Sr = r11_^2 + r12_^2 + r21_^2 + r22_^2; 

diff = r11_*r22_ - r12_*r22_; 

if diff == 0
    ty = sqrt(1/Sr); 
else 
    ty = sqrt((Sr-sqrt(Sr^2-4*diff^2))/(2*diff^2)); 
end

clear diff

ty = [ty; -ty]; 

%% Calculate the rotation matrix
ty = sqrt(ty(1)^2); 
r11 = r11_ * ty; 
r12 = r12_ * ty; 
r21 = r21_ * ty; 
r22 = r22_ * ty; 
tx = tx_ * ty; 
clear r11_ r12_ r21_ r22_ tx_

sigma_x = r11 * X_W + r12 * Y_W + tx; 
sigma_y = r21 * X_W + r22 * Y_W + ty;

flag = zeros(length(sigma_x), 1); 

for i = 1:length(sigma_x)
    if sign(sigma_x(i)) == sign(X_u(i)) &&...
       sign(sigma_x(i)) == sign(X_u(i))
        flag(i, 1) = 1;
    else 
        flag(i, 1) = 0;
        disp('Two coordinates are not in the same quardant')
        break; 
    end
end
clear sigma_x sigma_y flag

r13 = round(sqrt(1 - r11^2 - r12^2), 2);
r23 = round(sqrt(1 - r21^2 - r22^2), 2);

temp = cross([r11; r12; r13], [r21; r22; r23]); 
r31 = round(temp(1), 5); 
r32 = round(temp(2), 5); 
r33 = round(temp(3), 5); 
clear temp

S1 = 1; 
S2 = 1; 

if -sign(r11*r12 + r12*r22) == -1
    S1 = 1; 
    S2 = 1; 
elseif -sign(r11*r12 + r12*r22) == 1
    S1 = -1; 
    S2 = 1; 
end

r11 = check_num_error(r11);
r12 = check_num_error(r12);
r21 = check_num_error(r21);
r22 = check_num_error(r22);

R = [r11, r12, S1*r13;... 
     r21, r22, S2*r23;...
     r31, r32, r33]

clear S1 S2

%% Calculate Tz and f
y = r21*X_W + r22*Y_W + ty; 
w = r31*X_W + r32*Y_W; 

for i = 1:length(y)
    A(i, :) = [y(i), -Y_u(i)]; 
    b(i, :) = w(i)*Y_u(i); 
end

x = A\b; 
f = x(1)
tz = x(2); 
clear A b x y w

T = [tx; ty; tz]
