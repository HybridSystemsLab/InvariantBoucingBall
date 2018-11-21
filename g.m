function xplus = g(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file       
% Project: controlled FI Journal example, constrained bouncing ball
%
% Name: g.m
%
% Description: Jump map
%
% Required files: - 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global hmax vmin vmax vbreak e1 e2 ep control

% states
    x1 = x(1);
    x2 = x(2);
    wd = x(3);
    q = x(4);

% jump map
  if x1 <= 0 && x2 <= 0 && x2 >= - vmax
      % input value from controller kd (1) and rd (0)
    if control == 1
        ud = x2 + vmax;
    elseif control == 2
        ud = vmin/vmax * x2 + vmin;
    else
        ud = max((vmin + e1 * x2), 0);
    end
    x1plus = - x1; % reverse sign for num err
    x2plus = - wd * x2 + ud;
    wdplus= e1 +rand*(e2 - e1);
    qplus = 0;
  elseif x1 >= hmax && x2 >= 0 && x2 <= vbreak && q == 0
      x1plus = x1; % for num err
      x2plus = - ep * x2;
      wdplus = wd;
      qplus = 1;
  else 
      x2plus = x2;
  end

xplus = [x1plus; x2plus; wdplus; qplus];
end