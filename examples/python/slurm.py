#!/usr/bin/env python3
#SBATCH --job-name=python-test
#SBATCH --account=ACF-UTK0011
#SBATCH --partition=short
#SBATCH --qos=short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00


import os
import sys

print(os.environ)

sys.exit(0)
