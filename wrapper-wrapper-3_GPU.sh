#!/bin/bash

PANDA_QUEUE=$1

export my_HARVESTER_WORKDIR=$HARVESTER_DIR

echo
echo [$SECONDS] "Harvester Top level directory - "$HARVESTER_DIR
echo [$SECONDS] "Harvester my work directory - "$my_HARVESTER_WORKDIR
echo [$SECONDS] "Harvester workflow (MAPTYPE) - "$HARVESTER_MAPTYPE
echo [$SECONDS] "Number of Nodes to use - "$HARVESTER_NNODE
echo [$SECONDS] "Number of tasks for srun - "$HARVESTER_NTASKS

cd /global/homes/t/tianle/myWork/aid2e/globus_compute/test/test_ALTAS_toy/work 
./gpus_for_tasks
