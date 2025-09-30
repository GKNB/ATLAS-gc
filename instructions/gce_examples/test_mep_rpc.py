
import argparse
import os

from globus_compute_sdk import Executor, Client
from globus_compute_sdk.sdk.shell_function import ShellFunction


local_endpoint_config = {
    "endpoint_type": "local",
    "max_workers_per_node": 4,
}


def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--endpoint_id", required=True)
    return parser.parse_args()


def main():

    current_dir = os.path.dirname(os.path.abspath(__file__))

    filename_list = [
        f"{current_dir}/file1.txt",  # doesn't exist, should return 1
        f"{current_dir}/test_rpc_file2.txt",  # no line match, should return 2
        f"{current_dir}/test_rpc_file3.txt"   # match, return 0 and
                                              # stdout should be slurm ID
    ]

    args = get_args()

    print("Start testing fetching slurm_job_id\n\n")
    local_cmd = r"""
#!/usr/bin/env bash

if [ ! -e "{filename}" ]; then
  exit 1
fi

if ! line=$(grep -m1 -xE 'SLURM_JOB_ID=[0-9]+' "{filename}"); then
  exit 2
fi

printf '%s' "${{line#SLURM_JOB_ID=}}"

exit 0
"""
    bf = ShellFunction(local_cmd)
    with Executor(endpoint_id=args.endpoint_id,
                  user_endpoint_config=local_endpoint_config) as gce:
        for i, filename in enumerate(filename_list):
            print(f"Doing idx {i} with filename {filename}")
            future = gce.submit(bf, filename=filename)
            sr = future.result()
            print(f"stdout: {sr.stdout}")
            print(sr.stdout == "" or sr.stdout == "38677774")
            print(f"stderr: {sr.stderr}")
            print(sr.stderr == "")
            print(f"returncode: {sr.returncode}")
            print(sr.returncode == 0 or sr.returncode == 1 or sr.returncode == 2)
            print(f"exception_name: {sr.exception_name}")
            print(sr.exception_name == "subprocess.CalledProcessError" or
                  sr.exception_name is None)

    print("Start testing sacct command\n\n")
    local_cmd = r"sacct --job={slurm_job_id}"
    bf = ShellFunction(local_cmd)
    with Executor(endpoint_id=args.endpoint_id,
                  user_endpoint_config=local_endpoint_config) as gce:
        future = gce.submit(bf, slurm_job_id="38677774")
        sr = future.result()
        print(f"stdout: {sr.stdout}")
        print(f"stderr: {sr.stderr}")
        print(f"returncode: {sr.returncode}")
        print(f"exception_name: {sr.exception_name}")


if __name__ == "__main__":
    main()

