%% Let's see how mu varies with T in our computation

set(0,'defaultTextInterpreter','latex'); % Making things pretty
set(groot,'defaultAxesTickLabelInterpreter','latex');


N = 30;
Tmax = 7;

Ts = 0:Tmax; % Bonus Qn: what happens when I make T > 8 ? Why?
mus = [];

figure();
set(gcf, 'Position',  [100, 100, 1000, 400]);

for T = Ts
    subplot(1,2,1)
    alpha(0.01)
    [occ, mu] = QuadFermi(T,N);
    mus = [mus, mu];

    mus_Eps = mus./mus(1); % Normalise by first element

    subplot(1,2,2)
    hold on
    scatter(0:T,mus_Eps,60,'rx')
    plot(Ts,zeros(1,length(Ts)),'k-')
    xlabel("Temperature $T$ [arb.~units]", "FontSize",13)
    ylabel("Chemical potential $\mu/\epsilon_\mathrm{F}$", "FontSize",13)
    ylim([-2,1.5])
    xlim([0,Tmax])
    pause(2)
end
