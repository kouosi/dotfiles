# Do nothing if bash is not running interactively
[[ $- != *i* ]] && return

# Shell Properties
set -o vi # vim mode

# PATH For local binary
export PATH=$PATH:$HOME/.local/bin

# Default apps
export BROWSER=firefox
export EDITOR=helix
export TERMINAL=footclient
export MANPAGER='nvim +Man!'

# XDG base dirs
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# Colors
COLOR_RESET='\[\e[0m\]'
COLOR_BLACK='\[\e[0;30m\]'
COLOR_RED='\[\e[0;31m\]'
COLOR_GREEN='\[\e[0;32m\]'
COLOR_YELLOW='\[\e[0;33m\]'
COLOR_BLUE='\[\e[0;34m\]'
COLOR_PURPLE='\[\e[0;35m\]'
COLOR_CYAN='\[\e[0;36m\]'
COLOR_LIGHTGRAY='\[\e[0;37m\]'

# Bold colors
COLOR_BBLACK='\[\e[1;30m\]'
COLOR_BRED='\[\e[1;31m\]'
COLOR_BGREEN='\[\e[1;32m\]'
COLOR_BYELLOW='\[\e[1;33m\]'
COLOR_BBLUE='\[\e[1;34m\]'
COLOR_BPURPLE='\[\e[1;35m\]'
COLOR_BCYAN='\[\e[1;36m\]'
COLOR_BLIGHTGRAY='\[\e[1;37m\]'

# Bash History control
export HISTCONTROL=ignorespace:ignoredups:erasedups
export HISTFILE="$XDG_STATE_HOME"/bash/history
export HISTFILESIZE=800000 # in lines
export HISTSIZE=8000
export HISTTIMEFORMAT="%F %T "

# Some hacks
export GPG_TTY=$(tty) # Use current tty as gpg tty
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export LESSHISTFILE=-  # Do not store .lessist file
export MOZ_ENABLE_WAYLAND=1 # Enable wayland support for firefox
export W3M_DIR="$XDG_STATE_HOME/w3m"
export WINEPREFIX="$XDG_DATA_HOME"/wine
export XKB_DEFAULT_OPTIONS=ctrl:nocaps # Remap caps lock key
# export XKB_DEFAULT_OPTIONS=ctrl:nocaps,ctrl:swapcaps # Remap caps lock key
export _JAVA_AWT_WM_NONREPARENTING=1 # Java awt wayland hack
# export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export QT_QPA_PLATFORMTHEME=qt6ct
export GTK_THEME=Adwaita:dark

# Programming Language Hacks
## Zig
# export ZIG_GLOBAL_CACHE_DIR=$XDG_DATA_HOME/.zig-cache/
## Rust
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
## Go lang
export GOPATH=$XDG_DATA_HOME/go
export GOMODCACHE=$XDG_CACHE_HOME/go/mod

# Config files
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export ANDROID_USER_HOME="$XDG_DATA_HOME/android/"
export XDG_MENU_PREFIX=arch-

# start alias for wm
alias start-dwl='dwl-status | dwl -s dwl-startup'
alias start-gnome='XDG_SESSION_TYPE=wayland dbus-run-session gnome-session'
alias start-kde='XDG_SESSION_TYPE=wayland dbus-run-session startplasma-wayland'
alias start-river='river -log-level error 2>&1 | tee $XDG_STATE_HOME/river.log'
alias start-sway='dbus-run-session sway'

# cd alias
alias ..='cd ..;pwd'
alias ...='cd ../..;pwd'
alias ....='cd ../../..;pwd'
alias cf='cd $(fzf --walker=dir --height=30% --layout=reverse --walker-root="$HOME" --border-label="Search dirs" --border=rounded)'

# ls alias
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -lha'

# Show colors output
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias pstree='pstree -Cage'

# make utils interactive
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

# shortcut commands
alias _='sudo'
alias hx='helix'
alias ytmpv='mpv --ytdl-format="bestvideo[height<=1080][vcodec!=vp9]+bestaudio/best" --cache=yes'
alias servehugo='hugo server -D --disableFastRender --noHTTPCache --tlsAuto'
alias livereload='livereload --host localhost -p 1919'
alias zigw='zig build --watch -fincremental --prominent-compile-errors'

# some hacks
# alias gdb='gdb -n -x "$XDG_CONFIG_HOME/gdb/init"'
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
alias venv='source venv/bin/activate'
alias adb='HOME="$XDG_DATA_HOME"/android adb'

# Some useful functions
man() {
    LESS_TERMCAP_md=$'\e[01;34m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[04;31m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[45;93m' \
    LESS_TERMCAP_se=$'\e[0m' \
    command man "$@"
}

crun() {
    if [ $# -eq 0 ]; then
        echo "Usage: crun file.c [gcc options] -- [program arguments]"
        return 1
    fi
    local cfile="$1"
    shift
    if [[ ! -f "$cfile" ]]; then
        echo "Error: '$cfile' not found"
        return 1
    fi

    local exe=$(mktemp /tmp/crun_exec_XXXXXX)
    local gcc_args=()
    local run_args=()
    local parsing_gcc=true

    for arg in "$@"; do
        if $parsing_gcc && [[ "$arg" == "--" ]]; then
            parsing_gcc=false
            continue
        fi
        if $parsing_gcc; then
            gcc_args+=("$arg")
        else
            run_args+=("$arg")
        fi
    done
    gcc "$cfile" -o "$exe" "${gcc_args[@]}"
    if [ $? -ne 0 ]; then
        echo "Compilation failed"
        rm -f "$exe"
        return 1
    fi
    "$exe" "${run_args[@]}"
    rm -f "$exe" > /dev/null
}

dasm() {
    if [[ -z "$1" ]]; then
        echo "Usage: dasm <binary> [symbol]"
        return 1
    fi

    if [[ -n "$2" ]]; then
        llvm-objdump --disassemble --demangle --symbol="$2" "$1" | nvim -
    else
        llvm-objdump --disassemble --demangle "$1" | nvim -
    fi
}

get_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

set_window_title() {
    local cmd=$(basename $(echo "$BASH_COMMAND" | cut -d' ' -f1))
    printf "\033]0;%s — %s\007" "$cmd" "$TERM"
}

# Our PS1 prompt
PROMPT_COMMAND='LAST_STATUS=$?'
PROMPT_DIRTRIM=2
if [ "$(tput colors)" -ge 8 ]; then
    PS1="${COLOR_BRED}[${COLOR_BBLUE}\u${COLOR_BYELLOW}@${COLOR_BCYAN}\h${COLOR_BRED}]-[${COLOR_BGREEN}\w${COLOR_BRED}]\$(get_git_branch)\$([ \$LAST_STATUS -ne 0 ] && echo \" (\$LAST_STATUS)\") \$ ${COLOR_RESET}\[\033]0;(\w) — $TERM\007"
    trap 'set_window_title' DEBUG
else
    PS1="${COLOR_BGREEN}\w${COLOR_BRED} \$ ${COLOR_RESET}"
fi

# Use bash-completion, if available
# [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
#     . /usr/share/bash-completion/bash_completion

# Use zig bash bash_completion script if available
[[ -f ~/.local/bin/_zig.bash ]] && . ~/.local/bin/_zig.bash

[[ -f $XDG_CONFIG_HOME/ls/colors ]] && export LS_COLORS="$(cat $XDG_CONFIG_HOME/ls/colors)"
