[ -f "$HOME/.Xresources" ] && xrdb -merge -I$HOME $HOME/.Xresources
# ([ -f "$HOME/.config/.Xmodmap" ] && sleep 2 && xmodmap $HOME/.config/.Xmodmap) &

# get rid of white noise from headphones when playing
# credit: https://askubuntu.com/questions/1095069/white-noise-from-headphones-in-ubuntu-18-04-1-on-dell-xps-13-9370
# amixer -c PHC cset 'name=Headphone Mic Boost Volume' 1

# turn off bluetooth
# it does not ask password if USER=seongbin
# see visudo file
# sudo bluetooth off
# LET'S USE TLP

# Background setup
chbg &
# Disable DPMS
xset s off &
xset -dpms &
xset r rate 330 40 &
nm-applet &
dunst &
picom &
mpd && mpd-mpris &
ibus-daemon -drx --panel /usr/lib/ibus/ibus-ui-gtk3 &
unclutter &
xsetroot -cursor_name left_ptr
# tput smkx &
# fcitx -dr
# transmission-daemon
# pkill -3 transmission-da
## Window Manager
exec bspwm
# exec i3
# blocks &
# exec dwm
