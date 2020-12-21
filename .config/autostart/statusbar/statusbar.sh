#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# LAUNCH UPDATE SCRIPTS
kernel=$($SCRIPTPATH/scripts/kernel.sh)
cpuload=$($SCRIPTPATH/scripts/cpuload.sh)
memory=$($SCRIPTPATH/scripts/memory.sh)
network=$($SCRIPTPATH/scripts/network.sh)
updates=$($SCRIPTPATH/scripts/updates.sh)
time=$($SCRIPTPATH/scripts/time.sh)

# LOOP
while true; do
    timestamp=$(date +%s)
    sleep 1s

    # UPDATE TIME
    if (( $timestamp % 2 == 0 )); then
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
        time=$($SCRIPTPATH/scripts/time.sh)
    fi

    # OUTPUT
    xsetroot -name "$kernel | $memory | $cpuload | $updates | $network | $time"
done