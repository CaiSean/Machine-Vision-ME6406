function [weight_pj_new, weight_qp_new, error] = training(input, output,...
    weight_pj, weight_qp, alpha, iteration)

for i = 1:iteration
    for j = 1:3 % number of training samples
        for k = 1:4 % number of letters
            [y_P, y_Q] = Forward_Phase(input{1, j}(k, :), weight_pj, weight_qp);
            [weight_pj, weight_qp] = Backward_Phase(input{1, j}(k, :), output(k, :),...
            y_P, y_Q, weight_pj, weight_qp, alpha); 
            error_mtx(4*(j-1)+k) = error_cal(output(k, :), y_Q); 
        end
    end
    error(i) = sum(error_mtx); 
   
    weight_pj_new = weight_pj; 
    weight_qp_new = weight_qp; 
end
