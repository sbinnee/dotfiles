[ -f "$HOME/.Xresources" ] && xrdb -merge -I$HOME $HOME/.Xresources

## Wallpaper
chbg &
## Keyboard input
xset s off &
xset -dpms &
xset r rate 330 40 &
nm-applet &
dunst &
#picom &
$HOME/Downloads/arch/picom/build/src/picom --experimental-backends --config $HOME/Downloads/arch/picom/picom.conf &
#mpd && mpd-mpris &
ibus-daemon -drx --panel /usr/lib/ibus/ibus-ui-gtk3 &
unclutter &
xsetroot -cursor_name left_ptr
set_opacity &

## Window Manager
exec bspwm
# exec i3
# blocks &
# exec dwm
