%% Machine Vision Homework 2
% Problem 3 Part b
% Arthor: Xinyi Cai

%% Part 2
% Housekeeping
clc; 
clear all; 

%% Given points
x_t = [1, 3, 4, 3, 1, 0]'; 
y_t = [0, 0, 3, 5, 4, 2]'; 
idx_t = [1, 2, 3, 4, 5, 6]';

x_i = [3.147, 4.748, 6.223, 3.321]'; 
y_i = [9.726, 7.3, 12.453, 12.628]'; 
idx_i = ['a', 'b', 'c', 'd']'; 

%% Find all possible permutations of vertices to form unique triangles
C_x_t = nchoosek(x_t, 3); 
C_y_t = nchoosek(y_t, 3); 

C_x_i = nchoosek(x_i, 3); 
C_y_i = nchoosek(y_i, 3); 

%% Plot the triangles
% figure; 
% hold on
% for i = 1:length(C_x_t)
%     plot([C_x_t(i, :), C_x_t(i, 1)], [C_y_t(i, :), C_y_t(i, 1)])
% end
% 
% for i = 1:length(C_x_i)
%     plot([C_x_i(i, :), C_x_i(i, 1)], [C_y_i(i, :), C_y_i(i, 1)])
% end
% 
% xlim([0 15])
% ylim([0 15])
% hold off

%% Find the length and angle in triangles
[tri_length_t, tri_angle_t] = cal_tri_angle_length(C_x_t, C_y_t);
[tri_length_i, tri_angle_i] = cal_tri_angle_length(C_x_i, C_y_i);

%% Sorting length and orders
[tri_length_t_sort, I_t] = sort(tri_length_t(:, 1:3), 2, 'descend'); 
[tri_length_i_sort, I_i] = sort(tri_length_i(:, 1:3), 2, 'descend'); 
[tri_angle_t_sort] = sort(tri_angle_t(:, 1:3), 2, 'descend'); 
[tri_angle_i_sort] = sort(tri_angle_i(:, 1:3), 2, 'descend'); 

tri_length_t_sort = [tri_length_t_sort, tri_length_t(:, 4)]; 
tri_length_i_sort = [tri_length_i_sort, tri_length_i(:, 4)]; 
tri_angle_t_sort = [tri_angle_t_sort, tri_angle_t(:, 4)]; 
tri_angle_i_sort = [tri_angle_i_sort, tri_angle_i(:, 4)]; 

%% Find the ratio between the template and image triangle length
count = 1;
length_ratio = zeros(length(tri_length_t_sort)*length(tri_length_i_sort), 5); 
for i = 1:length(tri_length_t_sort)
    for j = 1:length(tri_length_i_sort)
        ratio1 = tri_length_t_sort(i, 1)/tri_length_i_sort(j, 1); 
        ratio2 = tri_length_t_sort(i, 2)/tri_length_i_sort(j, 2); 
        ratio3 = tri_length_t_sort(i, 3)/tri_length_i_sort(j, 3); 
        
        length_ratio(count, :) = [ratio1, ratio2, ratio3,...
                                  tri_length_t_sort(i, 4), tri_length_i_sort(j, 4)]; 
        count = count + 1;
        
        clear ratio1 ratio2 ratio3
    end 
end

%% Find the difference in angles between the template and image triangles
count = 1; 
diff_angle = zeros(length(tri_angle_t_sort)*length(tri_angle_i_sort), 5); 
for i = 1:length(tri_angle_t_sort)
    for j = 1:length(tri_angle_i_sort)
        diff_angle1 = abs(tri_angle_t_sort(i, 1) - tri_angle_i_sort(j, 1));
        diff_angle2 = abs(tri_angle_t_sort(i, 2) - tri_angle_i_sort(j, 2));
        diff_angle3 = abs(tri_angle_t_sort(i, 3) - tri_angle_i_sort(j, 3));

        diff_angle(count, :) = [diff_angle1, diff_angle2, diff_angle3,...
                                tri_angle_t_sort(i, 4), tri_angle_i_sort(j, 4)];
        count = count + 1;
        
        clear diff_angle1 diff_angle2 diff_angle3
    end 
