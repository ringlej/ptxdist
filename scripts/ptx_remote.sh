#!/bin/bash

host_ip=${1}
target_ip=${2}
target_port=${3}
prog=${4}
shift
shift
shift
shift
args=${*}

rsh -l service ${target_ip} gdbserver ${host_ip}:${target_port} ${prog} ${args}
