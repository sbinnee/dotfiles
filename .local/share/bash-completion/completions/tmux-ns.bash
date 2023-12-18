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
        # build options
        _opts="$(find $HOME/.conda/envs -maxdepth 1 -mindepth 1 -type d )"
        opts=()
        for opt in $_opts
        do
            opts+=(${opt##*/})
        done
        COMPREPLY=( $(compgen -W "${opts[*]}" -- ${cur}) )
        return 0
    fi
}

complete -F __tmux_ns tmux-ns
