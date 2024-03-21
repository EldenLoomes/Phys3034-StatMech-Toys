This function samples a FD distribution under a density of states. 
==================================================================
Code written by Elden Loomes, 2024, for USyd Phys3034
------------------------------------------------------------------

`QuadFermi.m` is the main function. Run with
`QuadFermi(temperature,particle_number);`
All the plots are at an arbitrary scale. I find `particle_number=30` works well. Remember the semicolon, otherwise the function prints the occupancy array and the chemical potential `mu` to the command line. 

The output of `QuadFermi(T,N)` is a pair:
`[occupancy, mu] = QuadFermi(T,N);`
which can be used (say) to plot the variation of $\mu$ at different $T$.
