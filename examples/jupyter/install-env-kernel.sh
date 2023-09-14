# Load the standard anaconda/python installation on ISAAC-NG
module unload PE-intel
module load anaconda3
source $ANACONDA3_SH

# Activate the base environment
conda activate

# Create the new environment with the name "myenv" and install "python" and the "ipykernel" package
conda create -n myenv python ipykernel

# When the installation is complete, activate the environment
conda activate myenv

# Make the environment available to Jupyter
python -m ipykernel install --user --name myenv --display-name "Python (myenv)"

# Verify the installation worked; check that "myenv" is listed
jupyter kernelspec list

# Now launch a Jupyter session from Open OnDemand and this environment/kernel should be available
# Open OnDemand: http://login.isaac.tennessee.edu/
# ---
# For more information about installing kernels with ipykernel:
# https://ipython.readthedocs.io/en/stable/install/kernel_install.html
# ---
# END
