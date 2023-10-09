#!/bin/bash
#SBATCH --job-name example-array
#SBATCH --account ISAAC-STA0005
#SBATCH --partition campus
#SBATCH --qos campus
#SBATCH --nodes 1
#SBATCH --ntasks-per-node=1       # ntasks is used when we want to define total number of processors
#SBATCH --time 00:10:00
#SBATCH --array 1-9               # Submit array of jobs numbered 1 to 9
#SBATCH --output slurm-%A-%a.out  # For job arrays, the default file name is "slurm-%A_%a.out", "%A" is replaced by the job ID and "%a" with the array index.

# Example

echo "The job ID is the same for all jobs."
echo "SLURM_ARRAY_JOB_ID $SLURM_ARRAY_JOB_ID"         # Job array's master job ID number.
echo "The task ID is unique for each task in the array."
echo "SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_ID"       # Job array ID (index) number.

echo "Other variables related to the array parameters are the same for all array tasks."
echo "SLURM_ARRAY_TASK_COUNT $SLURM_ARRAY_TASK_COUNT" # Total number of tasks in a job array.
echo "SLURM_ARRAY_TASK_MAX $SLURM_ARRAY_TASK_MAX"     # Job array's maximum ID (index) number.
echo "SLURM_ARRAY_TASK_MIN $SLURM_ARRAY_TASK_MIN"     # Job array's minimum ID (index) number.
echo "SLURM_ARRAY_TASK_STEP $SLURM_ARRAY_TASK_STEP"   # Job array's index step size.

exit 0
