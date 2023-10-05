#!/bin/bash
##SBATCH -J myjob               ## Name of job, you can define it to be any word
#SBATCH -A isaac-sta0005        ##Information about the project account to be charged
#SBATCH --nodes=1               ## Number of nodes
#SBATCH --ntasks-per-node=1     ##-ntasks is used when we want to define total number of processors
#SBATCH --time=01:00:00
#SBATCH --partition=ai-tenn     ## Partition to use AI resources
#SBATCH -o myjob.o%j            ## output of the run will be written here
#SBATCH --qos=ai-tenn           ## QOS associated with AI resources
#SBATCH --gpus=1

# > the set of three things that need to all be in place is the ai-tenn
# partition needs to allow the ai-tenn qos, the ai-tenn qos needs to be set up
# and the project that is used needs to be allowed to specify that qos.  The
# commands to check are:
#
#  $ scontrol show partition ai-tenn
#  $ sacctmgr show qos ai-tenn
#  $ sacctmgr show assoc format=cluster%-8,account%-15,user,partition,share,qos%150,defaultqos | grep isaac-sta0005

###########   NVIDIA GPU status ##########
nvidia-smi

###########   What is the hostname   ###############
hostname

###########   How much memory is on this host   ###############
free -h

###########   Show all the filesystems   ###############
df -h -x tmpfx

exit 0
