# color
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dmesg='dmesg --color=always'

alias l='ls -CF'
alias ll='ls -laFh'

# safety
alias rm='rm -I'
alias cp='cp -iv'

alias cda='cd ~/workspace/bigannotator'
alias cdc='cd ~/.config'

# fugitive.vim
alias Git='vim -c ":Git | :only"'

# conda
alias torch='conda activate torch'
alias napari-embed='python ~/workspace/napari/examples/embed_ipython.py'

# youtube-dl
alias youtube-dl-en='youtube-dl --write-auto-sub --sub-lang en'
alias youtube-dl-fr='youtube-dl --write-auto-sub --sub-lang fr'
alias youtube-dl-ind='youtube-dl -o "%(playlist_index)d-%(title)s.%(ext)s"'
alias youtube-dl-720='youtube-dl -f "best[height=720]"'
alias youtube-dl-fr-720='youtube-dl -f "best[height=720]" --write-sub --sub-lang fr'
# youtube-dlc
alias youtube-dlc-en='youtube-dlc --write-auto-sub --sub-lang en'
alias youtube-dlc-fr='youtube-dlc --write-auto-sub --sub-lang fr'
alias youtube-dlc-ind='youtube-dlc -o "%(playlist_index)d-%(title)s.%(ext)s"'
alias youtube-dlc-720='youtube-dlc -f "best[height=720]"'

# se() { du -a ~/.config | awk '{print $2}' | fzf | xargs -r $EDITOR ;}
se() { fd '.*' -I --type f -- $HOME/.config/dunst/ \
			$HOME/.config/fontconfig/ \
			$HOME/.config/bspwm/ \
			$HOME/.config/sxhkd/ \
			$HOME/.config/lf \
			$HOME/.config/mpd \
			$HOME/.config/ncmpcpp \
			$HOME/.config/mpv \
			$HOME/.config/nvim \
			$HOME/.config/polybar \
			$HOME/.config/ranger \
			$HOME/.config/sxiv \
			$HOME/.config/newsboat \
			$HOME/.config/firefox \
			$HOME/.config/alacritty \
			$HOME/.local/bin/ \
			| fzf | xargs -r $EDITOR ;}

# byblis
alias cdb='cd ~/mnt/byblis'
# 8377 for clipper
alias ssh-byblis='ssh -R 8377:localhost:8377 byblis'
byblis_sshfs() {
	SRC="byblis:/home/seongbinlim"
	MNT="$HOME/mnt/byblis"
	if [ -z "$(mount | grep "byblis")" ]; then
		echo "MOUNTING byblis"
		sshfs "$@" "$SRC" "$MNT" && \
			echo "MOUNTED byblis on $MNT"
	else
		echo "UNMOUNTING byblis"
		fusermount3 -u "$@" "$HOME/mnt/byblis" \
			&& echo "UNMOUNTED" \
			|| echo "Error occurred. Use -z to unmount lazily"
	fi
}
_bp() {
	session="byblis-port"
	tmux new-session -d -s $session
	# clipper
	tmux send-keys -t $session "clipper" C-m
	tmux new-window -t $session
	tmux send-keys -t $session "ssh -N -L 8080:localhost:8080 byblis" C-m
	for p in "$@"
	do
		tmux split-window -v -t $session
		tmux send-keys -t $session "ssh -N -L "$p":localhost:"$p" byblis" C-m
	done
	tmux a -t $session
}
# spawn_lf() {
# 	$HOME/.config/bspwm/ddspawn dropdown_lf -e echo "abd"
# 	# tmux new-session -s "lf-tmux"
# 	# tmux send-keys -t "lf-tmux" "lf" C-m
# }
# attach_lf() {
# 	tmux a -t lf-tmux
# }
byblis_port() {
	# 8080 will be forwarded as well by default
	_bp 6006 8081 6007 "$@"
}

# Luke's lfcd
lfcd() {
	tmp="$(mktemp)"
	lf -last-dir-path="$tmp" "$@"
	if [ -f "$tmp" ]; then
		dir="$(cat "$tmp")"
		rm -f "$tmp"
		[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir" || return
	fi
}
alias lf='lfcd'

myhost() {
	CurrDir=$PWD || return
	# Block youtube
	RootDir="$HOME/Downloads/arch/hosts"
	cd "$RootDir" && \
		python updateHostsFile.py -arm -e fakenews gambling porn "$@" && \
		echo "Done block YouTube from hosts file!"
		# cat myhosts-blockyoutube > myhosts && \
		# ./UpdateHostsScript.sh "$@" && \
		# echo "Done block YouTube from hosts file!"
	cd "$CurrDir"
}

logbg() {
	sym1=$(ls -l $HOME/.config/currbg.jpg | awk '{print $11}')
	sym2=$(ls -l $sym1 | awk '{print $11}')
	echo "$sym2" "$1" >> $HOME/.config/currbg.log
	tail $HOME/.config/currbg.log
}

ps1_git() {
    if type __git_ps1 > /dev/null
    then
        echo "ERROR: __git_ps1 is already appended"
        return 1
    fi
    source /usr/share/git/completion/git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=1 # '*': unstaged, '+': staged
    GIT_PS1_SHOWSTASHSTATE=1 # '$'
    GIT_PS1_SHOWUNTRACKEDFILES=1 # '%'
    GIT_PS1_SHOWCOLORHINTS=1
    GIT_PS1_SHOWUPSTREAM="auto"
    # zsh needs `setopt PROMPT_SUBST`
    PS1='$(__git_ps1)'" $PS1"
}
