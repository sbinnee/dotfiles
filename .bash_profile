source .profile
# TMUX session
[ -z $TMUX_PANE ] || \
	source .bashrc && \
	export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 9)\]\u\[$(tput setaf 3)\] at \[$(tput setaf 4)\]\h\[$(tput setaf 3)\] in \[$(tput setaf 1)\]TMUX$TMUX_PANE \[$(tput setaf 5)\]\w\[$(tput setaf 1)\]]\[$(tput setaf 7)\]$ \[$(tput sgr0)\]"
