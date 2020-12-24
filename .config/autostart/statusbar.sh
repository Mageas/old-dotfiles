#!/bin/bash

while [ -z $(pidof dwm) ]; do
    sleep 0.5s
done

dwmblocks
