Load Julia

```
module purge
module load julia
```

Activate julia

```
$ julia
> 
```

Install IJulia kernel for Jupyter

```
> using Pkg
> Pkg.add("IJulia")
```

Install JWAS

```
> Pkg.add("JWAS")
```

https://julialang.github.io/IJulia.jl/stable/manual/installation/
https://github.com/reworkhow/JWAS.jl

<!-- END -->
