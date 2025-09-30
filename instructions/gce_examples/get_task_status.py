import argparse
import sys
import time

from globus_compute_sdk import Client

MAX_RETRY = 5


def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-t', '--tasks', nargs='+', type=str,
                        help='List of task IDs')
    return parser.parse_args()


def print_result(task_id, batch_result):
    print("task_id = ", task_id)
    print("pending = ", batch_result['pending'])
    print("status = ", batch_result['status'])
    print("result.cmd = \n", batch_result['result'].cmd)
    print("result.stdout = \n", batch_result['result'].stdout)
    print("result.stderr = \n", batch_result['result'].stderr)
    print("result.returncode = ", batch_result['result'].returncode)
    print("completion_t = ", batch_result['completion_t'])


def main():
    args = get_args()

    task_id_list = []
    for task_id in args.tasks:
        task_id_list.extend(task_id.split(','))

    if not task_id_list:
        print("Missing task IDs")
        sys.exit(1)

    gcc = Client()
    res = gcc.get_batch_result(task_id_list)
    pending = False

    for retry in range(MAX_RETRY):
        print(f"Retry {retry}")
        for task_id in task_id_list:
            if res[task_id]['pending']:
                pending = True
                break
        if not pending:
            break
        time.sleep(10)

    if not pending:
        for task_id, res in res.items():
            print_result(task_id, res)
    else:
        print("Some tasks are pending. Rerun this script")


if __name__ == "__main__":
    main()

