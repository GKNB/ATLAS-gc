#!/bin/bash

echo "PANDA_HOME = $PANDA_HOME"
#ls /cvmfs
module list
srun --label -n 2 --ntasks-per-node=2 --cpus-per-task=128 /usr/bin/shifter ls /cvmfs
#srun shifter -n 8 --ntasks-per-node=4 --cpus-per-task=64 /bin/bash /global/homes/t/tianle/myWork/aid2e/globus_compute/test/test_ALTAS_toy/wrapper-test.sh
