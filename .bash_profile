source .profile
[ -z $TMUX_PANE ] || \
	source .bashrc && \
	export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 2)\]\u\[$(tput setaf 3)\]@\[$(tput setaf 4)\]\h\[$(tput setaf 1)\]TMUX$TMUX_PANE \[$(tput setaf 5)\]\w\[$(tput setaf 1)\]]\[$(tput setaf 7)\]$ \[$(tput sgr0)\]"
