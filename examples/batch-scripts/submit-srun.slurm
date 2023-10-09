#!/bin/bash
#SBATCH -JSlurmParallelSrunExample                  # Job name
#SBATCH --account=gts-gburdell3                 # charge or tracking account
#SBATCH -N1 --ntasks-per-node=24                # Number of nodes and cores per node required
#SBATCH --mem-per-cpu=7G                        # Memory per core
#SBATCH -t1:00:00                               # Duration of the job (Ex: 1 hour)
#SBATCH -qinferno                               # QOS Name (on Hive, use -p<partition> instead)
#SBATCH -oReport-%j.out                         # Combined output and error messages file
#SBATCH --mail-type=BEGIN,END,FAIL              # Mail preferences
#SBATCH --mail-user=gburdell3@gatech.edu        # E-mail address for notifications

# https://docs.pace.gatech.edu/slurm-software/parallel-srun/

srun --quiet -n12 -c1 --mem=84G ./executable1 &
srun --quiet -n12 -c1 --mem=84G ./executable2 &
srun --quiet -n12 -c1 --mem=84G ./executable3 &
srun --quiet -n12 -c1 --mem=84G ./executable4 &
srun --quiet -n12 -c1 --mem=84G ./executable5 &
srun --quiet -n12 -c1 --mem=84G ./executable6 &
wait
