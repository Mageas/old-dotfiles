#!/bin/bash
date="$(date +"%b %d %Y | %H:%M"| sed 's/  / /g')"
echo -e "$date"