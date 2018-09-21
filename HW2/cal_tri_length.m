function [length_mtx, angle_mtx] = cal_tri_length(x, y)

length_mtx = zeros(length(x), 4); % Initial the matrix
angle_mtx = zeros(length(x), 4); % Initial the matrix

for i = 1:length(x)
    A = [x(i, 1), y(i, 1)]; 
    B = [x(i, 2), y(i, 2)]; 
    C = [x(i, 3), y(i, 3)]; 
    
    sides = @(x1, x2, y1, y2) sqrt((x1-x2)^2+(y1-y2)^2);
    c = sides(A(1), B(1), A(2), B(2)); 
    b = sides(A(1), C(1), A(2), C(2)); 
    a = sides(B(1), C(1), B(2), C(2)); 
    
    length_mtx(i, :) = [c, b, a, i];
    
    angle = @(x1, x2, x3) acosd(-(x1^2-(x2^2+x3^2))/(2*x2*x3));
    
    angle_A = angle(a, b, c); 
    angle_B = angle(b, c, a); 
    angle_C = angle(c, b, a); 
    
    angle_mtx(i, :) = [angle_A, angle_B, angle_C, i]; 
    
    clear A B C
end

