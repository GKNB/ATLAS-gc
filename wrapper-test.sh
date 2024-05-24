#!/bin/bash

PANDA_JOB_ID=$SLURM_PROCID
touch /global/homes/t/tianle/myWork/aid2e/globus_compute/test/test_ALTAS_toy/work/$PANDA_JOB_ID 
cp -v /global/homes/t/tianle/myWork/aid2e/globus_compute/test/test_ALTAS_toy/work/$PANDA_JOB_ID /tmp/
echo [$SECONDS] "PANDA JOB ID - "$PANDA_JOB_ID

cd /global/homes/t/tianle/myWork/aid2e/globus_compute/test/test_ALTAS_toy/work/ 
#/bin/bash cpu_bind.sh 
check-mpi.gnu.pm
