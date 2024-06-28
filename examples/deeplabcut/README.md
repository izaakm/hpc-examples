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
conda create --prefix $SCRATCHDIR/.conda/envs/DEEPLABCUT deeplabcut ipykernel ipywidgets --yes

# Activate the environment:
conda activate DEEPLABCUT

# Set up the environment so that you can use it from a Jupyter Notebook:
python -m ipykernel install --user --name DEEPLABCUT --display-name "Python (DEEPLABCUT)"
```

Testing in Jupyter Notebook/Lab
===============================

Go to [Open OnDemand] and request a Jupyter Notebook from "Interactive Apps".

Wait for your interactive session to start, and then click on the "Connect to
Jupyter" button.

Create a new notebook.

Select the kernel "Python (DEEPLABCUT)".

Test that you can import the `deeplabcut` library:

```ipynb
import deeplabcut
```

```output
2024-06-28 09:32:01.710019: I tensorflow/core/platform/cpu_feature_guard.cc:193] This TensorFlow binary is optimized with oneAPI Deep Neural Network Library (oneDNN) to use the following CPU instructions in performance-critical operations:  SSE4.1 SSE4.2 AVX AVX2 AVX512F AVX512_VNNI FMA
To enable them in other operations, rebuild TensorFlow with the appropriate compiler flags.
2024-06-28 09:32:03.369105: I tensorflow/core/util/port.cc:104] oneDNN custom operations are on. You may see slightly different numerical results due to floating-point round-off errors from different computation orders. To turn them off, set the environment variable `TF_ENABLE_ONEDNN_OPTS=0`.
```

```ipynb
import tensorflow as tf
print(tf.config.list_physical_devices('GPU'))
```

```output
[PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]
```

Official DeepLabCut docs: https://github.com/DeepLabCut/DeepLabCut


[Open OnDemand]: http://login.isaac.tennessee.edu/

<!-- END -->
