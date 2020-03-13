function output = combined_mtx(a, b, c)

[rows, columns] = size(a); 
output = zeros(rows, columns-1, 3, 'uint8');

for i = 1:rows
    for j = 1:columns-1
        output(i, j, :) = [a(i, j); b(i, j); c(i, j)]; 
    end
end
