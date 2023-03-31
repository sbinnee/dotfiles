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
# - fd
#
# Scripts to install/copy
# - [x] project_root
#
# Minimal configs
# - .bashrc and .bash_aliases
#   - [x] PATH
#   - [ ] bash vim mode
# - git aliases
# - [x] lf
# - [x] fzf shortcuts
# - [x] tmux
# - nvim

_URL_LF="https://github.com/gokcehan/lf/releases/download/r28/lf-linux-amd64.tar.gz"
_URL_FZF="https://github.com/junegunn/fzf/releases/download/0.38.0/fzf-0.38.0-linux_amd64.tar.gz"
_URL_FZF_KEY_BASH="https://github.com/junegunn/fzf/raw/master/shell/key-bindings.bash"
_URL_NVIM="https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz"
_URL_CONDA_BASH_COMPLETION="https://github.com/tartansandal/conda-bash-completion/raw/master/conda"
_URL_FD="https://github.com/sharkdp/fd/releases/download/v8.6.0/fd-v8.6.0-x86_64-unknown-linux-gnu.tar.gz"
_FILENAME_LF="${_URL_LF##*/}"
_FILENAME_FZF="${_URL_FZF##*/}"
_FILENAME_FZF_KEY_BASH="${_URL_FZF_KEY_BASH##*/}"
_FILENAME_NVIM="${_URL_NVIM##*/}"
_FILENAME_FD="${_URL_FD##*/}"
_DIRNAME_FD="${_FILENAME_FD%.tar*}"
_DIRNAME_NVIM="${_FILENAME_NVIM%.tar*}"

_GIT_DOTFILES="https://github.com/sbinnee/dotfiles.git"

_LOCAL_DOWNLOADS="$HOME/Downloads"
_LOCAL_BIN="$HOME/.local/bin"
_LOCAL_FZF="$HOME/.fzf"
_LOCAL_SHARE="$HOME/.local/share"
_BASHRC="$HOME/.bashrc"
_BASH_ALIASES="$HOME/.bash_aliases"
_LOCAL_CONFIG="$HOME/.config"

_PATH_FZF_KEY_BASH="$_LOCAL_FZF/$_FILENAME_FZF_KEY_BASH"

cd  # go HOME
# Download
[ -d "$_LOCAL_DOWNLOADS" ] || mkdir $_LOCAL_DOWNLOADS
cd $_LOCAL_DOWNLOADS

[ -f "$_FILENAME_LF" ] || wget -c "$_URL_LF"
[ -f "$_FILENAME_FZF" ] || wget -c "$_URL_FZF"
[ -f "$_FILENAME_FZF_KEY_BASH" ] || wget -c "$_URL_FZF_KEY_BASH"
[ -f "$_FILENAME_FD" ] || wget -c "$_URL_FD"
[ -f "./conda" ] || wget -c "$_URL_CONDA_BASH_COMPLETION"
[ -f "$_FILENAME_NVIM" ] || wget -c "$_URL_NVIM"

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

# fd
if [ ! -d "$_LOCAL_BIN/fd" ]
then
	tar -xzf $_FILENAME_FD
	cp $_DIRNAME_FD/fd $_LOCAL_BIN/
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

# .LOCAL/BIN
[ -x "$_LOCAL_BIN/project_root" ] || cp dotfiles/.local/bin/project_root $_LOCAL_BIN

# CONFIG
# git
git config --global core.editor "nvim"
git config --global alias.s 'status'
git config --global alias.wdiff 'diff --word-diff'
git config --global alias.graph 'log --oneline --decorate --graph --all'
git config --global alias.g "log --format='%C(auto)%h %as (%an) %s %D%C(reset)' --all --graph"

# .config
[ -d "$_LOCAL_CONFIG" ] || mkdir $_LOCAL_CONFIG
if [ ! -d dotfiles ]
then
	git clone "$_GIT_DOTFILES"
	cd dotfiles
	# lf
	[ -d "$_LOCAL_CONFIG/lf" ] || mkdir $_LOCAL_CONFIG/lf
	cp dotfiles/.config/lf/lfrc $_LOCAL_CONFIG/lf/
	cp dotfiles/.config/lf/pv.sh $_LOCAL_CONFIG/lf/
	# tmux
	cp dotfiles/.tmux.conf $HOME/
fi

# .bashrc
if [ ! -n "$(grep 'Appended by dotfiles/rice.sh' "$_BASHRC")" ]
then
    cd $_LOCAL_DOWNLOADS/dotfiles
	printf "\n# Appended by dotfiles/rice.sh\n" | tee -a "$_BASHRC"
    cat .bashrc | tee -a "$_BASHRC"
	# fzf
	printf "%s\n" '# fzf' "source $_PATH_FZF_KEY_BASH" | tee -a "$_BASHRC"
fi
cd $_LOCAL_DOWNLOADS

# .bash_aliases
[ -f "$_BASH_ALIASES" ] || touch "$_BASH_ALIASES"
if [ ! -n "$(grep 'Appended by dotfiles/rice.sh' "$_BASH_ALIASES")" ]
then
    cd $_LOCAL_DOWNLOADS/dotfiles
	printf "\n# Appended by dotfiles/rice.sh\n" | tee -a "$_BASH_ALIASES"
    cat .bash_aliases | tee -a "$_BASH_ALIASES"
fi
cd $_LOCAL_DOWNLOADS


# nvim
if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share/}/nvim/site/autoload/plug.vim" ]
then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi
[ -d "$_LOCAL_CONFIG/nvim" ] || mkdir $_LOCAL_CONFIG/nvim
[ -d "$_LOCAL_CONFIG/nvim/lua" ] || mkdir $_LOCAL_CONFIG/nvim/lua
cp -i dotfiles/.config/nvim/init.vim $_LOCAL_CONFIG/nvim
cp -i dotfiles/.config/nvim/lua/lsp.lua $_LOCAL_CONFIG/nvim/lua

echo "Setup done! Please, source .bashrc"
