#!/bin/bash
# bash completion for `tmux-ns` script
__tmux_ns()
{
    local cur prev _opts opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    # the first argument, the name of tmux session, should exist
    if [ -n "$prev" ]
    then
        case "$prev" in
            -C)
                # _dirpath=$(compgen -A directory -- "$cur")
                if [ "${#cur}" = 0 ]; then
                    _dirpath=$(compgen -A directory -- "$PWD")
                else
                    _dirpath=$(compgen -A directory -- "$PWD/$cur")
                fi
                COMPREPLY=( $(compgen -W "${_dirpath[*]}/" -- ${cur}) )
                # # Append a slash to directories if they aren't already
                # for i in "${!COMPREPLY[@]}"; do
                #     if [ -d "${COMPREPLY[i]}" ]; then
                #         COMPREPLY[$i]="${COMPREPLY[$i]}/"
                #     fi
                # done
                return 0
                ;;
            *)
                # build options
                _opts="$(find $HOME/miniconda3/envs -maxdepth 1 -mindepth 1 -type d )"
                opts=()
                for opt in $_opts
                do
                    opts+=(${opt##*/})
                done
                COMPREPLY=( $(compgen -W "${opts[*]}" -- ${cur}) )
                return 0
                ;;
        esac
    fi
}

complete -o nospace -F __tmux_ns tmux-ns
