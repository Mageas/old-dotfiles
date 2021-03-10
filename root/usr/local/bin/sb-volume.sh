#!/bin/sh

volume=$(pamixer --get-volume)
mute=$(pamixer --get-mute)

if [ "$mute" = true ]; then
    return="ﱝ muted"
else
    [[ "$volume" -gt 49 ]] && return=" $volume%" || return="墳 $volume%"
fi

echo "[$return]"