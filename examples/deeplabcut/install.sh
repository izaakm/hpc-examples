#!/usr/bin/env bash
#SBATCH --account acf-utk0011
#SBATCH --partition campus-gpu-large
#SBATCH --qos campus-gpu
#SBATCH --gpus 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --time 1:00:00

set -e

readonly env_name="${1:-deeplabcut}"

echo "[$(date)] Setting up conda env with name \"${env_name}\""

nvidia-smi --list-gpus

source /usr/share/Modules/init/bash
module load anaconda3/2023.09
source $ANACONDA3_SH

conda create --prefix "$SCRATCHDIR/.conda/envs/${env_name}" deeplabcut ipykernel ipywidgets --yes
conda activate "$SCRATCHDIR/.conda/envs/${env_name}"

python -m ipykernel install --user --name "${env_name}" --display-name "Python (${env_name})"

python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

echo "[$(date)] Set up complete."

exit 0
