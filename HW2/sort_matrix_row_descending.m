%% Machine Vision Homework 2
% Supporting function for Problem 3 Part b
% Arthor: Xinyi Cai
% This function sort the values in each row of a matix in descending order

function [sorted_matrix] = sort_matrix_row_descending(unsorted_matrix)
 
sorted_matrix = zeros(length(unsorted_matrix), 4); 
for i = 1:length(unsorted_matrix)
    temp1 = unsorted_matrix(i, 1); 
    temp2 = unsorted_matrix(i, 2); 
    temp3 = unsorted_matrix(i, 3); 
    
    if temp1 > temp2 && temp1 > temp3
        sorted_matrix(i, 1) = temp1;
        if temp2 > temp3
            sorted_matrix(i, 2) = temp2;
            sorted_matrix(i, 3) = temp3;
        else
            sorted_matrix(i, 2) = temp3;
            sorted_matrix(i, 3) = temp2; 
        end
    elseif temp2 > temp1 && temp2 > temp3
        sorted_matrix(i, 1) = temp2;
        if temp1 > temp3
            sorted_matrix(i, 2) = temp1;
            sorted_matrix(i, 3) = temp3;
        else
            sorted_matrix(i, 2) = temp3;
            sorted_matrix(i, 3) = temp1; 
        end
    else
        sorted_matrix(i, 1) = temp3;
        if temp1 > temp2
            sorted_matrix(i, 2) = temp1;
            sorted_matrix(i, 3) = temp2;
        else
            sorted_matrix(i, 2) = temp2;
            sorted_matrix(i, 3) = temp1; 
        end
    end
    
    sorted_matrix(i, 4) = i;
    
    clear temp1 temp2 temp3 
end