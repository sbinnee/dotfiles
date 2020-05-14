# color
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dmesg='dmesg --color=always'

alias l='ls -CF'
alias ll='ls -laFh'

alias cds='cd ~/Downloads/suckless'
# neovim
# alias vim='nvim'

# lf
alias r='lf'

# conda
alias torch='conda activate torch'
alias landscape='conda activate landscape'

# youtube-dl
alias youtube-dl-en='youtube-dl --write-auto-sub --sub-lang en'
alias youtube-dl-fr='youtube-dl --write-auto-sub --sub-lang fr'

# se() { du -a ~/.config | awk '{print $2}' | fzf | xargs -r $EDITOR ;}
se() { find $HOME/.config/dunst/ \
			$HOME/.config/fontconfig/ \
			$HOME/.config/i3/ \
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
alias byblis-sshfs='sshfs byblis:/home/seongbinlim/workspace /home/seongbin/mnt/byblis'
_bp() {
	session="byblis-port"
	tmux new-session -d -s $session
	tmux send-keys -t $session "ssh -N -L 8080:localhost:8080 byblis" C-m
	for p in $@
	do
		tmux split-window -v -t $session
		tmux send-keys -t $session "ssh -N -L $p:localhost:$p byblis" C-m
	done
	
	tmux a -t $session
}
byblis-port() { 
	_bp 8081 6006 $@ 
}

# Luke's lfcd
lfcd() {
	tmp="$(mktemp)"
	lf -last-dir-path="$tmp" "$@"
	if [ -f "$tmp" ]; then
		dir="$(cat "$tmp")"
		rm -f "$tmp"
		[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
	fi
}
alias lf='lfcd'
