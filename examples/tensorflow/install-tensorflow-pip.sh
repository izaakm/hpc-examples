#!/usr/bin/env bash

set -e

nvidia-smi --list-gpus

source /usr/share/Modules/init/bash
module load anaconda3/2023.09
source $ANACONDA3_SH

conda create --prefix $SCRATCHDIR/.conda/envs/tensorflow-pip python=3.9 --yes
conda activate $SCRATCHDIR/.conda/envs/tensorflow-pip

conda install -c conda-forge cudatoolkit=11.8 --yes
pip install nvidia-cudnn-cu11
pip install tensorflow

python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

exit 0
