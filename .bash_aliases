# color
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dmesg='dmesg --color=always'

alias l='ls -CF'
alias ll='ls -laFh'

# safety
alias rm='rm -I'
alias cp='cp -iv'

alias cds='cd ~/Downloads/suckless'
alias cdc='cd ~/.config'

# conda
alias torch='conda activate torch'

# youtube-dl
alias youtube-dl-en='youtube-dl --write-auto-sub --sub-lang en'
alias youtube-dl-fr='youtube-dl --write-auto-sub --sub-lang fr'
alias youtube-dl-ind='youtube-dl -o "%(playlist_index)d-%(title)s.%(ext)s"'
alias youtube-dl-720='youtube-dl -f "best[height=720]"'
# youtube-dlc
alias youtube-dlc-en='youtube-dlc --write-auto-sub --sub-lang en'
alias youtube-dlc-fr='youtube-dlc --write-auto-sub --sub-lang fr'
alias youtube-dlc-ind='youtube-dlc -o "%(playlist_index)d-%(title)s.%(ext)s"'
alias youtube-dlc-720='youtube-dlc -f "best[height=720]"'

# se() { du -a ~/.config | awk '{print $2}' | fzf | xargs -r $EDITOR ;}
se() { fd '.*' -I --type f -- $HOME/.config/dunst/ \
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
			$HOME/.config/sxiv \
			$HOME/.config/newsboat \
			$HOME/.config/firefox \
			$HOME/.local/bin/ \
			| fzf | xargs -r $EDITOR ;}

# byblis
alias cdb='cd ~/mnt/byblis'
byblis_sshfs() {
	SRC="byblis:/home/seongbinlim/workspace"
	MNT="$HOME/mnt/byblis"
	if [ -z "$(mount | grep "byblis")" ]; then
		echo "MOUNTING byblis"
		sshfs "$@" "$SRC" "$MNT" && \
			echo "MOUNTED byblis on $MNT"
	else
		echo "UNMOUNTING byblis"
		umount "$@" "$HOME/mnt/byblis" && \
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
		python updateHostsFile.py -ar -e fakenews gambling porn "$@" && \
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
