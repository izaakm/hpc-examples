# Installing tensorflow in a conda environment

Get an interactive session on a GPU node.

```sh
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

```sh
module load anaconda3
source $ANACONDA_SH
```

## Conda

Create a conda environment and install tensorflow:

```sh
conda create --name tf tensorflow
conda activate tf
```


> [!NOTE]
> [TensorFlow GPU with conda is only available though version 2.4.1
> (2021).][conda-tensorflow]


> [!NOTE]
> [Install tensorflow from conda-forge.][conda-forge-tensorflow]


## Pip

Create a conda environment:

```sh
conda create --name tf python pip
conda activate tf
```

```sh
# For GPU users
pip install tensorflow[and-cuda]
```

```sh
# For CPU users
pip install tensorflow
```

```sh
conda create --prefix $SCRATCHDIR/.conda/envs/tf tensorflow
#                                                ^ The packages to install.
#                     ^ The directory where the packages will be installed.
```

# Verify installation

```sh
# For CPU users
python3 -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"
```

```sh
# For GPU users
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
```

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

<!--<https://docs.anaconda.com/free/working-with-conda/applications/tensorflow/>-->

[conda-tensorflow]: <https://www.anaconda.com/docs/tools/working-with-conda/applications/tensorflow>
[conda-forge-tensorflow]: https://anaconda.org/conda-forge/tensorflow
[pip-tensorflow]: <https://www.tensorflow.org/install/pip>
[pypi-tensorflow]: <https://pypi.org/project/tensorflow/>
[pypi-tensorflow-gpu]: <https://pypi.org/project/tensorflow-gpu/>
[ref1]: <https://discuss.tensorflow.org/t/tensorflow-2-13-0-does-not-find-gpu-with-cuda-12-1/18939/13>
[ref2]: <https://github.com/tensorflow/tensorflow/issues/62075>


<!-- END -->
