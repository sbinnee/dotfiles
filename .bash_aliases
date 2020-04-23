# color
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dmesg='dmesg --color=always'

alias l='ls -CF'
alias ll='ls -laFh'

# neovim
# alias vim='nvim'

# lf
alias r='lf'

# conda
alias torch='conda activate torch'

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
alias byblis-sshfs='sshfs byblis:/home/seongbinlim/workspace /home/seongbin/mnt/byblis'

byblis-port() { tmux new-session \; \
	send-keys 'printf "[Jupyter] PORTING localhost:8080\n"' C-m \; \
	send-keys 'ssh -N -L 8080:localhost:8080 byblis' C-m \; \
	split-window -v \; \
	send-keys 'printf "[Jupyter] PORTING localhost:8081\n"' C-m \; \
	send-keys 'ssh -N -L 8081:localhost:8081 byblis' C-m \; \
	split-window -v \; \
	send-keys 'printf "[TensorBoard] PORTING localhost:6006\n"' C-m \; \
	send-keys 'ssh -N -L 6006:localhost:6006 byblis' C-m \;
}

