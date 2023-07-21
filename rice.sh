#!/bin/bash
# Download it from https://raw.githubusercontent.com/sbinnee/dotfiles/server/rice.sh
#
#   $ curl -fLO https://raw.githubusercontent.com/sbinnee/dotfiles/server/rice.sh
#   $ sh rice.sh
#
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
# - rg
# - bat (with bash-completion)
# - viddy
# - ts
# - delta
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
_URL_RG="https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz"
_URL_BAT="https://github.com/sharkdp/bat/releases/download/v0.23.0/bat-v0.23.0-x86_64-unknown-linux-gnu.tar.gz"
_URL_VIDDY="https://github.com/sachaos/viddy/releases/download/v0.3.6/viddy_0.3.6_Linux_x86_64.tar.gz"
_URL_TS="https://github.com/justanhduc/task-spooler/archive/refs/tags/v2.0.0.tar.gz"
_URL_DELTA="https://github.com/dandavison/delta/releases/download/0.16.5/delta-0.16.5-x86_64-unknown-linux-gnu.tar.gz"

_FILENAME_LF="${_URL_LF##*/}"
_FILENAME_FZF="${_URL_FZF##*/}"
_FILENAME_FZF_KEY_BASH="${_URL_FZF_KEY_BASH##*/}"
_FILENAME_NVIM="${_URL_NVIM##*/}"
_FILENAME_FD="${_URL_FD##*/}"
_FILENAME_RG="${_URL_RG##*/}"
_FILENAME_BAT="${_URL_BAT##*/}"
_FILENAME_VIDDY="${_URL_VIDDY##*/}"
_FILENAME_TS="task-spooler-${_URL_TS##*/v}"  # prefix and suffix
_FILENAME_DELTA="${_URL_DELTA##*/}"
_DIRNAME_FD="${_FILENAME_FD%.tar*}"
_DIRNAME_RG="${_FILENAME_RG%.tar*}"
_DIRNAME_NVIM="${_FILENAME_NVIM%.tar*}"
_DIRNAME_BAT="${_FILENAME_BAT%.tar*}"
_DIRNAME_TS="${_FILENAME_TS%.tar*}"
_DIRNAME_DELTA="${_FILENAME_DELTA%.tar*}"

_GIT_DOTFILES="https://github.com/sbinnee/dotfiles.git"
_GIT_DOTFILES_BRANCH="server"

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
[ -f "$_FILENAME_RG" ] || wget -c "$_URL_RG"
[ -f "$_FILENAME_BAT" ] || wget -c "$_URL_BAT"
[ -f "$_FILENAME_VIDDY" ] || wget -c "$_URL_VIDDY"
[ -f "./conda" ] || wget -c "$_URL_CONDA_BASH_COMPLETION"
[ -f "$_FILENAME_NVIM" ] || wget -c "$_URL_NVIM"
[ -f "$_FILENAME_TS" ] || wget -O $_FILENAME_TS -c "$_URL_TS"
[ -f "$_FILENAME_DELTA" ] || wget -c "$_URL_DELTA"

# [INSTALL]
[ -d "$_LOCAL_BIN" ] || mkdir -p $_LOCAL_BIN
[ -d "$_LOCAL_SHARE" ] || mkdir -p "$_LOCAL_SHARE"
[ -d "$_LOCAL_SHARE/bash-completion/completions" ] || mkdir -p "$_LOCAL_SHARE/bash-completion/completions"
# [lf]
if [ ! -x "$_LOCAL_BIN/lf" ]
then
    tar -C $_LOCAL_BIN -xzf "$_FILENAME_LF"
fi
# [fzf]
if [ ! -x "$_LOCAL_BIN/fzf" ]
then
    tar -C $_LOCAL_BIN -xzf "$_FILENAME_FZF"
fi
[ -d "$_LOCAL_FZF" ] || mkdir $_LOCAL_FZF
if [ ! -f "$_PATH_FZF_KEY_BASH" ]
then
    cp -v "$_FILENAME_FZF_KEY_BASH" "$_LOCAL_FZF"
fi
# [fd]
if [ ! -x "$_LOCAL_BIN/fd" ]
then
    tar -xzf $_FILENAME_FD
    cp -v $_DIRNAME_FD/fd $_LOCAL_BIN/
fi
# [rg]
if [ ! -x "$_LOCAL_BIN/rg" ]
then
    tar -xzf $_FILENAME_RG
    cp -v $_DIRNAME_RG/rg $_LOCAL_BIN/
fi
# [bat]
# binary
if [ ! -x "$_LOCAL_BIN/bat" ]
then
    tar -xzf $_FILENAME_BAT
    cp -v $_DIRNAME_BAT/bat $_LOCAL_BIN/
