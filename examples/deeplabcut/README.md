% Install DeepLabCut


```bash
# Load the anaconda module:
module load anaconda3/2023.09

# Set up Conda by 'sourcing' the set up script:
source $ANACONDA3_SH

# Create the conda environment with DeepLabCut:
conda create --prefix $SCRATCHDIR/.conda/envs/DEEPLABCUT deeplabcut ipykernel --yes

# Activate the environment:
conda activate DEEPLABCUT

# Set up the environment so that you can use it from a Jupyter Notebook:
python -m ipykernel install --user --name DEEPLABCUT --display-name "Python (DEEPLABCUT)"
```


https://github.com/DeepLabCut/DeepLabCut
