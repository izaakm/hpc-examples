#!/bin/bash
##SBATCH -J myjob	       ## Name of job, you can define it to be any word
#SBATCH -A ACF-UTK0011	       ##Information about the project account to be charged
#SBATCH --nodes=1              ## Number of nodes
#SBATCH --ntasks-per-node=1    ##-ntasks is used when we want to define total number of processors
#SBATCH --time=25:00:00
#SBATCH --partition=long-gpu   ## Select the long-gpu partition
#SBATCH -e myjob.o%j	       ## Errors will be written in this file. Making standard error and standard out go to same file
#SBATCH -o myjob.o%j           ## output of the run will be written her. Making standard error and standard out go to same file
#SBATCH --qos=long-gpu
#SBATCH --gpus=1

###########   Perform some simple commands   ########################
set -x

###########   What is the hostname   ###############
hostname

###########   How much memory is on this host   ###############
free -h

###########   Show all the filesystems   ###############
df -h -x tmpfx

###########   Change to lustre scratch directory   ###############
cd /lustre/isaac/scratch/$USER
ls -l

###########   Detailed information of a job with jobid   ###############
scontrol show jobid $SLURM_JOBID
#echo $SLURM_NTASKS
###########   Check the detailed information about partitions   ###############
sinfo -Nel

###########   Environmental variables   ###############
env
env | grep SLURM

###########   NVIDIA GPU status
nvidia-smi


