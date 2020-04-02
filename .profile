#!/usr/bin/env sh
# Profile file. Runs on login.

# Adds `~/.local/bin/` (which contains user-specified scripts) to $PATH
export PATH="$HOME/.local/bin/:$PATH"
export EDITOR=vim
export OPENER='ls'

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}" # Light Red
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}" # Light Cyan
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}" # default?
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}" # Yellow bg:blue
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}" # default?
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}" # Green
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}" # default?
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

export GTK_THEME=Adwaita

export RANGER_LOAD_DEFAULT_RC=FALSE

# This is the list for lf icons:
export LF_ICONS="di=📁:\
fi=📃:\
tw=🤝:\
ow=📂:\
ln=⛓:\
or=❌:\
ex=🎯:\
*.txt=✍:\
*.mom=✍:\
*.me=✍:\
*.ms=✍:\
*.png=🖼:\
*.ico=🖼:\
*.jpg=📸:\
*.JPG=📸:\
*.jpeg=📸:\
*.gif=🖼:\
*.svg=🗺:\
*.xcf=🖌:\
*.html=🌎:\
*.xml=📰:\
*.gpg=🔒:\
*.css=🎨:\
*.pdf=📕:\
*.djvu=📚:\
*.epub=📚:\
*.csv=📓:\
*.xlsx=📓:\
*.tex=📜:\
*.md=📘:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.mkv=📽:\
*.mp4=📽:\
*.webm=📽:\
*.mpeg=📽:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.tar.gz=📦:\
*.tar=📦:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=📙:\
*.iso=📀:\
*.img=📀:\
*.bib=🎓:\
*.ged=👪:\
*.part=💔:\
*.torrent=🔽:\
"

# unix prompt to welcome users
# If `~/.local/bin/` is correctly appended to $PATH, 
# it will show a famous quote by Dennis Ritchie.
if [[ -z $TMUX_PANE ]]; then
	user=`users`
	figlet -f mini Welcome `echo "${user^}"` | lolcat
	# figlet -f mini Welcome `echo "${user^}"` | \
	# 	cowsay -nf $(find /usr/share/cows -type f -name kitty* | shuf -n 1) | \
	# 	lolcat
	unix
fi
