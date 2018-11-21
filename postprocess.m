%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file       
% Project: controlled FI Journal example, constrained bouncing ball
%
% Name: postprocess.m
%
% Description: run file, disturbances are picked randomly
%
% Required files: run_bb.m C.m D.m f.m g.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% make sure to run run_bb.m first

%% data for control band boundaries
Bv = @(Br, Bp) sqrt(2*(Br - gamma * Bp));
  % inner boundary
  Bri = hmin * gamma;
  Bpi = linspace(0, hmin, 1e2);
  Bvi1 = Bv(Bri, Bpi);
  Bvi2 = - Bv(Bri, Bpi);
  Bvi = [Bvi1; Bvi2];
  
  % outer boundary
  Bro = Emax;
  Bpo = linspace(0, hmax, 1e3);
  Bvo1 = Bv(Bro, Bpo);
  Bvo2 = - Bv(Bro, Bpo);
  Bvo = [Bvo1; Bvo2];
  % to plot the extra max level sets
  Bpo_extra = linspace(hmax, Bro/gamma, 1e2);
  Bvo_extra1 = Bv(Bro, Bpo_extra);
  Bvo_extra2 = -Bv(Bro, Bpo_extra);

  Bvo_extra = [Bvo_extra1; Bvo_extra2];
 
%% plot hybris arcs of x1 and x2
modificatorF{1} = 'b-';
modificatorJ{1} = 'LineStyle';
modificatorJ{2} = 'none';
modificatorJ{3} = 'marker';
modificatorJ{4} = '*';
modificatorJ{5} = 'MarkerEdgeColor';
modificatorJ{6} = 'r';

figure(1) % position
clf
subplot(3,1,1), plotarc(t,j,x(:,1),[],[],...
    modificatorF,modificatorJ,[]);hold on
plot([0;max(t)],[hmin,hmin],'--','color',[0 0.5 0],'LineWidth',2); hold on
plot([0;max(t)],[hmax,hmax],'--','color',[0 0.5 0],'LineWidth',2);
plot(0, x10,'m+','LineWidth',5); hold on
grid on
axis([0, max(t), -0.1*hmax, 1.1*hmax])
xticks([]);
% xticks([0 10 20 30 40 50]);
yticks([0 6 12]);
set(gca,'fontsize', 20);
set(gca,'LooseInset',get(gca,'TightInset'))
% ylabel('x1','FontSize',15,'rot',0)
% set(gca,'LooseInset',get(gca,'TightInset'))

subplot(3,1,2), plotarc(t,j,x(:,2),[],[],modificatorF,modificatorJ,[]);
grid on
axis([0, max(t), -1.1*vmax, 1.1*vmax])
xticks([]);
% xticks([0 10 20 30 40 50]);
yticks([-25 -15 0 15 25]);
set(gca,'fontsize', 20);
% ylabel('x2','FontSize',15,'rot',0)
% xlabel('time','FontSize',15)
set(gcf,'color','w');
% set(gca,'LooseInset',get(gca,'TightInset'))

subplot(3,1,3), plotarc(t,j,x(:,2),[],[],modificatorF,modificatorJ,[]);
plot(t, x(:,3),'LineWidth',3); hold on
plot([0;max(t)],[e1,e1],'c--','LineWidth',2); hold on
plot([0;max(t)],[e2,e2],'c--','LineWidth',2);
grid on
axis([0, max(t), 0.78, 0.92])
xticks([0 5 10 15 20]);
yticks([0.8 0.9]);
set(gca,'fontsize', 20);
set(gcf,'color','w');
% set(gca,'LooseInset',get(gca,'TightInset'))

%% plot on x1 vs x2 plane
axis_val = [-0.05*hmax, 1.05*hmax, -1.05*vmax, 1.05*vmax];
% axis_val = [-0.05*hmax, 1.05*Emax/gamma, -1.05*vmax, 1.05*vmax];

figure(2) 
% plot boundaries for set K
% plot jump dash line,stupid trick...
% 
%% data for slicing x into I^Js
slice = []; % the array stores the x before each jump
in = 1; % index of slice
for i = 2: max(size(x))
    if (x(i-1,2)*x(i,2)) < - vmin^2 % if x jumps (x2 varies sign on x1 axis)
        slice(in) = i-1;
        in = in+1;
    end
end

clear i
k = 1;
n = 1;
IJ = {}; % the cell array stores all x data as each I^J
for i = 1: max(size(slice))
    IJ{1,n} = x(k:slice(i),1); % position stores at odd columns
    IJ{1,n+1} = x(k:slice(i),2); % velocity stores at even columns
    if i ~= max(size(slice))
        k = slice(i)+1;
        n = n + 2;
    end
end
clear i k 
i = 1;
while i <= n
    p = IJ{1,i}; % extract position values
    Bv = IJ{1,i+1}; % extract velcity values
    if i ~=1
       plot(p(1),Bv(1),'r*'); hold on
    end
    plot(p(end),Bv(end),'r*'); hold on
    plot(p,Bv,'b'); hold on
    i = i + 2;
    clear p v
end
plot(Bpo,Bvo,'-.','color',[0 0.5 0],'LineWidth',2); hold on
plot(Bpi,Bvi,'-.','color',[0 0.5 0],'LineWidth',2); hold on
plot([0;0],[vmin; vmax],'-.','color',[0 0.5 0],'LineWidth',2); hold on
plot([0;0],[-vmax; -vmin],'-.','color',[0 0.5 0],'LineWidth',2); hold on
plot([hmax;hmax],[-vbreak; vbreak],...
    '-.','color',[0 0.5 0],'LineWidth',2); hold on
% extra energy lines
plot(Bpo_extra,Bvo_extra,'g.','LineWidth',2); hold on

plot(x10, x20,'m+','LineWidth',5); hold on
% plot([0;0], [max(x(:,2)), min(x(:,2))],'k--','LineWidth',2); hold on
grid on
axis(axis_val);
xticks([0 6 12]);
yticks([-25 -15 0 15 25]);
set(gca,'fontsize', 20);
set(gcf,'color','w');
set(gca,'LooseInset',get(gca,'TightInset'))
% ylabel('x2','FontSize',15,'rot',0)
% xlabel('x1','FontSize',15)
hold off

figure(3)
plot(t, x(:,3),'LineWidth',3); hold on
plot([0;max(t)],[e1,e1],'c--','LineWidth',2); hold on
plot([0;max(t)],[e2,e2],'c--','LineWidth',2);
grid on
axis([0, max(t), 0.78, 0.92])
xticks([0 10 20 30 40 50]);
yticks([0.8 0.85 0.9]);
set(gca,'fontsize', 20);
set(gcf,'color','w');
set(gca,'LooseInset',get(gca,'TightInset'))