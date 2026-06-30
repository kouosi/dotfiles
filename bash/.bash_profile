## Default apps
export BROWSER=firefox
export EDITOR=nvim
export TERMINAL=footclient
export MANPAGER='nvim +Man!'

## XDG base DIRs
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

## PATH For local binary
export PATH="$PATH":"$HOME"/.local/bin:"$XDG_DATA_HOME"/npm/bin

## Bash History control
export HISTCONTROL=ignorespace:ignoredups:erasedups
export HISTFILE="$XDG_STATE_HOME"/bash/history
export HISTFILESIZE=800000 # in lines
export HISTSIZE=8000
export HISTTIMEFORMAT="%F %T "

## Zig Lang
export ZVM_PATH=/usr/zvm
export ZIG_GLOBAL_CACHE_DIR="$XDG_DATA_HOME"/.zig-cache/
export PATH="$PATH":"$ZVM_PATH"/bin:"$ZVM_PATH"/self

## Rust Lang
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export PATH="$PATH":"$CARGO_HOME"/bin

## Go Lang
export GOPATH="$XDG_DATA_HOME"/go
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod

## Python
export PYTHON_HISTORY="$XDG_STATE_HOME"/python_history
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME"/python
export PYTHONUSERBASE="$XDG_DATA_HOME"/python

## Others
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export JULIA_DEPOT_PATH="$XDG_DATA_HOME"/julia:"$JULIA_DEPOT_PATH"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android
export ANDROID_HOME="$XDG_DATA_HOME"/android/sdk

## Some hacks
export GPG_TTY=$(tty) # Use current tty as gpg tty
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export LESSHISTFILE=- # Do not store .lessist file
export MOZ_ENABLE_WAYLAND=1
export W3M_DIR="$XDG_STATE_HOME"/w3m
export PLATFORMIO_CORE_DIR="$XDG_DATA_HOME"/platformio
export WINEPREFIX="$XDG_DATA_HOME"/wine
export XKB_DEFAULT_OPTIONS=ctrl:nocaps #,ctrl:swapcaps # Remap caps lock key
export _JAVA_AWT_WM_NONREPARENTING=1
# export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export QT_QPA_PLATFORMTHEME=qt6ct
export GTK_THEME=Adwaita:dark
export PF_INFO="ascii os kernel uptime pkgs shell editor wm"
export XDG_MENU_PREFIX=arch-
export CLANG_FORMAT_STYLE=Chromium
export GDBHISTFILE="$XDG_CONFIG_HOME"/gdb/.gdb_history

## Source bashrc for interactive
. ~/.bashrc

## Start wm
if [ "$(tty)" == "/dev/tty1" ]; then
	start-sway
fi
