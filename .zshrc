# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
HISTORY_IGNORE="(${$(tr '\n' '|' < $HOME/.zshignore)%|})"
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS

bindkey -v
export KEYTIMEOUT=1
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/seongbin/.zshrc'

fpath+=/usr/share/zsh/site-functions/_conda
fpath+=~/.local/share/zsh/site-functions
autoload -Uz compinit
compinit
_comp_options+=(globdots) # include hidden files
# End of lines added by compinstall
# pipx autocomplete
autoload -U bashcompinit
bashcompinit

# [Prompt]
# Need manual installation. Simply download the script.
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
# https://github.com/gokcehan/lf/issues/107
source $HOME/.local/share/git/git-prompt.sh
setopt PROMPT_SUBST
# PS1
GIT_PS1_SHOWDIRTYSTATE=1 # '*': unstaged, '+': staged
GIT_PS1_SHOWSTASHSTATE=1 # '$'
GIT_PS1_SHOWUNTRACKEDFILES=1 # '%'
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"
PS1='🦄 %B%F{15}%~$(__git_ps1 " (%s)")%F{11}%# %f%b'
[ -z $TMUX_PANE ] || PS1="[TMUX] $PS1"
[ -n "$LF_LEVEL" ] && PS1="(lfception: $LF_LEVEL) ""$PS1"
RPS1='%B%(?.%F{green}.%F{red}NOPE:%?)%f%b'

# pushd popd
setopt auto_pushd

# Completion
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
# zsh ssh completion goes through /etc/hosts, which is not good
# https://destinmoulton.com/blog/2018/how-to-disable-zsh-ssh-hosts-completion/
zstyle ':completion:*:(ssh|scp|sftp|rsh|rsync):*' hosts off
# https://superuser.com/questions/1098829/stop-zsh-incorporating-etc-hosts-in-autocomplete

# Delete key?
# cat and press key. Also look into my st config.h
bindkey -v "^[[H"    vi-beginning-of-line        # Home
bindkey -v "^A"      vi-beginning-of-line        # Ctrl+A
bindkey -v "^E"      vi-end-of-line              # st
bindkey -v "^[[1;5D" vi-backward-blank-word      # Ctrl+Left
bindkey -v "^[[1;5C" vi-forward-blank-word-end   # Ctrl+right
bindkey -v "^K"      kill-line                   # Ctrl+K
# Alacritty specific
bindkey -v "^[[3~"   vi-delete-char              # Delete Alacritty
bindkey -v "^[[F"    vi-end-of-line              # End Alacritty
## st specific
#bindkey -v "^Y"      vi-beginning-of-line        # Mouse down
#bindkey -v "^[[P"    vi-delete-char              # st
#bindkey -v "^[[4~"   vi-end-of-line              # Ctrl+e

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey "^x^e" edit-command-line

# Change cursor shape for different vi modes. (Luke)
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt

autoload -Uz add-zsh-hook
# OSC 7 support
# https://codeberg.org/dnkl/foot/wiki#user-content-spawning-new-terminal-instances-in-the-current-working-directory
function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}
add-zsh-hook -Uz chpwd chpwd-osc7-pwd

vim_fzf() {
    sel="$(fd -t f '.*' . | fzf --prompt '$vim ' --print0)"
    if [ -n "$sel" ]
    then
        $EDITOR "$sel"
    fi
}
zle -N vim_fzf
bindkey '^F' vim_fzf

# Fix for quote
# https://unix.stackexchange.com/questions/545471/zsh-ignore-glob-if-nomatch
unsetopt nomatch

[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/seongbin/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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

# Syntax highlighting
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/fzf/key-bindings.zsh

# fnm
export PATH="/home/seongbin/.local/share/fnm:$PATH"
eval "`fnm env`"

# uv
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
