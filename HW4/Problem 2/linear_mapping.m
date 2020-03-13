function vout = linear_mapping(vector, range)

a = min(vector);
b = max(vector);
c = range(1);
d = range(2);
vout = ((c+d)+(d-c)*((2*vector-(a+b))/(b-a)))/2;
end