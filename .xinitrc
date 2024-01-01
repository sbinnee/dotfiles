[ -f "$HOME/.Xresources" ] && xrdb -merge -I$HOME $HOME/.Xresources

# [ibus]
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

## Wallpaper
chbg &
## Keyboard input
xset s off &
xset -dpms &
xset r rate 330 40 &
nm-applet &
bluetooth off &
dunst &
#picom &
picom --experimental-backends &
clipmenud &
#mpd && mpd-mpris &
ibus-daemon -drx --panel /usr/lib/ibus/ibus-ui-gtk3 &
unclutter &
xsetroot -cursor_name left_ptr

## Window Manager
exec bspwm
# exec i3
# blocks &
# exec dwm
