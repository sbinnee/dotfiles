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
if ![ -x "$(which fzf)" ]
then
    echo "'fzf' is not installed"
    exit 1
fi

# Filter directories out
filelist=$(grep '!' .gitignore | tr -d '!')
filtered=""
for f in $filelist
do
    [ -f "$f" ] && filtered="$filtered\n$f"
done

# Select one file using `fzf`
sel="$(echo -e $filtered | fzf)"

# Open (n)vim diff
if [ -n "$sel" ]
then
    $DIFF "$HOME/$sel" "$sel"
fi
