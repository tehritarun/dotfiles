#!/bin/bash

contain=".git"
desdir=$HOME

# get all files and directory in current directory
files=$(find .)

for f in $files; do
    # if it is file and not .sh file
    if [ -f "$f" ] && [[ "$f" != *$contain* ]] && ! grep -q "$f" ignoreFiles; then
        source=$(readlink -f "$f")
        dest="$desdir/${f:2}"
        if [ -f "$dest" ]
        then
            mv "$dest" "$dest.bak"
        fi
        dire=$(dirname "$dest")
        # check if target directory exist if not create it
        [ ! -d "$dire" ] && mkdir "$dire"
        ln -s "$source" "$dest"
        # echo "$source $dest"
    fi
done

