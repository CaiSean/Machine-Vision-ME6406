function [weight_pj_new, weight_qp_new, error, iteration] = training(input, output,...
    weight_pj, weight_qp, alpha, acceptable_error)
iteration = 0; 
y_Q_diag_min = 0; 

if acceptable_error == 1
    for j = 1:3 % number of training samples
        for k = 1:4 % number of letters
            [y_P, y_Q] = Forward_Phase(input{1, j}(k, :), weight_pj, weight_qp);
            [weight_pj, weight_qp] = Backward_Phase(input{1, j}(k, :), output(k, :),...
            y_P, y_Q, weight_pj, weight_qp, alpha); 
        end
    end
    weight_pj_new = weight_pj; 
    weight_qp_new = weight_qp; 
else
    while (1-y_Q_diag_min) > acceptable_error 
        iteration = iteration+1; 
        for j = 1:3 % number of training samples
            for k = 1:4 % number of letters
                [y_P, y_Q] = Forward_Phase(input{1, j}(k, :), weight_pj, weight_qp);
                [weight_pj, weight_qp] = Backward_Phase(input{1, j}(k, :), output(k, :),...
                y_P, y_Q, weight_pj, weight_qp, alpha); 
                error_mtx(4*(j-1)+k) = error_cal(output(k, :), y_Q); 
                y_Q_mtx(k, :) = y_Q; 
            end
        end
        y_Q_diag_min = min(diag(y_Q_mtx)); 
        error(iteration) = sum(error_mtx); 
        weight_pj_new = weight_pj; 
        weight_qp_new = weight_qp; 
    end
end
