# color
alias ls='ls --color=auto -F'
alias grep='grep --color=auto'
alias dmesg='dmesg --color=always'

alias l='ls -CF'
alias ll='ls -laFh'

# safety
alias rm='rm -I'
alias cp='cp -iv'

alias fd='fd --ignore-vcs'

# fugitive.vim
# alias Git='vim -c ":Git | :only"'
Git() {
    if [ $# -eq 0 ]
    then
        vim -c ":Git | :only"
    elif [ $# -eq 1 ]
    then
        case "$1" in
            log)
                vim -c ":Gclog"
                ;;
            *)
                echo "Not defined"
                ;;
        esac
    else
        vim -c ":Git $@"
    fi
}

ss() {
    # Find git root
    root="$(git rev-parse --path-format=relative --show-toplevel)"
    rootabs="$(git rev-parse --show-toplevel)"
    # Common venv directory names
    venv_names=(".venv" "venv" "virtualenv")
    # Search for venv in project root
    for venv_name in "${venv_names[@]}"; do
        venv_path="$rootabs/$venv_name"
        # Check if venv exists and has activate script
        if [[ -f "$venv_path/bin/activate" ]]; then
            echo "Found venv at: $venv_path"
            source "$venv_path/bin/activate"
            echo "Activated venv: $venv_name"
            break
        fi
    done
    # Check if venv was activated
    if [[ -z "$VIRTUAL_ENV" ]]; then
        echo "No venv found in project root"
    fi
}

# Luke's lfcd
lfcd() {
    tmp="$(mktemp)"
    # `command` is needed in case `lfcd` is aliased to `lf`
    command lf -last-dir-path="$tmp" "$@"
    # lf -last-dir-path="$tmp" "$@"
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
        python updateHostsFile.py -arm -e fakenews gambling porn "$@" && \
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

ps1_git() {
    if type __git_ps1 > /dev/null
    then
        echo "ERROR: __git_ps1 is already appended"
        return 1
    fi
    source /usr/share/git/completion/git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=1 # '*': unstaged, '+': staged
    GIT_PS1_SHOWSTASHSTATE=1 # '$'
    GIT_PS1_SHOWUNTRACKEDFILES=1 # '%'
    GIT_PS1_SHOWCOLORHINTS=1
    GIT_PS1_SHOWUPSTREAM="auto"
    # zsh needs `setopt PROMPT_SUBST`
    PS1='$(__git_ps1)'" $PS1"
}

_vim_fzf() {
    sel="$(fd -t f '.*' . | fzf --prompt '$vim ' --print0)"
    if [ -n "$sel" ]
    then
        $EDITOR "$sel"
    fi
}
