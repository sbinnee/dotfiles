# PS1
GIT_PS1_SHOWDIRTYSTATE=1 # '*': unstaged, '+': staged
GIT_PS1_SHOWSTASHSTATE=1 # '$'
GIT_PS1_SHOWUNTRACKEDFILES=1 # '%'
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"
export PS1="\[$(tput bold)\]\u\[$(tput setaf 1)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 1)\] \[$(tput setaf 6)\]"'$(__git_ps1 "[%s]")'"\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
# PS1 lf
# https://github.com/gokcehan/lf/issues/107
[ -z "$LF_LEVEL" ] || export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 6)\]lfception-$LF_LEVEL\[$(tput setaf 1)\]]\[$(tput sgr0)\]"$PS1

# ENV
export EDITOR=nvim
export PATH=$HOME/.local/bin:$PATH
export HISTSIZE=10000
export HISTIGNORE='ls:l:ll:cd:lf:git s:git diff:git g:Git:_vim_fzf'

# key-bindings
bind '\C-f:"_vim_fzf\n"'
# use fd
export FZF_DEFAULT_COMMAND='fd --type f'

# PS1 ts-cuda, check `ts-cuda` in .bash_aliases
__ts-cuda-PS1() {
    [ -z "$TS_SOCKET" ] || printf "[ts-cuda%s]" ${CUDA_VISIBLE_DEVICES//,}
}
export PS1='$(__ts-cuda-PS1)'$PS1
