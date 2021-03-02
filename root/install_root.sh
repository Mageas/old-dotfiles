#!/bin/bash

# Set workdir
cd "$(dirname "$0")"

# Argument
NO_CONFIRM=False
if [[ $1 == "--noconfirm" ]]; then
    NO_CONFIRM=True
fi

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
        if [[ $NO_CONFIRM == True ]]; then
            sudo cp "./$file" "/$file"
        else
            sudo cp -i "./$file" "/$file"
        fi
        
    fi
done