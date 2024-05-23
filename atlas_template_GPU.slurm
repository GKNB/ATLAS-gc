#!/bin/sh
#SBATCH -A m2845_g
#SBATCH -C gpu
#SBATCH -q regular
#SBATCH -t 0:10:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=4
#SBATCH -c 32
#SBATCH --gpus-per-task=1
#SBATCH --module=gpu

nNode=2

export PANDA_QUEUE=NERSC_Perlmutter_GPU
export HARVESTER_DIR=/global/homes/t/tianle/myWork/aid2e/globus_compute/test/test_ALTAS_toy/
export HARVESTER_NNODE=${nNode}
export HARVESTER_NTASKS=$((4 * ${nNode}))
export HARVESTER_MAPTYPE=ManyToOne

export wrapper_wrapper_file=$HARVESTER_DIR/wrapper-wrapper-3_GPU.sh

echo [$SECONDS] "Copy $wrapper_wrapper_file into $HARVESTER_ACCESS_POINT"
cp -v $wrapper_wrapper_file $HARVESTER_DIR/wrapper-wrapper-3.sh

srun /bin/bash ./wrapper-wrapper-3.sh $PANDA_QUEUE 
