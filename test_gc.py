from globus_compute_sdk import Executor

def submit_ATLAS_template():
    import subprocess
#    result = subprocess.run(['srun', '-n', '8', '--ntasks-per-node=4', '--cpus-per-task=64', 'check-mpi.gnu.pm'], capture_output=True, text=True)
#    result = subprocess.run(['srun', '-n', '8', '--ntasks-per-node=4', '--cpus-per-task=64', '/bin/bash', '/global/homes/t/tianle/myWork/aid2e/globus_compute/test/test_ALTAS_toy/wrapper-test.sh'], capture_output=True, text=True)
    result = subprocess.run(['/bin/bash', '/global/homes/t/tianle/myWork/aid2e/globus_compute/test/test_ALTAS_toy/atlas_srun_command.sh'], capture_output=True, text=True)
    return result.stdout, result.stderr

#def submit_ATLAS_bash_template():
#    import bash_function
#    f = MPIFunction('''
## Do app specific setup
#mv ~/inputs/* .
#
## This is my MPI script
#$PARSL_MPI_PREFIX lammps -in <input> -o <output>
#
## Here's my app teardown
#rm lammps.junk
#''')
##    result = subprocess.run(['srun', '-n', '8', '--ntasks-per-node=4', '--cpus-per-task=64', 'check-mpi.gnu.pm'], capture_output=True, text=True)
#    result = subprocess.run(['srun', '-n', '8', '--ntasks-per-node=4', '--cpus-per-task=64', '/bin/bash', '/global/homes/t/tianle/myWork/aid2e/globus_compute/test/test_ALTAS_toy/wrapper-test.sh'], capture_output=True, text=True)
#    return result.stdout, result.stderr




tutorial_endpoint_id = '733ef4d2-4e13-409d-9e30-c6955b4d209d'

# ... then create the executor, ...
with Executor(endpoint_id=tutorial_endpoint_id) as gce:
    # ... then submit for execution, ...
    future = gce.submit(submit_ATLAS_template)
    print("Job submitted!")
    # ... and finally, wait for the result
    print("Out: ", future.result()[0])
    print("Err: ", future.result()[1])
