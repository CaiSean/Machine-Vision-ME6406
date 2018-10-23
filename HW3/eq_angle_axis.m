%% Machine Vision Homework 3
% Problem 2 Part b
% Arthor: Xinyi Cai

%% Parameters
% Input:
% R: Rotation matrix

% Outputs: 
% n: Rotation axis
% theta: degrees around the rotation axis

%% Function
function [n, theta] = eq_angle_axis(R)

theta = acosd(0.5*(R(1, 1)+R(2, 2)+R(3, 3)-1)); 

if theta == 0
    n = zeros(3, 1); 
    n = n';
elseif theta == 180
    for i = 1:3
        n(i, 1) = (R(i, i)-cosd(theta))/(1-cosd(theta)); 
    end

elseif theta < 0
    disp('Error! Theta must be positive to calculate rotation axis n')
    
else
    n = (1/(2*sind(theta)))*[R(3, 2)-R(2, 3);...
                             R(1, 3)-R(3, 1);...
                             R(2, 1)-R(1, 2)];
end

