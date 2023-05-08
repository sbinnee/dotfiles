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

# se() { du -a ~/.config | awk '{print $2}' | fzf | xargs -r $EDITOR ;}
se() { fd '.*' -I --type f -- $HOME/.config/dunst/ \
            $HOME/.config/fontconfig/ \
            $HOME/.config/bspwm/ \
            $HOME/.config/sxhkd/ \
            $HOME/.config/lf \
            $HOME/.config/mpd \
            $HOME/.config/ncmpcpp \
            $HOME/.config/mpv \
            $HOME/.config/nvim \
            $HOME/.config/polybar \
            $HOME/.config/ranger \
            $HOME/.config/sxiv \
            $HOME/.config/newsboat \
            $HOME/.config/firefox \
            $HOME/.config/alacritty \
            $HOME/.config/thunderbird \
            $HOME/.config/nsxiv \
            $HOME/.local/bin/ \
            | fzf | xargs -r $EDITOR ;}

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

## task spooler a.k.a. ts
# Run the cmd only if the cmd before finished well
#alias ts='ts -d'
# This env var makes each tmux pane had separate socket
# usage `ts-cuda 1` will create a socket for CUDA1
# If no argument is given, then set CUDA0 as default
ts-cuda() {
    _NUM_GPUS=4
    _DEFAULT_DEVICES="0,1,2,3"
    local N
    _check_index() {
        if [ $(( $1 )) -ge $_NUM_GPUS ]
        then
            printf "There exist only three GPUs (index starts from '0')\n"
            return 1
        else
            return 0
        fi
    }
    if [ $# -ge 1 ]
    then
        for i in $@
        do
            _check_index $i
            [ $? -eq 1 ] && return 1
        done
        N=$(printf "%d," "$@")
        N=${N%,}
    fi
    N=${N:-"$_DEFAULT_DEVICES"}
    # Disable NCCL p2p. Sometimes DataLoader freezes. Not sure it is related...
    # Theoretically it should not, but let's try as the thread below suggested.
    # https://github.com/pytorch/pytorch/issues/1637#issuecomment-730423426
    # https://docs.nvidia.com/deeplearning/nccl/user-guide/docs/env.html
    # export NCCL_P2P_DISABLE=1
    export CUDA_VISIBLE_DEVICES=$N
    export TS_SOCKET=/tmp/socket-ts.$(id -u).CUDA${N//,}
    printf "CUDA_VISIBLE_DEVICES=%s\n" $CUDA_VISIBLE_DEVICES
    printf "TS_SOCKET=%s\n" $TS_SOCKET
}

tf-env() {
    export TF_CPP_MIN_LOG_LEVEL=3
    export TF_FORCE_GPU_ALLOW_GROWTH='true'
}
