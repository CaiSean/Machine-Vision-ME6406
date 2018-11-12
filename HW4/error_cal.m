function [E] = error_cal(y_desire, y)

for i = 1:length(y)
    temp = (y_desire(i)-y(i)).^2; 
end

E = 0.5*sum(temp); 