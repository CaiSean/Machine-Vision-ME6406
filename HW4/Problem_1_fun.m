% Initial weight_pj must be a Np X Nj dimension matrix
% Initial weight_qp must be a Nq X Np dimension matrix

function [y_P, y_Q]=Forward_Phase(input, weight_pj, weight_qp)

Nj = length(input); 
[Nq, Np] = size(weight_qp); 

% FP: Layer P
for i = 1:Np 
    for j = 1:Nj 
        temp(j) = weight_pj(i, j)*input(j);
    end
    y_P(i) = sigmf(sum(temp), [1 0]); 
end
clear temp

% FP: Layer Q
for i = 1:Nq 
    for j = 1:Np 
        temp(j) = weight_qp(i, j)*y_P(j);
    end
    y_Q(i) = sigmf(sum(temp), [1 0]); 
end
clear temp


function [weight_pj_new, weight_qp_new] = Backward_Phase(input, output,...
    y_P, y_Q, weight_pj_old, weight_qp_old, alpha)

Nj = length(input); 
[Nq, Np] = size(weight_qp_old); 
% Nq = 4; Np = 15; Nj = 25; 
% BP: Layer Q
for i = 1:Nq
    delta_Q(i) = y_Q(i)*(1-y_Q(i))*(output(i)-y_Q(i));
end

for i = 1:Nq
    for j = 1:Np
        delta_weight_qp(i, j) = alpha*delta_Q(i)*y_P(j); 
        weight_qp_new(i, j) = weight_qp_old(i, j)+delta_weight_qp(i, j); 
    end
end

% BP: Layer P
for i = 1:Np
    for j = 1:Nq
        temp(j) = weight_qp_new(j, i)*delta_Q(j);
    end
    delta_P(i) = y_P(i)*(1-y_P(i))*sum(temp);
end
clear temp

for i = 1:Np
    for j = 1:Nj
        delta_weight_pj(i, j) = alpha*delta_P(i)*input(j); 
        weight_pj_new(i, j) = weight_pj_old(i, j)+delta_weight_pj(i, j); 
    end
end

function [E] = error_cal(y_desire, y)

for i = 1:length(y)
    temp = (y_desire(i)-y(i)).^2; 
end

E = 0.5*sum(temp); 