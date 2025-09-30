
import argparse

from globus_compute_sdk import Executor, Client
from globus_compute_sdk.sdk.shell_function import ShellFunction


worker_init_extra = ('export GC_TASK_SANDBOX_DIR=/global/cfs/cdirs/m2845/'
                     'globus_compute/logs/')
compute_endpoint_config = {
    "endpoint_type": "slurm",
    "account": "m2845",
    "partition": "regular",
    "parallelism": 2.0,
    "walltime": "00:20:00",
    "nodes_per_block": 2,
    "worker_init_extra": worker_init_extra,
    "max_blocks": 2,
}


def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--endpoint_id", required=True)
    return parser.parse_args()


def main():

    compute_cmd = r"""
echo "-------------------Start-------------------"
date
sleep 30
srun -n 4 hostname
date
echo "-------------------End-------------------"
"""

    bf = ShellFunction(compute_cmd)

    gcc = Client()
    func_id = gcc.register_function(bf)
    print("func_id = ", func_id)

    batch = gcc.create_batch(user_endpoint_config=compute_endpoint_config)
    for i in range(4):
        batch.add(function_id=func_id)

    args = get_args()
    batch_res = gcc.batch_run(batch=batch, endpoint_id=args.endpoint_id)
    print("Batch_res = ", batch_res)

    task_id_list = []
    for func_id, each_task_list in batch_res['tasks'].items():
        task_id_list.extend(each_task_list)
    print("task_id_list = ", task_id_list)


if __name__ == "__main__":
    main()

