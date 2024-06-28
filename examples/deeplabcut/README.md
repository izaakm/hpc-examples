% Install DeepLabCut


Enable GPU (optional)
=====================

The recommended way to install DeepLabCut is to enable GPU use, but this is not
required.

To get a GPU node, run, eg:

```bash
srun \
--account AFC-UTK0011 \
--partition campus-gpu-large \
--qos campus-gpu \
--gpus 1 \
--ntasks 1 \
--cpus-per-task 1 \
--time 1:00:00 \
--pty /bin/bash
```

And then wait until your compute resources are allocated (ie, you are returned
to the command prompt).

Once your compute resources are ready, verify that you have a GPU available by
running the following command:

```bash
nvidia-smi --list-gpus
```

If you see something like the following:

```output
GPU 0: Tesla V100S-PCIE-32GB (UUID: GPU-fee6d64c-029a-39b3-be19-1600230b82f7)
```

then you should be good to go. If, on the other hand, you see something like
this:

```output
No devices found.
```

then you do not have a GPU available, and the installation will only be
capable of using the CPUs, which will cause DeepLabCut to run much more slowly.


Install DeepLabCut with conda
=============================

Run the following commands to set up a conda environment with DeepLabCut
installed.

```bash
# Load the anaconda module:
module load anaconda3/2023.09

# Set up Conda by 'sourcing' the set up script:
source $ANACONDA3_SH

# Create the conda environment with DeepLabCut:
conda create --prefix $SCRATCHDIR/.conda/envs/deeplabcut deeplabcut ipykernel --yes

# Activate the environment:
conda activate DEEPLABCUT

# Set up the environment so that you can use it from a Jupyter Notebook:
python -m ipykernel install --user --name DEEPLABCUT --display-name "Python (DEEPLABCUT)"
```


Official DeepLabCut docs: https://github.com/DeepLabCut/DeepLabCut

<!-- END -->
