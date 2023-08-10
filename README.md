# Dotfiles
Arch linux configs.

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
- .config/gtk-3.0/
- .config/mpd
- .config/ncmpcpp
- .config/thunderbird
- .config/openurl.desktop
- .config/bottom

## .local/bin
- .local/bin/audio\_toggle
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
- .local/bin/play\_next
- .local/bin/play\_previous
- .local/bin/pw\_volume\_up
- .local/bin/pw\_volume\_down
- .local/bin/pw\_audio\_toggle
- .local/bin/printer
- .local/bin/notify-users
- .local/bin/watch\_later
- .local/bin/toggle\_sticky
- .local/bin/youtube-dl
- .local/bin/mpv-ytdl
- .local/bin/project\_root
- .local/bin/print\_mediainfo
- .local/bin/lf-tmux
- .local/bin/change\_bspwm\_floating\_border
- .local/bin/\_make\_tmux\_session
- .local/bin/hypr\_ddspawn
- .local/bin/hypr\_fullscreen

## Manual update required
- [dmenu](https://tools.suckless.org/dmenu/)
- [picom](https://github.com/ibhagwan/picom)
- [alacritty](https://github.com/alacritty/alacritty)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
- [hosts](https://github.com/StevenBlack/hosts)
- [acpilight](https://gitlab.com/wavexx/acpilight)
- [par](http://www.nicemice.net/par/)


## Additional settings
**crontab (dcron)**
```
# MIN HOUR DAY MONTH DAYOFWEEK  COMMAND
# Change background every 15 minutes
*/10 * * * * DISPLAY=:0 XAUTHORITY=$HOME/.Xauthority XDG_RUNTIME_DIR=/run/user/1000 $HOME/.local/bin/chbg
0 17-24 * * * /usr/bin/newsboat -x reload
#0 17-24 * * * /usr/bin/newsboat -x reload && /usr/bin/polybar-msg hook newsboat 1
#0 * * * * $HOME/.local/bin/notify-users -u critical "👀 Peek outside" && paplay --server=unix:/run/user/1000/pulse/native /usr/share/sounds/freedesktop/stereo/bell.oga
```

**logind.conf.d/override.conf**

Power switch behaviors `/etc/systemd/logind.conf.d/override.conf`
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
