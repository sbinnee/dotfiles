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

# headphone script
alias headphones='. ~/.script/headphones'

# vpn
alias dante="xclip -sel clip ~/.passwd/dante"

# conda
alias torch='conda activate torch'

# youtube-dl
alias youtube-dl-en='youtube-dl --write-auto-sub --sub-lang en'
alias youtube-dl-fr='youtube-dl --write-auto-sub --sub-lang fr'

# se() { du -a ~/.config | awk '{print $2}' | fzf | xargs -r $EDITOR ;}
se() { find .config/ -type d \( \
	-path ".config/Code - OSS" -o \
	-path .config/Signal -o \
	-path .config/configstore -o \
	-path .config/inkscape -o \
	-path .config/spotify -o \
	-path .config/fcitx \) \
	-prune -o -type f -print | fzf | xargs -r $EDITOR ;}
