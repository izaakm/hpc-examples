
# Conda

https://docs.anaconda.com/free/working-with-conda/applications/tensorflow/

# Pip

https://www.tensorflow.org/install/pip
https://discuss.tensorflow.org/t/tensorflow-2-13-0-does-not-find-gpu-with-cuda-12-1/18939/13
https://pypi.org/project/tensorflow/
https://github.com/tensorflow/tensorflow/issues/62075
https://pypi.org/project/tensorflow-gpu/

Get an interactive session on a compute node.

```
salloc \
    --account=ACF-UTK0011 \
    --nodes=1 \
    --ntasks=8 \
    --partition=campus-gpu \
    --qos=campus \
    --time=01:00:00 \
    --gpus=1
ssh <your compute node>
```

Load the anaconda module.

```
module load anaconda3
source $ANACONDA_SH
```

Create a conda environment and install tensorflow:

<!-- {{{
********************************************
TENSORFLOW-GPU IS NOT RECOMMENDED SINCE 2.12
********************************************
```
conda create -n tensorflow python tensorflow-gpu
conda activate tensorflow
```

Install tensorflow.

```
conda search tensorflow-gpu
# or
pip install tensorflow-gpu[and-cuda]
```
}}} -->

```sh
conda create --prefex $SCRATCHDIR/.conda/envs/tf tensorflow
#                     ^                          ^ The packages to install.
#                     ^ The directory where the packages will be installed.
```

<!-- END -->
