function [occupancy,mu] = QuadFermi(T,N)
    % This function samples a FD distribution under a quadratic
    % density of states. 
   
    % At each level it computes the distribution, either exactly or 
    % with MC rejection sampling (to produce a randomly sampled distribution), 
    % and finds the chemical potential by counting the number of particles
    % in the sampled distribution and iteratively correcting mu to keep it
    % constant with the specified N.

    % The function returns the occupancy array and mu

    %% The main tuning parameters are:
    max_relaxation_steps = 1000; % The max number of steps taken to relax mu to an appropriate value.
    mu_step_size = 0.01;         % How much mu is updated each step
    N_tolerance = 0.01;          % The tolerated error from the true N
    samples = -1;               % The number of MC rejection samples 
    % set to -1 to get the exact distribution.
    
    %% The energy range and density of states is defined:
    Emax = 30;
    Es = 0:0.01:Emax;

    DoS_norm = 1;
    g = @(E) DoS_norm.*sqrt(E);
    
    % To switch to a band-gap system, replace the square root with `thermalDoS(E,4.24,6);`
    % The constants are tunned for N=30 to simulate a semiconductor,
    % with electrons leaking into the conduction band at T > 0.


    %% Cleaning up my space and setting pretty things:
    set(0,'defaultTextInterpreter','latex'); % Making things pretty
    set(groot,'defaultAxesTickLabelInterpreter','latex');
       
    %% We now define a histogram of occupations, binned into wider bins:
    bin_width = 0.2;
    EsBinned = 0:bin_width:Emax;
    TotBins = length(EsBinned);
    
    occupancy = zeros(1,TotBins); % THIS is the main occupancy histogram
    
    %% To find the correct mu, we produce a random distribution, compute N 
    % numerically and perturb mu until we approach sufficiently close to 
    % the desired value
    
    mu = 2; % Initialise it at some reasonable value
    
    for step = 0:max_relaxation_steps
        % We choose an occupancy with rejection sampling;
        for i = 1:TotBins
            % We want to generate a number around the expected occupation n_FD. We do so
            % either ideally (for samples = -1) or by rejection sampling `samples' times and averaging.
            occupancy(i) = MC_FD(EsBinned(i),mu,T,samples)*g(EsBinned(i));
        end

        % We now count the number of particles in all the states
        N_current = sum(occupancy);
        if (abs(N_current-N) < N_tolerance) % If it is within tolerance, break out and use the current distribution
            disp("Mu relaxation broke out at step " + step)
            break
        end
        % Otherwise, correct mu to make them match closer
        % Making mu bigger makes this sum bigger, so we step appropriately
        if (N_current > N)
            mu = mu - mu_step_size;
        else
            mu = mu + mu_step_size;
        end
    end
    
    disp("The number error was: " +(N_current-N))
    disp("Final mu was "+mu)
    
    %% Finally plotting:
    
    % these plots are in natural units k_B = 1, so the x-axes are in some
    % arbitrary units of energy, and the y-axis in arbitrary unit of E^(-1)

    % I intentionally do not refresh the figure, to allow overplotting by
    % simply running the function repeatedly
    % e.g. see `animate_heating.m`

    shg % Show current figure
    hold on

    plot(Es,g(Es), "b-",'linewidth',1.3)
    bar(EsBinned,occupancy,1,'FaceAlpha',0.2,'linewidth',0.5,'EdgeAlpha',1,'EdgeColor','black');
    mu_shifted = mu-bin_width/2; % We plot it back half a bin width to align with the plotting of the bars
    plot([mu_shifted,mu_shifted],[0,2],"k--",'linewidth',1.5)
    
    xlabel("Energy $\epsilon$",'FontSize',13)
    ylabel("Occupancy $n(\epsilon)$",'FontSize',13)
    xticks([mu_shifted]);
    xticklabels({"$\mu$"});
    
    yticks([])
    xlim([0,10])
return