#!/bin/bash
memory="$(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
echo -e "$memory"