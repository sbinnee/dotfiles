#!/bin/bash
# WARNING
# This script is not tested at all. Once I need to setup a macOS, I will.
#
# NOTES
# - python version may be updated from time to time


if ! command -v brew
then
    echo "Homebrew is not installed"
    exit 1
fi

PKGS=(
    cmake
    go
    wget
    tmux
    ffmpeg
    rsync
    rclone
    fzf
    ripgrep
    fd
    git-delta
    lf
    neovim
    sdcv
    zsh-syntax-highlighting
    conda-zsh-completion
    bat
    htop
    bottom
    chafa
    figlet
    ncdu
    viddy
)

brew install ${PKGS[*]}

if grep -q 'export DOTFILES'
then
    :
else
    echo "export DOTFILES=$(realpath .)" >> $HOME/.zshrc
fi
