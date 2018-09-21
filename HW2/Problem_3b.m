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

x_i = [3.147, 4.748, 6.223, 3.321]'; 
y_i = [9.726, 7.3, 12.453, 12.628]'; 

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
[tri_length_t, tri_angle_t] = cal_tri_length(C_x_t, C_y_t);
[tri_length_i, tri_angle_i] = cal_tri_length(C_x_i, C_y_i);

%% Sorting length and orders
[tri_length_t_sort] = sort_matrix_row_descending(tri_length_t);
[tri_length_i_sort] = sort_matrix_row_descending(tri_length_i);
[tri_angle_t_sort] = sort_matrix_row_descending(tri_angle_t);
[tri_angle_i_sort] = sort_matrix_row_descending(tri_angle_i);

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
tolerance_length = 1.8e-4; 
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
hold on
colors = ['b', 'k', 'r', 'g', 'y', 'm']; 

for i = 1:length(point_loc_x_t)
    plot([point_loc_x_t(i, :), point_loc_x_t(i, 1)],...
         [point_loc_y_t(i, :), point_loc_y_t(i, 1)], colors(i)); 
    plot([point_loc_x_i(i, :), point_loc_x_i(i, 1)],...
         [point_loc_y_i(i, :), point_loc_y_i(i, 1)], colors(i)); 
end

xlim([0 15])
ylim([0 15])
hold off

%% Transformation parameters calculation


% X_c = 0.5*(max(x_t)-min(x_t)); 
% Y_c = 0.5*(max(y_t)-min(y_t)); 

j = 1:2:(2*length(point_loc_x_t)-1);
k = 2:2:(2*length(point_loc_x_t)); 

for i = 1:length(point_loc_x_t)
    A(j(i):j(i)+1, 1:4) = [point_loc_x_t(i), -point_loc_y_t(i), 1, 0;...
                           point_loc_y_t(i), point_loc_x_t(i), 0, 1];
    R(j(i), 1) = point_loc_x_i(i); 
    R(k(i), 1) = point_loc_y_i(i);
end

Q = pinv(A)*R; 

k = sqrt(Q(1)^2+Q(2)^2)
theta = atan2(Q(2), Q(1))*180/pi
% x_d = Q(3) - X_c
% y_d = Q(4) - Y_c















