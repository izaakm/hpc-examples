#!/bin/bash
##SBATCH -J myjob	       	## Name of job, you can define it to be any word
#SBATCH -A isaac-sta0005	##Information about the project account to be charged
#SBATCH --nodes=1              	## Number of nodes
#SBATCH --ntasks-per-node=1    	##-ntasks is used when we want to define total number of processors
#SBATCH --time=01:00:00
#SBATCH --partition=ai-tenn    	## Partition to use AI resources
#SBATCH -o myjob.o%j           	## output of the run will be written here
#SBATCH --qos=ai-tenn		## QOS associated with AI resources
#SBATCH --gpus=1

###########   Perform some simple commands   ########################
set -x

###########   NVIDIA GPU status ##########
nvidia-smi

###########   What is the hostname   ###############
hostname

###########   How much memory is on this host   ###############
free -h

###########   Show all the filesystems   ###############
df -h -x tmpfs

