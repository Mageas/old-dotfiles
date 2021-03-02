#!/bin/bash

# Make sure only root can run this script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Set workdir
cd "$(dirname "$0")"

# List all files
files=$(find . -type f)

# String to array
delimiter="./"
conCatString=$files$delimiter
splitMultiChar=()
while [[ $conCatString ]]; do
    splitMultiChar+=( "${conCatString%%"$delimiter"*}" )
    conCatString=${conCatString#*"$delimiter"}
done

# Foreach file
for file in "${splitMultiChar[@]}"; do
    file=$(echo $file|tr -d '\n')
    if [[ "$file" != "" && "$file" != "install_root.sh" ]]; then
        echo "./$file --> /$file"
        sudo cp -i "./$file" "/$file"
    fi
done