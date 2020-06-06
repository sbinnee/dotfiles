# color
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dmesg='dmesg --color=always'

alias l='ls -CF'
alias ll='ls -laFh'

# safety
alias rm='rm -I'

alias cds='cd ~/Downloads/suckless'
# neovim
# alias vim='nvim'

# lf
alias r='lf'

# conda
alias torch='conda activate torch'

# youtube-dl
alias youtube-dl-en='youtube-dl --write-auto-sub --sub-lang en'
alias youtube-dl-fr='youtube-dl --write-auto-sub --sub-lang fr'
alias youtube-dl-ind='youtube-dl -o "%(playlist_index)d-%(title)s.%(ext)s"'

# se() { du -a ~/.config | awk '{print $2}' | fzf | xargs -r $EDITOR ;}
se() { find $HOME/.config/dunst/ \
			$HOME/.config/fontconfig/ \
			$HOME/.config/i3/ \
			$HOME/.config/bspwm/ \
			$HOME/.config/sxhkd/ \
			$HOME/.config/i3blocks/ \
			$HOME/.config/lf \
			$HOME/.config/mpv \
			$HOME/.config/nvim \
			$HOME/.config/polybar \
			$HOME/.config/ranger \
			$HOME/.local/bin/ \
			-type f -print | fzf | xargs -r $EDITOR ;}

# byblis
alias cdb='cd ~/mnt/byblis'
byblis_sshfs() {
	SRC="byblis:/home/seongbinlim/workspace"
	MNT="$HOME/mnt/byblis"
	if [ -z "$(mount | grep "byblis")" ]; then
		echo "MOUNTING byblis"
		sshfs "$SRC" "$MNT" "$@" && \
			echo "MOUNTED byblis on $MNT"
	else
		echo "UNMOUNTING byblis"
		umount "$HOME/mnt/byblis" "$@" && \
			echo "UNMOUNTED"
	fi
}
_bp() {
	session="byblis-port"
	tmux new-session -d -s $session
	tmux send-keys -t $session "ssh -N -L 8080:localhost:8080 byblis" C-m
	for p in "$@"
	do
		tmux split-window -v -t $session
		tmux send-keys -t $session "ssh -N -L $p:localhost:$p byblis" C-m
	done
	
	tmux a -t $session
}
byblis_port() { 
	_bp 8081 6006 "$@" 
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
		cat myhosts-blockyoutube > myhosts && \
		./UpdateHostsScript.sh "$@" && \
		echo "Done block YouTube from hosts file!"
	cd "$CurrDir"
}

logbg() {
	sym1=$(ls -l $HOME/.config/currbg.jpg | awk '{print $11}')
	sym2=$(ls -l $sym1 | awk '{print $11}')
	echo "$sym2" "$1" >> $HOME/.config/currbg.log
	tail $HOME/.config/currbg.log
}
