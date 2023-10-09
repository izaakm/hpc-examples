#!/bin/bash
#SBATCH --ntasks=32
#SBATCH --ntasks-per-node=32
#SBATCH -o example.log.%J
#SBATCH -e example.err.%J
#SBATCH -J example

#set the partition, use compute if running in Swansea
#SBATCH -p htc
#SBATCH --time=1:00:00
#SBATCH --exclusive

# https://portal.supercomputing.wales/index.php/index/slurm/interactive-use-job-arrays/batch-submission-of-serial-jobs-for-parallel-execution/

time my_exec < input1.csv > input1.log.$SLURM_JOBID &
time my_exec < input2.csv > input2.log.$SLURM_JOBID &

# You must `wait` to make sure the batch job won't exit before all the simultaneous runs are completed.

wait
