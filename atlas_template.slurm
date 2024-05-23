#!/bin/sh
#SBATCH -A m2616
#SBATCH -C cpu
#SBATCH --qos=regular
#SBATCH --time 20:00:00 # only 2 guaranteed w/ preempt
#SBATCH --module=cvmfs
##SBATCH -L SCRATCH,project
#SBATCH -N {nNode}

export PANDA_QUEUE=NERSC_Perlmutter
export HARVESTER_DIR=$PANDA_HOME  # PANDA_HOME is defined in etc/sysconfig/panda_harvester
export HARVESTER_WORKER_ID={workerID}
export HARVESTER_ID="NERSC_perlmutter_test"
export HARVESTER_ACCESS_POINT={accessPoint}
export HARVESTER_TASKS_PER_NODE=16 # Should be equal to: (nJobsPerWorker * nCorePerNode) / nCore
export HARVESTER_NNODE={nNode}
export HARVESTER_NTASKS=$((HARVESTER_TASKS_PER_NODE * {nNode}))
export HARVESTER_MAPTYPE=ManyToOne

# Careful, bash can only do integer math.
export ATHENA_PROC_NUMBER_JOB=$((256 / (HARVESTER_TASKS_PER_NODE)))
export ATHENA_PROC_NUMBER=$((256 / (HARVESTER_TASKS_PER_NODE)))
export ATHENA_CORE_NUMBER=$((256 / (HARVESTER_TASKS_PER_NODE)))

export wrapper_wrapper_file=$HARVESTER_DIR/etc/panda/wrapper-wrapper-3.sh

echo [$SECONDS] "Copy $wrapper_wrapper_file into $HARVESTER_ACCESS_POINT"
cp -v $wrapper_wrapper_file $HARVESTER_ACCESS_POINT/wrapper-wrapper-3.sh

srun -n $HARVESTER_NTASKS /bin/bash ./wrapper-wrapper-3.sh $PANDA_QUEUE $HARVESTER_ACCESS_POINT

chown -R :m2616 $HARVESTER_ACCESS_POINT
