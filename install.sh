#!/bin/bash

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Usage: $0 [options]"
    echo
    echo "Options:"
    echo "  -h, --help    Show this help message and exit"
    exit 0
fi

set -xe
echo $0

# variables
export XDG_CONFIG_HOME=$HOME/.config/
export XDG_CACHE_HOME=$HOME/.cache/
export XDG_DATA_HOME=$HOME/.local/share/
export XDG_STATE_HOME=$HOME/.local/state/
export LOCAL_BIN=$HOME/.local/bin/

# make xdg dirs
mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_CACHE_HOME
mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_STATE_HOME
mkdir -p $LOCAL_BIN

# create files
mkdir -p $XDG_STATE_HOME/bash
mkdir -p $XDG_CONFIG_HOME/.assets
touch $XDG_STATE_HOME/bash/history
touch $XDG_DATA_HOME/gnupg
touch $XDG_DATA_HOME/wget-hsts
mkdir -p ~/Media/Pictures/Mpv/
mkdir -p $XDG_DATA_HOME/vim/undo

# install all config
stow config/ -t $XDG_CONFIG_HOME
stow .assets/ -t $XDG_CONFIG_HOME/.assets
stow bash/ -t $HOME
stow scripts/ -t $LOCAL_BIN

# Create files after linked
touch $XDG_CONFIG_HOME/ncmpcpp/error.log
touch $XDG_CONFIG_HOME/mpd/playlists
