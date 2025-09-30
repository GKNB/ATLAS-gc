# Setup Globus Compute Endpoint

## 1. Prepare virtual environment

Virtual environment (`conda` or `venv`) is used to keep packages, necessary 
for Harvester and Globus Compute, isolated from other setups. There is no 
requirements on using `conda` specifically, so we will use `venv`.

```shell
/global/common/software/nersc/pe/conda-envs/24.1.0/python-3.11/nersc-python/bin/python -m venv ve_gc
source ve_gc/bin/activate
# confirm that the environment is active:
#    which python
#    python -V
```

`conda` setup will be as following:
```shell
module load python
conda create -y -n ve_gc python=3.11
conda activate ve_gc
```

Keep the environment variable `PYTHONNOUSERSITE` set, it prevents Python from 
adding the user's site-packages directory (typically located in 
`~/.local/lib/pythonX.Y/site-packages`) to `sys.path`, so it ensures that the
Python environment only uses packages installed within that specific 
environment, preventing conflicts with globally installed packages or packages 
installed in the user's home directory.
```shell
export PYTHONNOUSERSITE=True
```

### 1.1. Install Globus Compute packages

[Globus-Compute](https://globus-compute.readthedocs.io/en/latest/index.html)
packages:
```shell
pip install globus-compute-endpoint
pip install globus-compute-sdk
```

## 2. Create Globus Compute endpoint

> [!WARNING]
> The GC endpoint will be created in the home directory and currently 
> this setting can not be changed.

```shell
export GCE_NAME=mep_v001
globus-compute-endpoint configure --multi-user $GCE_NAME
# copy `gce_configs/*` files into the newly created GCE directory
cp gce_configs/* ~/.globus_compute/$GCE_NAME/
globus-compute-endpoint start $GCE_NAME
# it will request "Please authenticate with Globus here: <URL>", so please
# follow that URL, which will generate the Authorization Code, and which you
# would need to enter back in the terminal where you started the endpoint.
```

After starting the GC endpoint (and authenticating), the current terminal need
to be kept for a running endpoint instance. There will be a message such as:
`>>> Multi-User Endpoint ID: f91add6c-b994-4eff-ac8e-bb97ac3f3aa7 <<<`.
This is the endpoint ID, which could be also found in:
- `globus-compute-endpoint list`
- `cat ~/.globus_compute/$GCE_NAME/endpoint.json`

Keep this terminal open, or run the start command in the background, 
when the process stops, Multi-User Endpoint (MEP) terminates.

## 3. Test Globus Compute endpoint

Open another terminal, and test earlier created GC endpoint with the provided 
script.

### 3.1. Local test

Local test assumes to make a submission of the test script from Perlmutter 
itself. Here are the steps to conduct this test:
```shell
# get endpoint ID
export GCE_NAME=mep_v001
export GCE_ID=$(jq -r '.endpoint_id' ~/.globus_compute/$GCE_NAME/endpoint.json)
# run test(s)
source ve_gc/bin/activate
python gce_examples/test_mep_rpc.py --endpoint_id $GCE_ID
python gce_examples/test_mep_compute.py --endpoint_id $GCE_ID
```

`squeue --me` will show running batch jobs. You can also use 
`gce_examples/get_task_status.py` to look into the status using `task_id` from 
the output of `test_mep_compute.py`.

### 3.2. Remote test

Remote test assumes to make a submission of the test script outside of 
Perlmutter. Here are the steps to conduct this test:

- Copy the test files from Perlmutter to remote machine;
- Repeat section 1 to set up the environment;
- Repeat section 3.1. to run tests.

