close all
set(0,'defaultTextInterpreter','latex'); % Making things pretty
set(groot,'defaultAxesTickLabelInterpreter','latex');

T = 4;
mu = 4;

Emax = 10;
Es = 0:0.01:Emax;

g = @(E) sqrt(E);
n_FD = @(E) 1./(exp((E-mu)./T)+1);

hold on
area(Es,g(Es).*n_FD(Es),'FaceAlpha',0.2,'DisplayName',"$g(\epsilon)\overline{n}_{FD}(\epsilon)$")
plot(Es, g(Es),"b-",'LineWidth',1.3,'DisplayName',"Density of states $g(E)$")
plot(Es, n_FD(Es),"g-",'LineWidth',1.3,'DisplayName',"FD distribution $\overline{n}_{FD}(E)$")
legend('Interpreter','latex','fontsize',13,'location','northwest');
xlabel("Energy $E$",'FontSize',14)
text(4.1,1.1,"$T =$ "+T+", $\mu=$ "+mu,'Interpreter','latex','fontsize',13)