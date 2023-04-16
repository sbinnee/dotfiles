# color
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dmesg='dmesg --color=always'

alias l='ls -CF'
alias ll='ls -laFh'

# safety
alias rm='rm -I'
alias cp='cp -iv'

alias cda='cd ~/workspace/napari-bigannotator'
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
alias napari-embed='python ~/workspace/napari/examples/embed_ipython.py'

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

# byblis
alias cdb='cd ~/mnt/byblis'
# alias ssh-byblis='ssh -R 8377:localhost:8377 byblis'  # 8377 for clipper
byblis_sshfs() {
    SRC="byblis:/home/seongbinlim"
    MNT="$HOME/mnt/byblis"
    if [ -z "$(mount | grep "byblis")" ]; then
        [ -d "$MNT" ] || mkdir "$MNT"
        echo "MOUNTING byblis"
        sshfs "$@" "$SRC" "$MNT" \
            && echo "MOUNTED byblis on $MNT"
    else
        echo "UNMOUNTING byblis"
        fusermount3 -u "$@" "$HOME/mnt/byblis"
        if [ $? -eq 0 ]
        then
            echo "UNMOUNTED"
            rmdir "$MNT"
        else
            echo "Error occurred. Use -z to unmount lazily"
        fi
    fi
}
_bp() {
    session="byblis-port"
    tmux new-session -d -s $session
    # # clipper
    # tmux send-keys -t $session "clipper" C-m
    # tmux new-window -t $session
    tmux send-keys -t $session "ssh -N -L 8080:localhost:8080 byblis" C-m
    for p in "$@"
    do
        tmux split-window -v -t $session
        tmux send-keys -t $session "ssh -N -L "$p":localhost:"$p" byblis" C-m
    done
    tmux a -t $session
}
# spawn_lf() {
#   $HOME/.config/bspwm/ddspawn dropdown_lf -e echo "abd"
#   # tmux new-session -s "lf-tmux"
#   # tmux send-keys -t "lf-tmux" "lf" C-m
# }
# attach_lf() {
#   tmux a -t lf-tmux
# }
byblis_port() {
    # 8080 will be forwarded as well by default
    _bp 6006 8081 6007 "$@"
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

coqui() {
    source ~/workspace/coqui-ai/bin/activate
}
