#!/bin/sh
#SBATCH -A m2845
#SBATCH -C cpu
#SBATCH --qos=regular
#SBATCH --time 0:10:00
#SBATCH --module=PrgEnv-nvidia/8.3.3
#SBATCH -N 1

module list
srun -n 2 hostname
