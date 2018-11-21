function inside = D(x) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file       
% Project: controlled FI Journal example, constrained bouncing ball
%
% Name: D.m
%
% Description: Jump set
%
% Required files: - 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global hmax vmax vbreak

% states
    x1 = x(1);
    x2 = x(2);
%     wd = x(3);
    q = x(4);
  
  
% jump set
    if (x1 <= 0 && x2 <= 0 && x2 >= - vmax)
        inside = 1;
    elseif (x1 >= hmax && x2 >= 0 && x2 <= vbreak && q == 0)
        inside = 1;
    else
        inside = 0;
    end
end