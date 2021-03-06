# Dotfiles
Arch linux configs.
abd


## .@~
- .inputrc
- .profile
- .xinitrc
- .Xresources
- .zshrc
- .zprofile
- .bash\_aliases
- .bashrc
- .bash\_profile
- .condarc
- .tmux.conf
- .gitconfig

## .config
- .config/dunst/
- .config/bspwm/
- .config/sxhkd/
- .config/lf/
- .config/mpv/
- .config/nvim/
- .config/ranger/
- .config/polybar/
- .config/fontconfig/
- .config/myhosts
- .config/acpi\_handler.sh
- .config/dwm
- .config/dircolors.trapd00r
- .config/picom.conf
- .config/sxiv/
- .config/newsboat/
- .config/unicode/
- .config/.Xmodmap
- .config/firefox
- .config/alacritty
- .config/pulse/
- .config/gtk-3.0/
- .config/mpd
- .config/ncmpcpp
- .config/thunderbird
- .config/openurl.desktop

## .local/bin
- .local/bin/audio\_toggle
- .local/bin/volume\_down
- .local/bin/volume\_up
- .local/bin/brightness\_down
- .local/bin/brightness\_up
- .local/bin/gm-capture
- .local/bin/gm-snipping
- .local/bin/dmenuunicode
- .local/bin/emojicode
- .local/bin/chbg
- .local/bin/rclone-zotero
- .local/bin/unix
- .local/bin/vim
- .local/bin/dmenu\_run2
- .local/bin/playsound
- .local/bin/timer
- .local/bin/reboot
- .local/bin/poweroff
- .local/bin/rich\_markdown
- .local/bin/blocks
- .local/bin/gdrivedl
- .local/bin/grub-update
- .local/bin/256colortest
- .local/bin/dmount
- .local/bin/dumount
- .local/bin/dmenupass
- .local/bin/sel\_monitor
- .local/bin/spotify
- .local/bin/dmenu\_lang
- .local/bin/torrent
- .local/bin/check\_running
- .local/bin/covid
- .local/bin/covid\_echo
- .local/bin/news
- .local/bin/nbflatten
- .local/bin/pictopic
- .local/bin/alacritty\_spawn\_cwd
- .local/bin/currency
- .local/bin/blueman
- .local/bin/brave
- .local/bin/tsm
- .local/bin/kakaotalk
- .local/bin/compress
- .local/bin/decompress
- .local/bin/attack\_vpn
- .local/bin/open\_url
- .local/bin/fontpreview-ueberzug
- .local/bin/dict
- .local/bin/play\_pause
- .local/bin/pw\_volume\_up
- .local/bin/pw\_volume\_down
- .local/bin/pw\_audio\_toggle

## Manual update required
- dmenu
- [picom](https://github.com/ibhagwan/picom)
- alacritty
- youtube-dl
- hosts
- xbacklight


## Additional settings
**crontab (dcron)**
```
# MIN HOUR DAY MONTH DAYOFWEEK  COMMAND
# Change background every 15 minutes
*/3 * * * * DISPLAY=:0 XAUTHORITY=$HOME/.Xauthority $HOME/.local/bin/chbg
0 12,17-24 * * * /usr/bin/newsboat -x reload && /usr/bin/polybar-msg hook newsboat 1
0 * * * * DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send -t 3000 '???? Peek outside'
```

**TLP**
```
# USB hub
USB_AUTOSUSPEND=1 # default
USB_BLACKLIST="0bda:8153"
USB_AUTOSUSPEND_DISABLE_ON_SHUTDOWN=1
DEVICES_TO_DISABLE_ON_STARTUP="bluetooth"
# GPU
RUNTIME_PM_BLACKLIST="00:02.0"
```

**logind.conf.d/override.conf**
```
[Login]
HandlePowerKey=suspend
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
LidSwitchIgnoreInhibited=no
```

**libinput**

Enable touchpad while typing `/usr/share/X11/xorg.conf.d/41-libinput.conf`
```
Section "InputClass"
  Identifier "libinput touchpad catchall"
  MatchDriver "libinput"
  MatchIsTouchpad "on"
  Option "Disable While Typing" "off"
EndSection
```

**brave**
- Hardware acceleration setting
    - [Archwiki](https://wiki.archlinux.org/index.php/Hardware_video_acceleration)
    - [--use-gl=desktop](https://www.linuxuprising.com/2021/01/how-to-enable-hardware-accelerated.html)
- SmoothScroll
    -  Step size: 25
    -  Animation time: 250
    -  Acceleration scale: 2
    -  Acceleration delta: 50
    -  Pulse Scale: 8
    -  Arrow key step size: 50
    -  [x] Enable touchpad support
    -  [x] Enable pulse algorithm
