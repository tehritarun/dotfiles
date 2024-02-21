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

# cd improved

cd(){
    [[ $# -eq 0 ]] && return
    builtin cd "$@"
}

bettercd(){
    cd $1
    if [ -z $1 ]
    then
        selection=$(ls -a | fzf --height 40% --reverse)
        if [[ -d "$selection" ]]
        then
            cd "$selection"
        elif [[ -f "$selection" ]]
        then
            nvim "$selection"
        fi
    fi
}

alias cd="bettercd"

# Source Alias if available
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

