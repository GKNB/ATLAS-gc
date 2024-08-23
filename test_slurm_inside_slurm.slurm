#!/bin/sh
#SBATCH -A m2845
#SBATCH -C cpu
#SBATCH --qos=regular
#SBATCH --time 0:10:00
#SBATCH --module=cvmfs
#SBATCH -N 1

hostname
module list
srun -n 1 insider.slurm
