#!/usr/bin/env bash

# Screen
xrandr --newmode "1920x1080" 173.00 1920 2048 2248 2576 1080 1083 1088 1120 -hsync +vsync &&
xrandr --addmode Virtual-1 "1920x1080" &&
xrandr --output Virtual-1 --mode 1920x1080

# Compositor
picom &

# Clipboard
copyq &

# Dunst
/usr/bin/dunst &

# Wallpaper
feh --bg-fill /home/$USER/.config/wallpaper/wallpaper.jpg &

# Status bar
dwmblocks &

# Applications
firefox &