function [weight_qp_new, weight_pj_new] = ANN_Backward_Phase(input, output,...
    y_P, y_Q, weight_qp_old, weight_pj_old, alpha)

Nj = length(input); 
[Nq, Np] = size(weight_qp_old); 

%% BP: Layer Q
for i = 1:Nq
    delta_Q(i) = y_Q(i)*(1-y_Q(i))*(output(i)-y_Q(i));
end

for i = 1:Nq
    for j = 1:Np
        delta_weight_qp(i, j) = alpha*delta_Q(i)*y_P(j); 
        weight_qp_new(i, j) = weight_qp_old(i, j)+delta_weight_qp(i, j); 
    end
end

%% BP: Layer P
for i = 1:Np
    for j = 1:Nq
        temp(j) = weight_qp(j, i)*delta_Q(j);
    end
    delta_P(i) = y_P(i)*(1-y_P(i))*sum(temp);
end
clear temp

for i = 1:Np
    for j = 1:Nj
        delta_weight_pj(i, j) = alpha*delta_P(i)*input(1, j); 
        weight_pj_new(i, j) = weight_pj_old(i, j)+delta_weight_pj(i, j); 
    end
end