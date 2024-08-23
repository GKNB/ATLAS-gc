#!/bin/bash

echo "PANDA_HOME = $PANDA_HOME"
srun -n 8 --ntasks-per-node=4 --cpus-per-task=64 /bin/bash /global/homes/t/tianle/myWork/aid2e/globus_compute/test/test_ALTAS_toy/wrapper-test.sh
