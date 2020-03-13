function [output]=ACC_trans(input, str)

gaus_fun = @(x, y, sigma) 1/(sigma*sqrt(2*pi))*exp(-(x.^2+y.^2)/(2*sigma.^2)); 

sig_c = 1; 
sig_s = 10; 
x = -100:1:100;
y = -100:1:100;
G_sig_c = gaus_fun(x, y, sig_c);
G_sig_s = gaus_fun(x, y, sig_s);

switch str
    case char('h1')
        for i = 1:100
            output(i, :) = conv(G_sig_c, input(i, :, 1), 'same')...
                - conv(G_sig_s, input(i, :, 1)-input(i, :, 2), 'same'); 
        end
    case char('h2')
        for i = 1:100
            output(i, :) = conv(G_sig_c, input(i, :, 2), 'same')...
                - conv(G_sig_s, input(i, :, 1)-input(i, :, 2), 'same'); 
        end
    case char('h3')
        for i = 1:100
            output(i, :) = conv(G_sig_c, input(i, :, 3), 'same')...
                - conv(G_sig_s, input(i, :, 1)-input(i, :, 2), 'same'); 
        end
    case char('ha')
        for i = 1:100
            output(i, :) = conv(G_sig_c, input(i, :, 1), 'same')...
                - conv(G_sig_s, input(i, :, 1)+input(i, :, 2)-input(i, :, 3), 'same'); 
        end
    case char('hb')
        for i = 1:100
            output(i, :) = conv(G_sig_c, input(i, :, 2), 'same')...
                - conv(G_sig_s, input(i, :, 1)+input(i, :, 2)-input(i, :, 3), 'same'); 
        end
    case char('hc')
        for i = 1:100
            output(i, :) = conv(G_sig_c, input(i, :, 3), 'same')...
                - conv(G_sig_s, input(i, :, 1)+input(i, :, 2)-input(i, :, 3), 'same'); 
        end
end
