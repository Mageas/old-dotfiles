# Screen - CVT
xrandr --output DP-0 --mode "2560x1440" --primary --rate 240 --output DP-4 --mode "1920x1080" --rate 165 --left-of DP-0

# Compositor
picom &

# Screen saver
xset s off -dpms

# Status bar
statusbar &

# Dunst
/usr/bin/dunst &

# Wallpaper
feh --bg-fill /home/$USER/.config/wallpaper/wallpaper.jpg &

# Redshift
redshift &

# Sxhkd
sxhkd &

# Doom
/usr/bin/emacs --daemon &

# Easy effects
#easyeffects --gapplication-service -l default &
easyeffects --gapplication-service &

# Applications
firefox &
discord &
revolt &
