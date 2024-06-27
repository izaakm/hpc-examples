#!/bin/bash
#SBATCH --job-name=hello
#SBATCH --account=ACF-UTK0011
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=short
#SBATCH --qos=short
#SBATCH --time=0-00:10:00
##SBATCH --chdir=/lustre/isaac/scratch/jmill165/
##SBATCH --output=jobs/job-%j-%x.o               # %j jobid ; %x jobname
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bioinformatics@utk.edu      # Requires an argument

module purge

pwd 

name="${1:-World}"

echo "Hello ${name}!"

exit 0
