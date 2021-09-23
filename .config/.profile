#!/usr/bin/env sh
# Profile file. Runs on login.

# Adds `~/.local/bin/` (which contains user-specified scripts) to $PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"  # go path
. "$HOME/.cargo/env"  # rust
export TERMINAL=alacritty
export COLORTERM=truecolor
export EDITOR=vim
export BROWSER=brave
export BROWSER_SECONDARY=firefox
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
# [firefox]
# ~/Desktop
export XDG_DESKTOP_DIR="$HOME/Downloads/Desktop"
# https://wiki.archlinux.org/index.php/Firefox#Hardware_video_acceleration
export MOZ_X11_EGL=1
export MOZ_DISABLE_RDD_SANDBOX=1
# hardware video acceleration
export LIBVA_DRIVER_NAME=i965
export VDPAU_DRIVER=va_gl
export VAAPI_MPEG4_ENABLED=true
# [napari]
# libgl : Weird behaivor. It searched i915 and iris, skipping i965
# https://github.com/dosbox-staging/dosbox-staging/issues/319
export MESA_LOADER_DRIVER_OVERRIDE=i965

[ -f "$HOME/.config/.ips" ] && source "$HOME/.config/.ips"

# [less/man] colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')" 		# Light Red
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')" 		# Light Cyan
export LESS_TERMCAP_me="$(printf '%b' '[0m')" 		# default?
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')" 	# Yellow bg:blue
export LESS_TERMCAP_se="$(printf '%b' '[0m')" 		# default?
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')" 		# Green
export LESS_TERMCAP_ue="$(printf '%b' '[0m')" 		# default?
# >>> Less with tput
# mb: Start blinking
# md: Start bold mode
# so: Start standout mode
# se: End standout mode
# us: Start underlining
# me: End all mode
# ue: End underlining
# export LESS_TERMCAP_mb=$(tput bold; tput setaf 9) # Light Red
# export LESS_TERMCAP_md=$(tput bold; tput setaf 14) # Light Cyan
# export LESS_TERMCAP_so=$(tput bold; tput setab 66; tput setaf 11) # Yellow bg:blue
# export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# export LESS_TERMCAP_us=$(tput bold; tput smul; tput setaf 10)
# export LESS_TERMCAP_me=$(tput sgr0) # default
# export LESS_TERMCAP_ue=$(tput sgr0) # Don't need it

# [ls] color
eval "$(dircolors "$HOME/.config/dircolors.trapd00r")"

# [GTK2]
export GTK_THEME=Adwaita-dark

# [ibus]
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# [fzf] make it use fd instead of find
export FZF_DEFAULT_COMMAND='fd --type f'

# [sdcv]
export STARDICT_DATA_DIR=$HOME/Downloads/arch/stardict

# [ranger]
export RANGER_LOAD_DEFAULT_RC=FALSE
# [lf] trick
export OPENER='ls'
lficons="$HOME/.config/lf/lficons"
[ -f "$lficons" ] && . "$lficons"

# Make fiji (Java application) menu works with window manager (bspwm)
# https://bbs.archlinux.org/viewtopic.php?id=258444
export _JAVA_AWT_WM_NONREPARENTING=1

# unix prompt to welcome users
# If `~/.local/bin/` is correctly appended to $PATH,
# it will show a famous quote by Dennis Ritchie.
if [ -z "$TMUX_PANE" ]
then
    # [zsh] msgs about bg jobs. Make it silent.
    setopt LOCAL_OPTIONS NO_MONITOR
    brightness=10
    user=$(users)
    printf "Set display brightness to %s%%\n" "$brightness"
    xbacklight -set "$brightness" &
    # [zsh]
    figlet -f slant Hi "${user:u}"! | lolcat
    # [bash]
    unix
else
    source "$HOME/.zshrc"
    # [bash]
    # source "$HOME/.bashrc"
fi

_countdown() {
    printf 'Press [Enter] to start X server'
    read _
    printf '\nStarting X server!'
}

if [ "$(tty)" = "/dev/tty1" ]; then
    _countdown | lolcat
    pgrep bspwm || startx
fi

# vim: ts=4 expandtab
