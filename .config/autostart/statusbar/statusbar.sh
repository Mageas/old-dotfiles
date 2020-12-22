#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# LAUNCH INIT SCRIPTS
updates=$($SCRIPTPATH/scripts/updates.sh)
kernel=$($SCRIPTPATH/scripts/kernel.sh)

# LOOP
while true; do
    timestamp=$(date +%s)
    sleep 0.9s # 0.9 because 0.1 delay in network

    # UPDATE TIME
    if (( $timestamp % 300 == 0 )); then
        updates=$($SCRIPTPATH/scripts/updates.sh)
    fi

    # ALWAYS UPDATE
    network=$($SCRIPTPATH/scripts/network.sh)
    cpuload=$($SCRIPTPATH/scripts/cpuload.sh)
    memory=$($SCRIPTPATH/scripts/memory.sh)
    date=$($SCRIPTPATH/scripts/date.sh)
    pulseaudio=$($SCRIPTPATH/scripts/pulseaudio.sh)

    # OUTPUT
    xsetroot -name "[ $kernel] [ $cpuload] [ $memory] [$network] [ $updates updates] [ $date] [$pulseaudio]"
done