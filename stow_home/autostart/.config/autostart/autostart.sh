#!/usr/bin/env bash

# Screen - CVT
xrandr --output DP-4 --mode "1920x1080" --rate 160 --output DP-1 --mode "1280x1024" --rate 60 --left-of DP-4

# Compositor
picom &

# Screen saver
xset s off -dpms

# Status bar
dwmblocks &

# Dunst
/usr/bin/dunst &

# Wallpaper
feh --bg-fill /home/$USER/.config/wallpaper/wallpaper.jpg &

# Redshift
redshift &

# Sxhkd
sxhkd &

# Applications
firefox &
discord &
