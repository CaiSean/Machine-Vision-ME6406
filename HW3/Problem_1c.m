%% Machine Vision Homework 3
% Problem 1 Part c
% Arthor: Xinyi Cai

%% Housekeeping
clc; 
clear all; 

%% Given values
load Problem_1ab_data.mat

%% Stage 1: Radial alignment constraint
for i = 1:length(X_W)
    A(i, :) = [X_W(i)*Y_u(i), Y_W(i)*Y_u(i),...
               -X_W(i)*X_u(i), -Y_W(i)*X_u(i), Y_u(i)]; 
    
    b(i, :) = X_u(i); 
end

x = A\b; 

r11_ = x(1); r12_ = x(2); 
r21_ = x(3); r22_ = x(4); 
tx_ = x(5); 

clear A b x

Sr = r11_^2 + r12_^2 + r21_^2 + r22_^2; 

diff = r11_*r22_ - r12_*r21_; 

if diff == 0
    ty = sqrt(1/Sr); 
else 
    ty = sqrt((Sr-sqrt(Sr^2-4*diff^2))/(2*diff^2)); 
end

clear diff

%% Check ty sign
ty = sqrt(ty^2); 
r11 = r11_ * ty; 
r12 = r12_ * ty; 
r21 = r21_ * ty; 
r22 = r22_ * ty; 
tx = tx_ * ty; 

sigma_x = r11 * X_W(1) + r12 * Y_W(1) + tx(1); 
sigma_y = r21 * X_W(1) + r22 * Y_W(1) + ty(1);

if sign(sigma_x) ~= sign(X_u(1)) ||...
   sign(sigma_y) ~= sign(Y_u(1))
    ty = -ty; 
end

clear sigma_x sigma_y

r11 = r11_ * ty; 
r12 = r12_ * ty; 
r21 = r21_ * ty; 
r22 = r22_ * ty; 
tx = tx_ * ty;
clear r11_ r12_ r21_ r22_ tx_

%% Check S1, S2 signs
S1 = 1; S2 = 1; 
S1S2 = sign(r11*r21 + r12*r22);

if S1S2 == -1
    S1 = 1; 
    S2 = 1; 
elseif S1S2 == 1
    S1 = 1; 
    S2 = -1; 
end

r13 = round(S1*sqrt(1 - r11^2 - r12^2), 2);
r23 = round(S2*sqrt(1 - r21^2 - r22^2), 2);

temp = cross([r11; r12; r13], [r21; r22; r23]); 
r31 = round(temp(1), 5); 
r32 = round(temp(2), 5); 
r33 = round(temp(3), 5); 
clear temp

r11 = check_num_error(r11);
r12 = check_num_error(r12);
r21 = check_num_error(r21);
r22 = check_num_error(r22);

R = [r11, r12, r13;... 
     r21, r22, r23;...
     r31, r32, r33];

%% Stage 2: Perspective Constraint
a = r11*X_W + r12*Y_W + tx; 
Rd_sq = X_u.^2+Y_u.^2;  
c = X_u; 
w = r31*X_W + r32*Y_W; 

for i = 1:length(a)
    A(i, :) = [a(i), a(i)*Rd_sq(i), -c(i)]; 
    B(i, :) = X_u(i) * w(i); 
end

x = A\B; 

f = x(1)    % focus length
k = x(2)/f;  % lens distortion
tz = x(3);  % z direction in transformation matrix

clear A B a b c w x

T = [tx; ty; tz]    % transformation matrix

%% Check S1 and S2 again
if f < 0 
    S1 = -1; 
    S2 = 1;  
end

r13 = round(S1*sqrt(1 - r11^2 - r12^2), 2);
r23 = round(S2*sqrt(1 - r21^2 - r22^2), 2);

R = [r11, r12, r13;... 
     r21, r22, r23;...
     r31, r32, r33]