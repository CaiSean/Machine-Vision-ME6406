function val_output = check_num_error(val_input)
clear val_output

tolerance = 1e-5; 

if abs(val_input) < tolerance
    val_output = 0; 
else 
    val_output = val_input; 
end