fi
# [viddy]
if [ ! -x "$_LOCAL_BIN/viddy" ]
then
    tar -xzf $_FILENAME_VIDDY viddy
    cp -v viddy $_LOCAL_BIN/
fi
# bash completion
[ -f "$_LOCAL_SHARE/bash-completion/completions/bat.bash" ] || cp -v "$_DIRNAME_BAT/autocomplete/bat.bash" "$_LOCAL_SHARE/bash-completion/completions/"

# [nvim]
if [ ! -d "$_DIRNAME_NVIM" ]
then
    tar -xzf $_FILENAME_NVIM
    ln -sr nvim-linux64/bin/nvim $_LOCAL_BIN/
fi

# [ts]
if [ ! -d "$_DIRNAME_TS" ]
then
    tar -xzf $_FILENAME_TS
    if [ ! -d "$_LOCAL_BIN/ts" ]
    then
        cd "$_DIRNAME_TS"
        make
        cp -v ts $_LOCAL_BIN/
        cd ..
    fi
fi

# [delta]
if [ ! -d "$_DIRNAME_DELTA" ]
then
    tar -xzf $_FILENAME_DELTA
    if [ ! -x "$_LOCAL_BIN/delta" ]
    then
        cp -v $_DIRNAME_DELTA/delta $_LOCAL_BIN
    fi
fi

# [conda-bash-completion]
[ -f "$_LOCAL_SHARE/bash-completion/completions/conda" ] || cp -v conda "$_LOCAL_SHARE/bash-completion/completions/"

# [CONFIG]
# [git]
git config --global init.defaultBranch main
git config --global core.editor "nvim"
git config --global merge.tool nvimdiff
git config --global merge.conflictStyle diff3
git config --global alias.s 'status'
git config --global alias.wdiff 'diff --word-diff'
git config --global alias.graph 'log --oneline --decorate --graph --all'
git config --global alias.g "log --format='%C(auto)%h %as (%an) %s %D%C(reset)' --all --graph"
# [delta]
git config --global core.pager 'delta'
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.side-by-side 'true'
git config --global delta.navigate 'true'
git config --global delta.light 'false'

# [CLONE REPO dotfiles]
[ -d "$_LOCAL_CONFIG" ] || mkdir $_LOCAL_CONFIG
if [ ! -d dotfiles ]
then
    git clone --branch "$_GIT_DOTFILES_BRANCH" "$_GIT_DOTFILES"
fi
# [lf]
[ -d "$_LOCAL_CONFIG/lf" ] || mkdir $_LOCAL_CONFIG/lf
cp -vi dotfiles/.config/lf/lfrc $_LOCAL_CONFIG/lf/
cp -vi dotfiles/.config/lf/pv.sh $_LOCAL_CONFIG/lf/
# tmux
cp -vi dotfiles/.tmux.conf $HOME/

# [.bashrc]
if [ ! -n "$(grep 'Appended by dotfiles/rice.sh' "$_BASHRC")" ]
then
    printf "\n# Appended by dotfiles/rice.sh\n" | tee -a "$_BASHRC"
    cat dotfiles/.bashrc | tee -a "$_BASHRC"
    # fzf
    printf "%s\n" '# fzf' "source $_PATH_FZF_KEY_BASH" | tee -a "$_BASHRC"
fi

# [.bash_aliases]
[ -f "$_BASH_ALIASES" ] || touch "$_BASH_ALIASES"
if [ ! -n "$(grep 'Appended by dotfiles/rice.sh' "$_BASH_ALIASES")" ]
then
    printf "\n# Appended by dotfiles/rice.sh\n" | tee -a "$_BASH_ALIASES"
    cat dotfiles/.bash_aliases | tee -a "$_BASH_ALIASES"
fi

# [nvim]
if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share/}/nvim/site/autoload/plug.vim" ]
then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi
[ -d "$_LOCAL_CONFIG/nvim" ] || mkdir $_LOCAL_CONFIG/nvim
[ -d "$_LOCAL_CONFIG/nvim/lua" ] || mkdir $_LOCAL_CONFIG/nvim/lua
cp -vi dotfiles/.config/nvim/init.vim $_LOCAL_CONFIG/nvim/
cp -vi dotfiles/.config/nvim/lua/lsp.lua $_LOCAL_CONFIG/nvim/lua/
cp -vi dotfiles/.config/nvim/lsp_requirements.txt $_LOCAL_CONFIG/nvim/lua/

# [.LOCAL/BIN]
[ -x "$_LOCAL_BIN/project_root" ] || cp -v dotfiles/.local/bin/project_root $_LOCAL_BIN

echo "Setup done! Please, source .bashrc"
