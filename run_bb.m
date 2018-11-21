%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file       
% Project: controlled FI Journal example, constrained bouncing ball
%
% Name: run_bb.m
%
% Description: run file, disturbances are picked randomly
%
% Required files: C.m D.m f.m g.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc
close all

%% useful constants
global gamma hmin hmax vbreak Emax e1 e2 ep vmax vmin control
% need gamma*hmax \leq (1+e1-e2)^2/2 * Emax
gamma = 9.81; % gravity constant in SI
hmin = 10; % min height for ball to reach after each impact
hmax = 12; % max height for ball to reach after each impact, hmax > hmin
vbreak = 6*sqrt(9.81); % max velocity to break the string when pulling
Emax = gamma*hmax + vbreak^2/2; % max energy (this) = 2*gamma*hmax
e1 = 0.8; % lower bound of the coefficient of restitution
e2 = 0.9; % uppper bound of the coefficient of restitution
ep = 0.95; % coefficient of restitution when pulling
eps = 0.1; % thin margin for 
vmin = sqrt(2*gamma*(hmin + eps/2)); % minimun "safe" velocity
vmax = sqrt(2*Emax); % maximun "safe" velocity

%% controller specs and initial conditions
control = 0; % parameter to indicate selected controller
% 0 : rd = vmin + e1*x2
% 1 : kd = x2 + vmax
% 2 : kd = vmin/vmax * x2 + vmin

x10 = hmin+rand*(hmax-hmin); % within the height range hl~hh
x20 = 0; % initial velocity need to be zero: drop the ball from a height...
wd0 = e1 +rand*(e2-e1); % randomly generated cofficient of restitution
q0 = 0;
x0 = [x10; x20; wd0; q0];

%% simulation horizon
TSPAN=[0 20]; % simulation time upto t = 50 sec
JSPAN = [0 200]; % simulation jumps upto j = 100

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

%solver tolerances
options = odeset('RelTol',1e-3,'MaxStep',1e-2); % simulaiton step size 1e-2

%% simulate
[t j x] = HyEQsolver( @f,@g,@C,@D,x0,TSPAN,JSPAN,rule,options);

%% plots
postprocess