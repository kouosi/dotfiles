#!/bin/bash
set -xe

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
touch $XDG_STATE_HOME/bash/history
touch $XDG_DATA_HOME/gnupg
touch $XDG_CONFIG_HOME/docker
touch $XDG_DATA_HOME/wget-hsts
mkdir -p $XDG_CONFIG_HOME/gdb
touch $XDG_CONFIG_HOME/gdb/init
mkdir -p ~/Pictures/Mpv/
touch $XDG_CONFIG_HOME/ncmpcpp/error.log
touch $XDG_CONFIG_HOME/mpd/playlists

# install all
stow config/ -t $XDG_CONFIG_HOME
stow bash/ -t $HOME
# stow vim/ -t $HOME/.vim/
stow lbin/ -t $LOCAL_BIN
