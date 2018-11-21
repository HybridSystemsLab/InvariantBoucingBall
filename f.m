function xdot = f(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file       
% Project: controlled FI Journal example, constrained bouncing ball
%
% Name: f.m
%
% Description: Flow map
%
% Required files: - 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global gamma

% states
%     x1 = x(1);
    x2 = x(2);
%     wd = x(3);
%     q = x(4);
  

% flow map
    x1dot = x2;
    x2dot = - gamma;

xdot = [x1dot; x2dot; 0; 0];
end