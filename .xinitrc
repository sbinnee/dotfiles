[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# get rid of white noise from headphones when playing
# credit: https://askubuntu.com/questions/1095069/white-noise-from-headphones-in-ubuntu-18-04-1-on-dell-xps-13-9370
# amixer -c PHC cset 'name=Headphone Mic Boost Volume' 1

# turn off bluetooth
# it does not ask password if USER=seongbin
# see visudo file
# sudo bluetooth off
# LET'S USE TLP

chbg
# chbg && \
ibus-daemon -drx --panel /usr/lib/ibus/ibus-ui-gtk3 &&
# nm-applet &
# tput smkx &
# fcitx -dr
xset r rate 330 40 &
dunst &
picom &
unclutter &
exec i3
# blocks &
# exec dwm
