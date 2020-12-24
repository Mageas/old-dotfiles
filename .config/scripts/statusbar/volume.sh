#!/bin/sh

muted=$(pamixer --sink 0 --get-mute)

if [ "$muted" = true ]; then
    return="ﱝ muted"
else
    volume=$(pamixer --sink 0 --get-volume)

    if [ "$volume" -gt 49 ]; then
        return=" $volume%"
    else
        return="墳 $volume%"
    fi
fi

echo "[$return]"