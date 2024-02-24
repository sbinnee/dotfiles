alias vim='nvim'

# color
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dmesg='dmesg --color=always'

alias l='ls -CF'
alias ll='ls -laFh'

# safety
alias rm='rm -I'
alias cp='cp -iv'

alias cdc='cd ~/.config'

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

# Bottom; top, htop alternative
alias btm='btm --hide_avg_cpu --network_use_bytes --color gruvbox --battery'
# markdown-live-preview (python,pip)
alias mlp='mlp --no-browser --port 8089'

# conda
alias torch='conda activate torch'

# typescript
ts() {
    # Check validity
    for f in "$@"
    do
        ext="${f##*.}"
        if [ "$ext" != "ts" ]
        then
            echo "Error: $f is not .ts file"
            return 1
        fi
    done

    # compile .ts and run .js
    for ts in "$@"
    do
        js="${ts%.ts}.js"
        tsc "$ts" \
            && node "$js" \
            || return 1
    done
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

chat() {
    local ROOT MODEL
    ROOT=$HOME/workspace/text-generation-webui
    # MODEL="mistral-7b-instruct-v0.2.Q4_K_M.gguf"
    MODEL="phi-2-orange.Q4_K_M.gguf"
    cd $ROOT
    source _venv/bin/activate
    echo "Loading \"$MODEL\" model..."
    echo "[WARNING] DO THE FOLLOWING FOR THIS MODEL"
    echo "1. Use \"instruct\" mode."
    echo "2. Use \"ChatML\" template (not Alpaca)."
    python server.py --verbose --chat-buttons --cpu --model "$MODEL"
}
