#!/bin/bash
date="$(date +"%a, %B %d %l:%M:%S%p"| sed 's/  / /g')"
echo -e "$date"