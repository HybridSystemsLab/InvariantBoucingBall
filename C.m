function value = C(x) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file       
% Project: controlled FI Journal example, constrained bouncing ball
%
% Name: C.m
%
% Description: Flow set
%
% Required files: - 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global gamma Emax

% states
    x1 = x(1);
    x2 = x(2);
%     wd = x(3);
%     q = x(4);
  
% energy function
    E = gamma*x1 + x2^2/2;
  
% flow set
    if (x1 >= 0 && E <= Emax) % x1 <= hmax removed for num err
        value = 1;
    else
        value = 0;
    end
end