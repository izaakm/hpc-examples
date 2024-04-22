#!/bin/bash

#SBATCH --job-name=gromacstest
#SBATCH --account=ISAAC-STA0005
##SBATCH --account=ACF-UTK0011

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=00-12:00:00

#SBATCH --partition=campus-gpu-large

##SBATCH --qos=campus
#SBATCH --qos=staff
#SBATCH --error=error.e%j
#SBATCH --output=output.o%j


############## Load any modules #########
cd ${SLURM_SUBMIT_DIR}
echo ${SLURM_SUBMIT_DIR}
module unload PE-intel
module load gromacs/2021.5-gcc

#############run program########
srun gmx_mpi mdrun -v -deffnm em

