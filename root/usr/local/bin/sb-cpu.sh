#!/bin/sh

cpu="$(awk '{print $1}' < /proc/loadavg)%"

echo "[ $cpu]"