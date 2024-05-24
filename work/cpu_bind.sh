#!/bin/bash

get_cpu_core() {
    local pid=$1
    taskset -p $pid | grep -oP ':\s+\K.*'
}

pid=$$
echo "Rank $SLURM_PROCID is running on CPU core(s):"
get_cpu_core $pid

hostname=$(hostname)
echo "The hostname of this node is: $hostname"
