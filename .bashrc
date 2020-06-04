#
# ~/.bashrc
#
# vi mode in terminal
# set -o vi
# vi moode kills CTRL+L
# bind -m vi-insert "\C-l":clear-screen
# bind -m vi-insert "\C-d":delete-char
# bind -m vi-command "\C-d":delete-char

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


_parse_git_branch() {
	git branch 2> /dev/null | grep '^*' | colrm 1 2
}
parse_git_branch() {
	str=$(_parse_git_branch)
	# [ -n $str ] && printf " (%s) " $str
	# git branch 2> /dev/null | grep '^*' | colrm 1 2
	[ -n $str ] && [ $str != "master" ] && printf "(%s)" $str
}

# PS1='[\u@\h \W]\$ '
# export PS1='\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 2)\]\u\[$(tput setaf 3)\] at \[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 1)\]]\[$(tput setaf 7)\]$(parse_git_branch)$ \[$(tput sgr0)\]'
# Luke's
# export PS1='\[$(tput bold)\]\[$(tput setaf 5)\][\[$(tput setaf 2)\]\u\[$(tput setaf 3)\] at \[$(tput setaf 4)\]\h \[$(tput setaf 15)\]\w\[$(tput setaf 5)\]]\[$(tput setaf 7)\]$ \[$(tput sgr0)\]'
# export PS1='\[$(tput bold)\] \[$(tput setaf 2)\]\u\[$(tput setaf 3)\] at \[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w \[$(tput setaf 7)\]$ \[$(tput sgr0)\]'
# #--- PS1 ---# #
# user="sb"
# host="xps"
# 🦄🐾
prefix='🦄'
sep="|"
# export PS1='\[$(tput bold)\]\[$(tput setaf 5)\]$sep\[$(tput setaf 2)\]$user\[$(tput setaf 3)\] at\[$(tput setaf 4)\] $host\[$(tput setaf 15)\] \w\[$(tput setaf 5)\]$sep\[$(tput setaf 7)\]$ \[$(tput sgr0)\]'
export PS1='$prefix\[$(tput bold)\]\[$(tput setaf 15)\] \w\[$(tput setaf 5)\]\[$(tput setaf 7)\]$ \[$(tput sgr0)\]'

# PS1 tmux
[ -z $TMUX_PANE ] || export PS1="\[$(tput bold)\]\[$(tput setaf 5)\]$sep\[$(tput setaf 7)\]TMUX$TMUX_PANE\[$(tput setaf 5)\]$sep"$PS1

# PS1 lf
# https://github.com/gokcehan/lf/issues/107
[ -z $LF_LEVEL ] || export PS1="\[$(tput bold)\]\[$(tput setaf 5)\]$sep\[$(tput setaf 6)\]lfception-$LF_LEVEL\[$(tput setaf 5)\]$sep"$PS1

# Enable bash completion with sudo
# complete -cf sudo

# Alias
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# fix Del key for st
# tput smkx

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/seongbin/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/seongbin/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/seongbin/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/seongbin/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# >>> nvm >>>
nvm-init() {
# You need to source nvm before you can use it. Do one of the following
# or similar depending on your shell (and then restart your shell):
# 
#   echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.bashrc
#   echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.zshrc
# 
# You can now install node.js versions (e.g. nvm install 10) and
# activate them (e.g. nvm use 10).
# 
# init-nvm.sh is a convenience script which does the following:
# 
# [ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
# source /usr/share/nvm/nvm.sh
# source /usr/share/nvm/bash_completion
# source /usr/share/nvm/install-nvm-exec
# 
# You may wish to customize and put these lines directly in your
# .bashrc (or similar) if, for example, you would like an NVM_DIR
# other than ~/.nvm or you don't want bash completion.
# 
# See the nvm readme for more information: https://github.com/creationix/nvm
# source /usr/share/nvm/init-nvm.sh
	source /usr/share/nvm/init-nvm.sh && \
		[ -n "$NVM_DIR" ] && export PS1="\[$(tput bold)\]\[$(tput setaf 5)\]$sep\[$(tput setaf 3)\]nvm\[$(tput setaf 5)\]$sep"$PS1
}
[ -n "$NVM_DIR" ] && export PS1="\[$(tput bold)\]\[$(tput setaf 5)\]$sep\[$(tput setaf 3)\]nvm\[$(tput setaf 5)\]$sep"$PS1
# <<< nvm <<<

# # >>> Less with tput
# export LESS=-R
# # mb: Start blinking
# export LESS_TERMCAP_mb=$(tput bold; tput setaf 9) # Light Red
# # md: Start bold mode
# export LESS_TERMCAP_md=$(tput bold; tput setaf 14) # Light Cyan
# # me: End all mode
# export LESS_TERMCAP_me=$(tput sgr0) # default
# # so: Start standout mode
# export LESS_TERMCAP_so=$(tput bold; tput setab 66; tput setaf 11) # Yellow bg:blue
# # se: End standout mode
# export LESS_TERMCAP_se=$(tput sgr0)
# # us: Start underlining
# export LESS_TERMCAP_us=$(tput bold; tput smul; tput setaf 10)
# # ue: End underlining
# export LESS_TERMCAP_ue=$(tput sgr0)

# fzf
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
