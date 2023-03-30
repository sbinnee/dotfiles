#!/bin/bash
# Ricing script to setup server environment
# Script follows below principles
# 0. Minimal
# 1. Local user install (no sudo required)
# 2. No version management
# 3. Copy server config from $_GIT_DOTFILES
#
# Tools to install
# - lf
# - fzf
# - conda-bash-completion (assuming bash-completion installed)
# - nvim
#
# Minimal configs
# - .bashrc and .bash_aliases
#   - PATH
#   - bash vim mode
# - git aliases
# - lf
# - fzf shortcuts
# - tmux
# - nvim

_URL_LF="https://github.com/gokcehan/lf/releases/download/r28/lf-linux-amd64.tar.gz"
_URL_FZF="https://github.com/junegunn/fzf/releases/download/0.38.0/fzf-0.38.0-linux_amd64.tar.gz"
_URL_FZF_KEY_BASH="https://github.com/junegunn/fzf/raw/master/shell/key-bindings.bash"
_URL_NVIM="https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz"
_URL_CONDA_BASH_COMPLETION="https://github.com/tartansandal/conda-bash-completion/raw/master/conda"
_FILENAME_LF="${_URL_LF##*/}"
_FILENAME_FZF="${_URL_FZF##*/}"
_FILENAME_FZF_KEY_BASH="${_URL_FZF_KEY_BASH##*/}"
_FILENAME_NVIM="${_URL_NVIM##*/}"
_DIRNAME_NVIM="${_FILENAME_NVIM%%.*}"

_GIT_DOTFILES="https://github.com/sbinnee/dotfiles.git"

_LOCAL_BIN="$HOME/.local/bin"
_LOCAL_FZF="$HOME/.fzf"
_LOCAL_SHARE="$HOME/.local/share"
_BASHRC="$HOME/.bashrc"
_BASH_ALIASES="$HOME/.bash_aliases"

_PATH_FZF_KEY_BASH="$_LOCAL_FZF/$_FILENAME_FZF_KEY_BASH"

cd  # go HOME
# Download
[ -d "Downloads" ] || mkdir Downloads
cd Downloads
#wget -c "$_URL_LF"
#wget -c "$_URL_FZF"
#wget -c "$_URL_FZF_KEY_BASH"
#wget -c "$_URL_CONDA_BASH_COMPLETION"
#wget -c "$_URL_NVIM"

# INSTALL
[ -d "$_LOCAL_BIN" ] || mkdir $_LOCAL_BIN
# lf
if [ ! -x "$_LOCAL_BIN/lf" ]
then
	tar -C $_LOCAL_BIN -xzf "$_FILENAME_LF"
fi

# fzf
if [ ! -x "$_LOCAL_BIN/fzf" ]
then
	tar -C $_LOCAL_BIN -xzf "$_FILENAME_FZF"
fi
[ -d "$_LOCAL_FZF" ] || mkdir $_LOCAL_FZF
if [ ! -f "$FILENAME_FZF_KEY_BASH" ]
then
	cp "$_FILENAME_FZF_KEY_BASH" "$_LOCAL_FZF"
fi

# nvim
if [ ! -d "$_DIRNAME_NVIM" ]
then
	tar -xzf $_FILENAME_NVIM
	ln -sr nvim-linux64/bin/nvim $_LOCAL_BIN/
fi

# conda-bash-completion
[ -d "$_LOCAL_SHARE" ] || mkdir "$_LOCAL_SHARE"
[ -d "$_LOCAL_SHARE/bash-completion/completions" ] || mkdir -p "$_LOCAL_SHARE/bash-completion/completions"
[ -f "$_LOCAL_SHARE/bash-completion/completions/conda" ] || cp conda "$_LOCAL_SHARE/bash-completion/completions/"

# .bashrc
if [ ! -n "$(grep 'Appended by dotfiles/rice.sh' "$_BASHRC")" ]
then
	printf "\n# Appended by dotfiles/rice.sh\n" | tee -a "$_BASHRC"
	# PATH
	printf "%s\n" 'export PATH=$HOME/.local/bin:$PATH' | tee -a "$HOME/.bashrc"
	# fzf
	printf "%s\n" '# fzf' "source $_PATH_FZF_KEY_BASH" | tee -a "$HOME/.bashrc"
fi

# .bash_aliases
[ -f "$_BASH_ALIASES" ] || touch "$_BASH_ALIASES"
if [ ! -n "$(grep 'Appended by dotfiles/rice.sh' "$_BASH_ALIASES")" ]
then
	printf "\n# Appended by dotfiles/rice.sh\n" | tee -a "$_BASH_ALIASES"
	# nvim
	printf "alias vim='nvim'"
	# lf
	printf "%s\n" 'lfcd() {' | tee -a "$_BASH_ALIASES"
	printf "\t%s\n" 'tmp="$(mktemp)"' | tee -a "$_BASH_ALIASES"
	printf "\t%s\n" "$(command -v lf)"' -last-dir-path="$tmp" "$@"' | tee -a "$_BASH_ALIASES"
	printf "\t%s\n" 'if [ -f "$tmp" ]' 'then' | tee -a "$_BASH_ALIASES"
	printf "\t\t%s\n" 'dir="$(cat "$tmp")"' | tee -a "$_BASH_ALIASES"
	printf "\t\t%s\n" 'rm -f "$tmp"' | tee -a "$_BASH_ALIASES"
	printf "\t\t%s\n" '[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir" || return' | tee -a "$_BASH_ALIASES"
	printf "\t%s\n" 'fi' | tee -a "$_BASH_ALIASES"
	printf "%s\n" '}' | tee -a "$_BASH_ALIASES"
	printf "alias lf='lfcd'\n" | tee -a "$_BASH_ALIASES"
fi


# git clone "$_GIT_DOTFILES"
# cd dotfiles

# unset

