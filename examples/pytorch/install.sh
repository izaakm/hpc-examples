#!/usr/bin/env bash

set -e

nvidia-smi --list-gpus

source /usr/share/Modules/init/bash
module load anaconda3/2023.09
source $ANACONDA3_SH

conda create --prefix $SCRATCHDIR/.conda/envs/pytorch --yes
conda activate pytorch

# https://pytorch.org/get-started/locally/
conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia --yes

# Set up for use w/ Jupyter notebook
conda install ipykernel --yes
python -m ipykernel install --user --name "pytorch" --display-name "Python (PyTorch)"


exit 0
