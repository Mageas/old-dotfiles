#!/bin/sh
#           1m   5m   15m
awk '{print $1" "$2" "$3}' < /proc/loadavg