#!/bin/bash

contain=".git"
desdir=$HOME

# get all files and directory in current directory
files=$(find .)

read -rp "Backup existing files (y/N): " resp

for f in $files; do
    # if it is file and not .sh file
    if [ -f "$f" ] && [[ "$f" != *$contain* ]] && ! grep -q "$f" ignoreFiles; then
        source=$(readlink -f "$f")
        dest="$desdir/${f:2}"
        if [ -f "$dest" ] && [ "$resp" = "y" ]
        then
            mv "$dest" "$dest.bak"
            echo "backup created for: $dest"
        elif [ ! -f "$dest" ]
        then
            dire=$(dirname "$dest")
            # check if target directory exist if not create it
            [ ! -d "$dire" ] && mkdir "$dire"
            ln -s "$source" "$dest"
            echo "Symlink created for $dest"
        fi
    fi
done

echo "Completed!"

