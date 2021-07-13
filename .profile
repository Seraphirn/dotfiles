#!/bin/zsh
#
# Default programs:
#
export TERMINAL="gnome-terminal --hide-menubar --window"
#export TERMINAL="st"
export EDITOR="nvim"
export BROWSER="firefox"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
