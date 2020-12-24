#!/bin/sh

cpu="$(awk '{print $1}' < /proc/loadavg | cut -c 3-)%"

echo "[ $cpu]"