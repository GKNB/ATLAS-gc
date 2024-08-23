#!/bin/bash

export PANDA_HOME=/global/common/software/m2616/harvester-perlmutter
echo "PANDA_HOME = $PANDA_HOME"

export PANDA_QUEUE=NERSC_Perlmutter_Globus_Test
export HARVESTER_DIR=$PANDA_HOME  # PANDA_HOME is defined in etc/sysconfig/panda_harvester
export HARVESTER_WORKER_ID=36362
export HARVESTER_ID="NERSC_perlmutter_test"
export HARVESTER_ACCESS_POINT=/pscratch/sd/t/tianle/harvester/workdir/panda/NERSC_Perlmutter_Globus_Test/36362
#export HARVESTER_ACCESS_POINT=/pscratch/sd/u/usatlas/harvester/workdir/panda/NERSC_Perlmutter_Globus_Test/36362
export HARVESTER_TASKS_PER_NODE=4 # Should be equal to: (nJobsPerWorker * nCorePerNode) / nCore
export HARVESTER_NNODE=2
export HARVESTER_NTASKS=$((HARVESTER_TASKS_PER_NODE * 2))
export HARVESTER_MAPTYPE=NoJob

# Careful, bash can only do integer math.
export ATHENA_PROC_NUMBER_JOB=$((256 / (HARVESTER_TASKS_PER_NODE)))
export ATHENA_PROC_NUMBER=$((256 / (HARVESTER_TASKS_PER_NODE)))
export ATHENA_CORE_NUMBER=$((256 / (HARVESTER_TASKS_PER_NODE)))

export wrapper_wrapper_file=$HARVESTER_DIR/etc/panda/globus_wrapper.sh

echo [$SECONDS] "Create dir of $HARVESTER_ACCESS_POINT"
mkdir -p $HARVESTER_ACCESS_POINT

echo [$SECONDS] "Copy $wrapper_wrapper_file into $HARVESTER_ACCESS_POINT"
cp -v $wrapper_wrapper_file $HARVESTER_ACCESS_POINT/globus_wrapper.sh

srun --label -n $HARVESTER_NTASKS /bin/bash ./globus_wrapper.sh $PANDA_QUEUE $HARVESTER_ACCESS_POINT

chown -R :m2616 $HARVESTER_ACCESS_POINT
