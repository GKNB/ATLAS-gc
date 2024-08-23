#!/bin/bash

PANDA_QUEUE=$1
HARVESTER_ACCESS_POINT=$2

# create unique Harvester workdirectory for each pilot
HARVESTER_WORKDIR=$HARVESTER_ACCESS_POINT/${SLURM_JOBID}/${SLURM_PROCID}
echo  [$SECONDS] "create new working directory (if needed) - "$HARVESTER_WORKDIR
if [ ! -e $HARVESTER_WORKDIR ] ; then mkdir -pv $HARVESTER_WORKDIR ; fi
cd $HARVESTER_WORKDIR
echo  [$SECONDS] "Now in working directory - "${PWD}
echo

export pilot_tar_file=$HARVESTER_DIR/etc/panda/pilot3-3.7.7.3.tar.gz

# Credentials
export X509_USER_PROXY=$HARVESTER_DIR/globus/lincolnb/harvester-vomsproxy

# Unset TMP
unset TMPDIR

echo
echo [$SECONDS] "Harvester Top level directory - "$HARVESTER_DIR
echo [$SECONDS] "Harvester accessPoint - "$HARVESTER_ACCESS_POINT
echo [$SECONDS] "Harvester Worker ID - "$HARVESTER_WORKER_ID
echo [$SECONDS] "Harvester workflow (MAPTYPE) - "$HARVESTER_MAPTYPE
echo [$SECONDS] "Harvester accessPoint - "$HARVESTER_ACCESS_POINT
echo [$SECONDS] "Harvester workdir for this job - "$HARVESTER_WORKDIR
echo [$SECONDS] "Pilot tar file - "$pilot_tar_file
echo [$SECONDS] "Container IMAGE_BASE - "$IMAGE_BASE
echo [$SECONDS] "command to setup release in container - "$HARVESTER_CONTAINER_RELEASE_SETUP_FILE
echo [$SECONDS] "Number of Nodes to use - "$HARVESTER_NNODE
echo [$SECONDS] "Number of tasks for srun - "$HARVESTER_NTASKS
echo [$SECONDS] "ATHENA_PROC_NUMBER - "$ATHENA_PROC_NUMBER
echo [$SECONDS] "TMPDIR - $TMPDIR"
echo [$SECONDS] "Current directory - "$PWD
echo [$SECONDS] "Current hostname - "$(hostname -s)

echo [$SECONDS] copy $pilot_tar_file to $HARVESTER_WORKDIR
cp -v $pilot_tar_file $HARVESTER_WORKDIR/pilot3.tar.gz

tar -xzf $HARVESTER_WORKDIR/pilot3.tar.gz

# Setup FRONTIER
export FRONTIER_SERVER="(serverurl=http://atlasfrontier-ai.cern.ch:8000/atlr)(serverurl=http://atlasfrontier2-ai.cern.ch:8000/atlr)(serverurl=http://atlasfrontier1-ai.cern.ch:8000/atlr)(proxyurl=http://frontiercache.nersc.gov:3128)"

# setup emi environment for arcprocy commanded needed by the pilot -
if [ -z $ATLAS_LOCAL_ROOT_BASE ]; then
  export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
fi
source $ATLAS_LOCAL_ROOT_BASE/user/atlasLocalSetup.sh
# and the menu options will then be available

#DPBenv | sort
#DPBecho

export PATH=$PATH:/global/common/software/m2616/bin

# create container environmental file
if [ -e myEnv.sh ] ; then rm -v myEnv.sh ; fi
cat <<EOF >>myEnv.sh
#!/bin/sh
# Created on $(date # : <<-- this will be evaluated before cat;)
export PATH=\$PATH:/global/common/software/m2616/bin
EOF
echo lsetup \"python pilot-default-SL9\" >> myEnv.sh
echo "lsetup rucio xrootd davix psutil logstash" >> myEnv.sh

echo "Container enviromental setup file - "

cat myEnv.sh
echo

# create exection file
if [ -e myPayload.sh ] ; then /bin/rm -v myPayload.sh ; fi
cat <<EOF2 >>myPayload.sh
#!/bin/sh
# Created on $(date # : <<-- this will be evaluated before cat;)
EOF2

echo "python3 pilot3/pilot.py -q "$PANDA_QUEUE" -i PR -j managed -w generic --url https://pandaserver.cern.ch --pilot-user ATLAS --resource-type MCORE --allow-same-user=False --getjobrequests=10 --cleanup False  --debug" >> myPayload.sh

echo "Container Payload file - "
cat myPayload.sh
echo


# attempt to run the pilot directly from this wrapper script using a container run by ALRV
export ALRB_CONT_RUNPAYLOAD="source /srv/myPayload.sh"

echo [$SECONDS] " executing command - "
echo export ALRB_CONT_RUNPAYLOAD=\"source /srv/myPayload.sh\"
echo setupATLAS -v -v  -c el9 -s \"/srv/myEnv.sh\" -m /global -m /pscratch 
setupATLAS -v -v -c el9 -s "/srv/myEnv.sh" -m /global -m /pscratch 

