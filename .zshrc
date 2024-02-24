[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

# [History]
HISTSIZE=10000
SAVEHIST=10000
HISTORY_IGNORE="(${$(tr '\n' '|' < $HOME/.zshignore)%|})"

# [Prompt]
# Need manual installation. Simply download the script.
source $HOME/.local/share/git/git-prompt.sh
setopt PROMPT_SUBST
# PS1
GIT_PS1_SHOWDIRTYSTATE=1 # '*': unstaged, '+': staged
GIT_PS1_SHOWSTASHSTATE=1 # '$'
GIT_PS1_SHOWUNTRACKEDFILES=1 # '%'
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"
PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
PS1='🦄 %B%F{15}%~$(__git_ps1 " (%s)")%F{11}%# %f%b'
[ -z $TMUX_PANE ] || PS1="[TMUX] $PS1"
# https://github.com/gokcehan/lf/issues/107
[ -n "$LF_LEVEL" ] && PS1="(lfception: $LF_LEVEL) ""$PS1"
RPS1='%B%(?.%F{green}.%F{red}NOPE:%?)%f%b'

# [Completion]
fpath+=/opt/homebrew/share/zsh/site-functions
autoload -Uz compinit
compinit
_comp_options+=(globdots) # include hidden files
# options
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


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# freezes on `man`
# source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
