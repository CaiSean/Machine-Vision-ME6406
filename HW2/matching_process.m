%% Machine Vision Homework 2
% Supporting function for Problem 3 Part b
% Arthor: Xinyi Cai

% n = 0 when the difference between two data arrays are NOT found. 
% n = 1 when the difference between two data arrays are found. 
function [matched_pairs] = matching_process(raw_data, tolerance, n)

count = 1;
if n == 0 
    for i = 1:length(raw_data)
        diff1 = abs(raw_data(i, 1) - raw_data(i, 2)); 
        diff2 = abs(raw_data(i, 1) - raw_data(i, 3)); 
        diff3 = abs(raw_data(i, 2) - raw_data(i, 3)); 

        if (diff1 < tolerance) && (diff2 < tolerance) && (diff3 < tolerance)
           matched_pairs(count, :) = [raw_data(i, 1), raw_data(i, 2), raw_data(i, 3),...
                                         raw_data(i, 4), raw_data(i, 5)];
        count = count + 1; 
        end
    end
    
elseif n == 1
    for i = 1:length(raw_data)
        if (raw_data(i, 1) < tolerance) &&...
           (raw_data(i, 2) < tolerance) &&...
           (raw_data(i, 3) < tolerance)
           matched_pairs(count, :) = [raw_data(i, 1), raw_data(i, 2), raw_data(i, 3),...
                                         raw_data(i, 4), raw_data(i, 5)];
           count = count + 1; 
        end
    end
end
