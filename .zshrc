[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"
export PATH=$HOME/.local/bin:$HOME/go/bin:$PATH
export EDITOR=nvim
export STARDICT_DATA_DIR=$HOME/Downloads/stardict

# [History]
HISTSIZE=10000
SAVEHIST=10000
# HISTORY_IGNORE="(${$(tr '\n' '|' < $HOME/.zshignore)%|})"
# [Prompt]
# Need manual installation. Simply download the script.
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
source $HOME/.local/share/git/git-prompt.sh
setopt PROMPT_SUBST
# PS1
GIT_PS1_SHOWDIRTYSTATE=1 # '*': unstaged, '+': staged
GIT_PS1_SHOWSTASHSTATE=1 # '$'
GIT_PS1_SHOWUNTRACKEDFILES=1 # '%'
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"
# PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
PS1='🦄 %B%F{15}%~$(__git_ps1 " (%s)")%F{11}%# %f%b'
[ -z $TMUX_PANE ] || PS1="[TMUX] $PS1"
# https://github.com/gokcehan/lf/issues/107
[ -n "$LF_LEVEL" ] && PS1="(lfception: $LF_LEVEL) ""$PS1"
RPS1='%B%(?.%F{green}.%F{red}NOPE:%?)%f%b'

# [Completion]
fpath+=/opt/homebrew/share/zsh/site-functions
# conda-zsh-completion
fpath+="$HOME/.local/share/zsh/conda-zsh-completion"
autoload -Uz compinit
compinit
_comp_options+=(globdots) # include hidden files
# End of lines added by compinstall
# pipx autocomplete
autoload -U bashcompinit
bashcompinit
source $HOME/.local/share/bash-completion/completions/tmux-ns.bash

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
# zsh ssh completion goes through /etc/hosts, which is not good
# https://destinmoulton.com/blog/2018/how-to-disable-zsh-ssh-hosts-completion/
zstyle ':completion:*:(ssh|scp|sftp|rsh|rsync):*' hosts off
# https://superuser.com/questions/1098829/stop-zsh-incorporating-etc-hosts-in-autocomplete

# [Vim mode]
bindkey -v

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

# key bindings
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey -v "^K"      kill-line                   # Ctrl+K
bindkey -v "^[[1;3D" vi-backward-blank-word      # Option+Left
bindkey -v "^[[1;3C" vi-forward-blank-word-end   # Option+Right

# [Ctrl-X + Ctrl-E]
autoload -z edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

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



# Syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Set up fzf key bindings and fuzzy completion
if command -v fzf > /dev/null
then
    source <(fzf --zsh)
fi

if [ -f "$HOME/miniconda3/bin/conda" ]
then
    eval "$($HOME/miniconda3/bin/conda shell.zsh hook)"
fi

# uv
if command -v uv > /dev/null
then
    source $HOME/.cargo/env
    eval "$(uv generate-shell-completion zsh)"
    eval "$(uvx --generate-shell-completion zsh)"
fi
# fnm
if command -v fnm > /dev/null
then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi
