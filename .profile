#!/usr/bin/env sh
# Profile file. Runs on login.

# Adds `~/.local/bin/` (which contains user-specified scripts) to $PATH
export PATH="$HOME/.local/bin/:$PATH"
export TERMINAL=st
export EDITOR=vim
export BROWSER=brave

# less/man colors
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

# ls color
eval "$(dircolors "$HOME/.config/dircolors.trapd00r")"

export GTK_THEME=Adwaita

export RANGER_LOAD_DEFAULT_RC=FALSE

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# lf trick
export OPENER='ls'
lficons="$HOME/.config/lf/lficons"
[ -f "$lficons" ] && . "$lficons"


# unix prompt to welcome users
# If `~/.local/bin/` is correctly appended to $PATH, 
# it will show a famous quote by Dennis Ritchie.
[ -z "$TMUX_PANE" ] && \
	user=$(users) && \
		figlet -f mini Welcome ${user^} | lolcat && \
		unix
# 	cowsay -nf $(find /usr/share/cows -type f -name kitty* | shuf -n 1) | \

_countdown() {
	printf 'Press [Enter] to start X server'
	read _
	printf '\nStarting X server!'
	# printf 'Will start X server in 3 seconds! 0'
	# for i in {1..2}; do
	# 	printf '\b%d' $i && sleep 1
	# done
}

if [ "$(tty)" = "/dev/tty1" ]; then
	_countdown | lolcat
	pgrep i3 || startx
fi