end

%% Find the matched pairs
tolerance_length = 2e-4; 
tolerance_angle = 2e-2; 

[matched_pairs_length] = matching_process(length_ratio, tolerance_length, 0);
[matched_pairs_angle] = matching_process(diff_angle, tolerance_angle, 1);

%% Both angles and length ratio matches
count = 1;
for i = 1:length(matched_pairs_length)
    for j = 1:length(matched_pairs_angle)
        if matched_pairs_length(i, 4) == matched_pairs_angle(j, 4) &&...
           matched_pairs_length(i, 5) == matched_pairs_angle(j, 5)
            point_loc_x_t(count, :) = C_x_t(matched_pairs_length(i, 4), :); 
            point_loc_y_t(count, :) = C_y_t(matched_pairs_length(i, 4), :); 
            point_loc_x_i(count, :) = C_x_i(matched_pairs_length(i, 5), :); 
            point_loc_y_i(count, :) = C_y_i(matched_pairs_length(i, 5), :); 
            
            count = count + 1; 
        end
    end
end


%% Plot the best matched triangles
figure; 

for i = 1:length(point_loc_x_t)
    subplot(2, 3, i)
    plot([point_loc_x_t(i, :), point_loc_x_t(i, 1)],...
         [point_loc_y_t(i, :), point_loc_y_t(i, 1)],'r'); 
    hold on
    plot([point_loc_x_i(i, :), point_loc_x_i(i, 1)],...
         [point_loc_y_i(i, :), point_loc_y_i(i, 1)], 'b'); 
    
    for j = 1:3
        offset = 0.8;
        text(point_loc_x_t(i, j) - offset, point_loc_y_t(i, j) + offset,...
             ['(' num2str(point_loc_x_t(i, j)),',' num2str(point_loc_y_t(i, j)) ')']);
        text(point_loc_x_i(i, j) - offset, point_loc_y_i(i, j) + offset,...
             ['(' num2str(point_loc_x_i(i, j)),',' num2str(point_loc_y_i(i, j)) ')']);
    end
    title(['Triangle ', num2str(i)])
    xlim([0 15])
    ylim([0 15])
    legend('Template', 'Image')
    hold off
end

%% Transformation parameters calculation
% From the subplot, we can observe that triangle 4 and 6 will reassemble
% the template. The following are the template to image corresponding
% matching points. 
% Point 5 (1, 4) -> Point a (3.147, 9.726)
% Point 6 (0, 2) -> Point b (4.748, 7.3)
% Point 3 (4, 3) -> Point c (6.223, 12.453)
% Point 4 (3, 5) -> Point d (3.321, 12.628)

x_t = [1, 0, 4, 3]'; 
y_t = [4, 2, 3, 5]'; 
x_i = [3.147, 4.748, 6.223, 3.321]'; 
y_i = [9.726, 7.3, 12.453, 12.628]'; 

a = 1:2:(length(x_t)*2-1);
b = 2:2:length(x_t)*2;
 
for i = 1:length(x_t)

    A(a(i):a(i)+1, 1:4) = [x_t(i), -y_t(i), 1, 0;...
                           x_t(i), y_t(i), 0, 1];
    R(a(i), 1) = x_i(i);
    R(b(i), 1) = y_i(i);
    
end

clear a b

Q = pinv(A)*R;

X_c = 0.5 * (max(x_t(i)) - min(x_t(i))); 
Y_c = 0.5 * (max(y_t(i)) - min(y_t(i))); 

K = sqrt(Q(1)^2 + Q(2)^2)
theta = atan2(Q(2), Q(1)) * 180/pi
x_d = Q(3) - X_c
y_d = Q(4) - Y_c
