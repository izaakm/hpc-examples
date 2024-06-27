#!/usr/bin/env bash

set -e

nvidia-smi --list-gpus

source /usr/share/Modules/init/bash
module load anaconda3/2023.09
source $ANACONDA3_SH

conda create --prefix $SCRATCHDIR/.conda/envs/tensorflow-conda tensorflow-gpu cudatoolkit cudnn --yes
conda activate tensorflow-conda

python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

exit 0
