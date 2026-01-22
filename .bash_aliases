# color
alias ls='ls --color=auto -F'
alias grep='grep --color=auto'
alias dmesg='dmesg --color=always'

alias l='ls -CF'
alias ll='ls -laFh'

# safety
if [[ $- == *i* ]]; then
    alias rm='rm -I'
    alias cp='cp -iv'
fi

alias vim='nvim'
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

# ~/.bashrc or ~/.zshrc
_claude() {
    # Claude Code OTel
    env CLAUDE_CODE_ENABLE_TELEMETRY=1 \
        OTEL_METRICS_EXPORTER=otlp \
        OTEL_LOGS_EXPORTER=otlp \
        OTEL_EXPORTER_OTLP_PROTOCOL=grpc \
        OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4317 \
        OTEL_METRIC_EXPORT_INTERVAL=10000 \
        OTEL_LOGS_EXPORT_INTERVAL=5000 \
        claude "$@"
}
alias claude='_claude'
