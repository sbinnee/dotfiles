# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
export KEYTIMEOUT=1
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/seongbin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Prompt
PS1='🦄 %B%F{15}%~%F{11}%# %f%b'
RPS1='%B%(?.%F{green}.%F{red}NOPE:%?)%f%b'

# Completion
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"


# Delete key?
# cat and press key. Also look into my st config.h
bindkey -v "^[[P"    vi-delete-char
bindkey -v "^[[H"    vi-beginning-of-line        # Ctrl+a
bindkey -v "^A"	     vi-beginning-of-line
bindkey -v "^[[4~"   vi-end-of-line              # Ctrl+e
bindkey -v "^E"	     vi-end-of-line
bindkey -v "^[[1;5D" vi-backward-blank-word      # Ctrl+Left
bindkey -v "^[[1;5C" vi-forward-blank-word-end   # Ctrl+right

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
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

source /usr/share/fzf/key-bindings.zsh



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

# >>> nvm >>>
nvm-init() {
# You need to source nvm before you can use it. Do one of the following
# or similar depending on your shell (and then restart your shell):
#
#   echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.bashrc
#   echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.zshrc
#
# You can now install node.js versions (e.g. nvm install 10) and
# activate them (e.g. nvm use 10).
#
# init-nvm.sh is a convenience script which does the following:
#
# [ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
# source /usr/share/nvm/nvm.sh
# source /usr/share/nvm/bash_completion
# source /usr/share/nvm/install-nvm-exec
#
# You may wish to customize and put these lines directly in your
# .bashrc (or similar) if, for example, you would like an NVM_DIR
# other than ~/.nvm or you don't want bash completion.
#
# See the nvm readme for more information: https://github.com/creationix/nvm
# source /usr/share/nvm/init-nvm.sh
	source /usr/share/nvm/init-nvm.sh && \
		[ -n "$NVM_DIR" ] && PS1="[nvm]$PS1"
}
# <<< nvm <<<
#
# Syntax highlighting
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
