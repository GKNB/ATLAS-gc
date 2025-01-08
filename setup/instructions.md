# Environment setup on Perlmutter@NERSC

Prepare virtual environment
```shell
module load python
conda create -y -n hep.ve python=3.10
conda activate hep.ve
```

## Globus Compute

Prepare [Globus-Compute](https://globus-compute.readthedocs.io/en/latest/index.html)
(GC) packages
```shell
python3 -m pip install globus-compute-sdk
python3 -m pip install globus-compute-endpoint
```

Configure GC endpoint
```shell
globus-compute-endpoint configure hep_perlmutter
# update configuration file "~/.globus_compute/hep_perlmutter/config.yaml"
# according to the example from this repo
globus-compute-endpoint start hep_perlmutter
# it will request "Please authenticate with Globus here: <URL>", so please
# follow that URL, which will generate the Authorization Code, and which you
# would need to enter back in the terminal where you started the endpoint.
```

Confirm that the endpoint is `Running`
```shell
globus-compute-endpoint list
```

## Create personal VOMS proxy (optional)

```shell
export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
source $ATLAS_LOCAL_ROOT_BASE/user/atlasLocalSetup.sh
# EMI: grid middleware user interface
lsetup emi
```

```shell
# "~/.globus" should contain "usercert.pem" and "userkey.pem"
voms-proxy-init --voms atlas:/atlas/usatlas/Role=production --out ~/.globus/gridproxy.pem
voms-proxy-info --file ~/.globus/gridproxy.pem 
```

