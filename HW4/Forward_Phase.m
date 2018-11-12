% Initial weight_pj must be a Np X Nj dimension matrix
% Initial weight_qp must be a Nq X Np dimension matrix

function [y_P, y_Q] = Forward_Phase(input, weight_pj, weight_qp)

Nj = length(input); 
[Nq, Np] = size(weight_qp); 

%% FP: Layer P
for i = 1:Np 
    for j = 1:Nj 
        temp(j) = weight_pj(i, j)*input(j);
    end
    y_P(i) = sigmf(sum(temp), [1 0]); 
end
clear temp

%% FP: Layer Q
for i = 1:Nq 
    for j = 1:Np 
        temp(j) = weight_qp(i, j)*y_P(j);
    end
    y_Q(i) = sigmf(sum(temp), [1 0]); 
end
clear temp

