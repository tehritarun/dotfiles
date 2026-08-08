#!/bin/bash

command -v git && echo "Please install git and rerun"

git clone https://github.com/tehritarun/dotfiles.git ~/dotfiles

cd ~/dotfiles || exit 2

./setup.sh
