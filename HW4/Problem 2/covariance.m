function [output] = covariance(v1, v2)

N1 = numel(v1); 
N2 = numel(v2); 

v1_bar = sum(v1)/N1; 
v2_bar = sum(v2)/N2; 

for i = 1:N1
    temp(i) = (v1(i)-v1_bar)*(v2(i)-v2_bar); 
end

output = 1/(N1-1)*sum(temp); 