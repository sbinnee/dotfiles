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

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# This is the list for lf icons:
# https://github.com/BrodieRobertson/dotfiles
export LF_ICONS="\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.vimrc=:\
*.viminfo=:\
*.gitignore=:\
*.zshrc=ﲵ:\
*.zprofile=ﲵ:\
*.zcompdump=ﲵ:\
*.zshenv=ﲵ:\
*.bashrc=ﲵ:\
*.bash_logout=ﲵ:\
*.bash_history=ﲵ:\
*.bash_profile=ﲵ:\
*.profile=ﲵ:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
*.nix=:\
"

# unix prompt to welcome users
# If `~/.local/bin/` is correctly appended to $PATH, 
# it will show a famous quote by Dennis Ritchie.
[ -z $TMUX_PANE ] && \
	user=`users` figlet -f mini Welcome `echo "${user^}"` | lolcat && \
	unix
# figlet -f mini Welcome `echo "${user^}"` | \
# 	cowsay -nf $(find /usr/share/cows -type f -name kitty* | shuf -n 1) | \
# 	lolcat

# if [[ "$(tty)" = "/dev/tty1" ]]; then
# 	pgrep i3 || startx
# fi
