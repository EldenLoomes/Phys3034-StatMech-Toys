%% Let's animate the plot on heating

set(0,'defaultTextInterpreter','latex'); % Making things pretty
set(groot,'defaultAxesTickLabelInterpreter','latex');


N = 30;

Ts = 0:0.05:6;
current_text = text(4.5,3,"$T = 0$",'interpreter','latex','FontSize',13);
for T = Ts
    alpha(0.01)
    set(findobj(gca, 'Type', 'Line', 'Linestyle', '--'), 'LineWidth', 0.1,'LineStyle','none');
    QuadFermi(T,N);
    delete(current_text);
    current_text = text(4.5,3,"$T ="+T+"$",'interpreter','latex','FontSize',13);
    pause(0.2)
    if (mod(T,1) == 0) % Pause more for every 20 steps
        pause(1.5)
    end
end 