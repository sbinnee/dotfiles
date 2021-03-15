#!/bin/sh
# Pick a config and carefully apply changes line by line, using (n)vim diff
# functionality. vim or nvim, and fzf are required.

# Check dependencies
# Use nvim if available, otherwise use vim
DIFF=""
if [ -x "$(which nvim)" ]
then
    DIFF='nvim -d'
elif [-x "$(which vim)"]
then
    DIFF='vim -d'
else
    echo "Install 'nvim' or 'vim'"
    exit 1
fi

# Check dependency `fzf`
if [ ! -x "$(which fzf)" ]
then
    echo "'fzf' is not installed"
    exit 1
fi

# Filter list
sel="$(find . -path ./.git -prune -o -type f | fzf)"

# Open (n)vim diff
if [ -n "$sel" ]
then
    if [ -f "$HOME/$sel" ]
    then
        $DIFF "$HOME/$sel" "$sel"
    else
        # If file does not exist in local, copy it
        cp -iv "$sel" "$HOME/$sel"
    fi
fi
