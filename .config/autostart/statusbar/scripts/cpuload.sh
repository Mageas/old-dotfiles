#!/bin/sh
#           1m   5m   15m
#awk '{print $1" "$2" "$3}' < /proc/loadavg
# echo -e "$(awk '{print $1}' < /proc/loadavg | cut -c 3-)%"
echo -e "$(awk '{print $1}' < /proc/loadavg | cut -c 3-)%"