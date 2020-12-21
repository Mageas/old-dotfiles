#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# LAUNCH INIT SCRIPTS
kernel=$($SCRIPTPATH/scripts/kernel.sh)
cpuload=$($SCRIPTPATH/scripts/cpuload.sh)
memory=$($SCRIPTPATH/scripts/memory.sh)
network=$($SCRIPTPATH/scripts/network.sh)
updates=$($SCRIPTPATH/scripts/updates.sh)
date=$($SCRIPTPATH/scripts/date.sh)
pulseaudio=$($SCRIPTPATH/scripts/pulseaudio.sh)

# LOOP
while true; do
    timestamp=$(date +%s)
    sleep 0.1s # 0.9 because 0.1 delay in network

    # UPDATE TIME
    if (( $timestamp % 1 == 0 )); then
        cpuload=$($SCRIPTPATH/scripts/cpuload.sh)
    fi

    if (( $timestamp % 1 == 0 )); then
        memory=$($SCRIPTPATH/scripts/memory.sh)
    fi

    if (( $timestamp % 1 == 0 )); then
        network=$($SCRIPTPATH/scripts/network.sh)
    fi

    if (( $timestamp % 300 == 0 )); then
        updates=$($SCRIPTPATH/scripts/updates.sh)
    fi

    if (( $timestamp % 1 == 0 )); then
        date=$($SCRIPTPATH/scripts/date.sh)
    fi

    pulseaudio=$($SCRIPTPATH/scripts/pulseaudio.sh)

    # OUTPUT
    xsetroot -name "[ $kernel] [ $cpuload] [ $memory] [$network] [ $updates updates] [ $date] [$pulseaudio]"
done