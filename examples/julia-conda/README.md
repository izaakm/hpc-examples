Setup conda module on the cluster

```
module purge
module load anaconda3
source $ANACONDA_SH
conda activate
```

Install julia from conda

```
conda create -n julia -c conda-forge julia
```
