%% Machine Vision Homework 3
% * Problem 1 Part a and b
% * Author: Xinyi Cai

%% Housekeeping
clc; 
clear all; 

%% Given values
X_W = [-2, -2, -1, -1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 2, 3, 3]'; 
Y_W = [1, 0, 1, 0, 5, 4, 3, 2, 1, 0, 5, 4, 3, 2, 1, 0, 5, 4, 5, 4]'; 
Z_W = zeros(1, 20)'; 

R = rotx(-150); 
T = [5, 3, 10]'; 
f = 1; 

%% Plot the coordinates 
% World Coordinate
world_origin = zeros(3, 3); 
world_coord = eye(3); 
% Camera Coordinate
cam_origin_temp = R'*([0; 0; 0]-T); 
cam_origin = ([cam_origin_temp, cam_origin_temp, cam_origin_temp]); 
cam_coord = R'*eye(3);
% Image Coordinate
img_origin_temp = cam_origin_temp+inv(R)*[0; 0; f]; 
img_origin = [img_origin_temp, img_origin_temp, img_origin_temp];
img_coord = [cam_coord(1:3, 1:2), [0; 0; 0]]; 

figure
hold on; grid on; rotate3d on
% World Coordinate
quiver3(world_origin(:, 1), world_origin(:, 2), world_origin(:, 3),...
        world_coord(:, 1), world_coord(:, 2), world_coord(:, 3),...
        'b', 'linewidth',3)
% Camera Coordinate
quiver3(cam_origin(1, :)', cam_origin(2, :)', cam_origin(3, :)',...
        cam_coord(1, :)', cam_coord(2, :)', cam_coord(3, :)',...
        'r', 'linewidth',3)
% Image Coordinate
quiver3(img_origin(1, :)', img_origin(2, :)', img_origin(3, :)',...
        img_coord(1, :)', img_coord(2, :)', img_coord(3, :)',... 
        'g', 'linewidth',3)
legend('World Coordinate', 'Camera Coordinate', 'Image Coordinate', 'Location','best')
title('World, Camera, and Image coordinates')
xlabel('X'); ylabel('Y'); zlabel('Z');
view(45, 8)
hold off


%% Step 1
xyz = R * [X_W'; Y_W'; Z_W'] + T; 
x(:, 1) = xyz(1, :); 
y(:, 1) = xyz(2, :); 
z(:, 1) = xyz(3, :); 
clear xyz

%% Step 2
for i = 1:length(x)
    X_u_temp = f*x(i)/z(i); 
    Y_u_temp = f*y(i)/z(i); 
    
    X_u(i, 1) = round(X_u_temp, 6); 
    Y_u(i, 1) = round(Y_u_temp, 6); 
end

figure
scatter3(X_W, Y_W, Z_W)
title('World Coordinate')
xlabel('Xw'); ylabel('Yw'); zlabel('Zw');
grid on
view(0, 90)

figure
scatter3(x, y, z, 'g')
title('Camera Coordinate')
xlabel('xc'); ylabel('yc'); zlabel('zc');
grid on
view(-45, 45)

figure
scatter(X_u, Y_u, 'b')
title('Image Coordinate')
xlabel('u'); ylabel('v');
grid on


%% Save data for part c
save Problem_1ab_data.mat X_W Y_W X_u Y_u 
