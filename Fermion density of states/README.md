Fermion density of states
==================================================================
This program samples a Fermi-Dirac distribution under a density of states, for a particular particle number $N$ and temperature $T$, varying the chemical potential $\mu$ to find an appropriate value matching $N$. This nicely reproduces the Sommerfeld expansion.

**All of these plots use arbitrary units, intended to give the qualitative effect without worrying about specific values. In particular, $k_\mathrm{B}=1$.**

#### `QuadFermi.m` 
...is the main function. Run with `QuadFermi(T,N);`

![Example occupation under density of states](https://github.com/EldenLoomes/Phys3034-StatMech-Toys/blob/main/Fermion%20density%20of%20states/Exported%20Pictures/ExactOneTemp.png)

All the plots are at an arbitrary scale. I find `particle_number=30` works well. Remember the semicolon, otherwise the function prints the occupancy array and the chemical potential `mu` to the command line. By default, the function does not produce a new figure window, to facilitate overplotting. If you want separate plots, you should run:
```
figure();
QuadFermi(T,N);
```

The return of `QuadFermi(T,N)` is a pair:
`[occupancy, mu] = QuadFermi(T,N);`
which can be used (say) to plot the variation of $\mu$ at different $T$, as in functions below.

By default, `QuadFermi(T,N)` plots with a $g(E)\propto \sqrt{E}$ density of states. Changing the line:
```
g = @(E) DoS_norm.*sqrt(E);
```
to
```
g = @(E) DoS_norm.*thermalDoS(E, A, B);
```
gives a nice model of a system with a band gap from $E=A$ to $E=B$. The values $A=4.24$, $B=6$ are tuned to simulate a semiconductor with $N=30$.

![Semiconductor occupation distribution](https://github.com/EldenLoomes/Phys3034-StatMech-Toys/blob/main/Fermion%20density%20of%20states/Exported%20Pictures/DoSBands1K.png)

The final option is to Monte-Carlo sample the distributions (for fun). If `samples=-1` is replaced with a positive value, the Fermi-Dirac distribution in `MC_FD.m` will instead return a distribution produced by rejection sampling the distribution `samples` times. I haven't implemented this particularly carefully, so I don't expect this to produce particularly _physically_ distributed variation. Either way, significant deviation is in contradiction with the thermodynamic limit, so take with a grain of salt...

Other scripts include:

#### `animate_heating.m`
...animates a plot of the distribution across a range of temperatures. Pauses every 20 steps

#### `mu_variation.m`
...performs a similar animation, but at each step records and plots the chemical potential. This demonstrates the Sommerfeld expansion for $\mu$ very nicely:
$$\displaystyle\frac{\mu}{\epsilon_\mathrm{F}}=1-\frac{\pi^2}{12}\left(\frac{kT}{\epsilon_\mathrm{F}}\right)^{2}+\cdots$$
![Chemical potential Sommerfeld expansion](https://github.com/EldenLoomes/Phys3034-StatMech-Toys/blob/main/Fermion%20density%20of%20states/Exported%20Pictures/Chemical%20potential%20exact.png)

#### `ideal_distribution.m`
...plots a smooth occupation for a given $T$ and $\mu$.
![Ideal distribution](https://github.com/EldenLoomes/Phys3034-StatMech-Toys/blob/main/Fermion%20density%20of%20states/Exported%20Pictures/IdealOccupation.png)

#### `MC_FD.m`
...is a function `MC_FD(T,mu,E, samples)` returning either an exact Fermi-Dirac distribution, or a Monte-Carlo sample thereof (as discussed above). `samples=-1` produces the exact distribution.

#### `thermalDoS.m`
...is a function, `thermalDoS(E,A,B)`, computes a density of states function with a decreasing square-root function to zero at $E=A$, then rising again at $E=B$. See the second plot above.
