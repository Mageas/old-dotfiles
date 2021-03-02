#!/bin/bash

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
        printf "\n./$file --> /$file\n"
        sudo cp -i "./$file" "/$file"
    fi
done