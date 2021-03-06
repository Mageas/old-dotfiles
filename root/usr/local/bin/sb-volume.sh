#!/bin/sh

volume=$(pamixer --get-volume)
mute=$(pamixer --get-mute)

if [ "$mute" = true ]; then
    return="ﱝ muted"
else
    if [ "$volume" -gt 49 ]; then
        return=" $volume%"
    else
        return="墳 $volume%"
    fi
fi

echo "[$return]"