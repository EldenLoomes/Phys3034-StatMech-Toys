function occ = MC_FD(E,mu,T,samples) 
% returns a Monte-Carlo sample of the FD distribution at temperature T, 
% with `samples' samples via rejection sampling

if (samples == -1)
    occ = 1/(exp((E-mu)/T)+1);
    return
end 

n_FD = 1/(exp((E-mu)/T)+1); % How do I put mu in???

successes = 0;
for s = 1:samples
    if (rand() < n_FD)
        successes = successes + 1;
    end
end
occ = successes/samples;
return