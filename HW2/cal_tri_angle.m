function [angles] = cal_tri_angle(x, y)

angles = zeros(length(x), 3);
for i = 1:length(x)
    
    angle1 = atan2d(abs((y(i, 1)-y(i, 2))), abs((x(i, 1)-x(i, 2))));
    angle2 = atan2d(abs((y(i, 1)-y(i, 3))), abs((x(i, 1)-x(i, 3))));
    angle3 = atan2d(abs((y(i, 2)-y(i, 3))), abs((x(i, 2)-x(i, 3))));
    
    angles(i, :) = [angle1, angle2, angle3]; 
end