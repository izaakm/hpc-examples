#!/usr/bin/env bash
#SBATCH --account AFC-UTK0011
#SBATCH --partition campus-gpu-large
#SBATCH --qos campus-gpu
#SBATCH --gpus 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --time 1:00:00

set -e

nvidia-smi --list-gpus

source /usr/share/Modules/init/bash
module load anaconda3/2023.09
source $ANACONDA3_SH

conda create --prefix $SCRATCHDIR/.conda/envs/DEEPLABCUT deeplabcut ipykernel --yes
conda activate DEEPLABCUT

python -m ipykernel install --user --name DEEPLABCUT --display-name "Python (DEEPLABCUT)"

python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

exit 0
