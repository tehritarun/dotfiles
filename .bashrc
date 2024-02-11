#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

eval "$(starship init bash)"

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;
