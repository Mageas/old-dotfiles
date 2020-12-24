#!/bin/bash

pacupdates=$(checkupdates | wc -l)

if [ $pacupdates == 1 ]; then
    sufix="update"
else
    sufix="updates"
fi

echo "[ $pacupdates $sufix]"