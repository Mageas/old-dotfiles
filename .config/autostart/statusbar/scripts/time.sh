#!/bin/bash
time="$(date +"%a, %B %d %l:%M:%S%p"| sed 's/  / /g')"
echo -e "$time"