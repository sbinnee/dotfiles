# PS1
export PS1="\[$(tput bold)\]\u\[$(tput setaf 1)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 1)\] \[$(tput setaf 7)\]"'$(__git_ps1 "%s")'"\\$ \[$(tput sgr0)\]"
# PS1 lf
# https://github.com/gokcehan/lf/issues/107
[ -z "$LF_LEVEL" ] || export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 6)\]lfception-$LF_LEVEL\[$(tput setaf 1)\]]\[$(tput sgr0)\]"$PS1

# ENV
export EDITOR=nvim
export PATH=$HOME/.local/bin:$PATH
export HISTSIZE=10000
export HISTIGNORE='cd:cdn:lf:git s:git diff'
