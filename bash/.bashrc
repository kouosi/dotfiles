[[ $- != *i* ]] && return # If not interactive do nothing

set -o vi

### Env vars
## Default apps
export BROWSER=firefox
export EDITOR=nvim
export TERMINAL=footclient
export MANPAGER='nvim +Man!'

## XDG base DIRs
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

## PATH For local binary
export PATH=$PATH:$HOME/.local/bin:$XDG_DATA_HOME/npm/bin:$HOME/Downloads/ResearchProject/plecs:$HOME/local/share/npm/bin/

## Bash History control
export HISTCONTROL=ignorespace:ignoredups:erasedups
export HISTFILE="$XDG_STATE_HOME"/bash/history
export HISTFILESIZE=800000 # in lines
export HISTSIZE=8000
export HISTTIMEFORMAT="%F %T "

## Some hacks
export GPG_TTY=$(tty) # Use current tty as gpg tty
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export LESSHISTFILE=-  # Do not store .lessist file
export MOZ_ENABLE_WAYLAND=1 # Enable wayland support for firefox
export W3M_DIR="$XDG_STATE_HOME/w3m"
export PLATFORMIO_CORE_DIR="$XDG_DATA_HOME"/platformio
export WINEPREFIX="$XDG_DATA_HOME"/wine
export XKB_DEFAULT_OPTIONS=ctrl:nocaps # Remap caps lock key
# export XKB_DEFAULT_OPTIONS=ctrl:nocaps,ctrl:swapcaps # Remap caps lock key
export _JAVA_AWT_WM_NONREPARENTING=1 # Java awt wayland hack
# export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export QT_QPA_PLATFORMTHEME=qt6ct
export GTK_THEME=Adwaita:dark
export PF_INFO="ascii os kernel uptime pkgs shell editor wm"

## Zig Lang
export ZVM_PATH=/usr/zvm
export PATH=$PATH:$ZVM_PATH/bin:$ZVM_PATH/self
# export ZIG_GLOBAL_CACHE_DIR=$XDG_DATA_HOME/.zig-cache/

## Rust
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo

## Go lang
export GOPATH=$XDG_DATA_HOME/go
export GOMODCACHE=$XDG_CACHE_HOME/go/mod

## Python
export PYTHON_HISTORY=$XDG_STATE_HOME/python_history
export PYTHONPYCACHEPREFIX=$XDG_CACHE_HOME/python
export PYTHONUSERBASE=$XDG_DATA_HOME/python

## Others
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android
export ANDROID_HOME="$XDG_DATA_HOME"/android/sdk
export XDG_MENU_PREFIX=arch-

### Alias
## wm start alias
alias start-dwl='dwl-status | dwl -s dwl-startup'
alias start-gnome='XDG_SESSION_TYPE=wayland dbus-run-session gnome-session'
alias start-kde='XDG_SESSION_TYPE=wayland dbus-run-session startplasma-wayland'
alias start-river='river -log-level error 2>&1 | tee $XDG_STATE_HOME/river.log'
alias start-sway='dbus-run-session sway'

## cd alias
alias ..='cd ..;pwd'
alias ...='cd ../..;pwd'
alias ....='cd ../../..;pwd'
alias cf='cd $(fzf --walker=dir --height=30% --layout=reverse --walker-root="$HOME" \
    --border-label="Search dirs" --border=rounded)'

## ls alias
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -Alha'

## Show colors output
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias pstree='pstree -Cage'

## make utils interactive
alias cp='cp -iv'
alias mv='mv -iv'
alias remove='/bin/rm -iv'
alias rm='trash-put -iv'

## shortcut commands
alias hx='helix'
alias mpv-yt='mpv --ytdl-format="bestvideo[height<=1080][vcodec!=vp9]+bestaudio/best" --cache=yes'
alias servehugo='hugo server -D --disableFastRender --noHTTPCache --tlsAuto'
alias livereload='livereload --host localhost -p 1919'
alias zigw='zig build --watch -fincremental --prominent-compile-errors'

## Others
# alias gdb='gdb -n -x "$XDG_CONFIG_HOME/gdb/init"'
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
alias venv='source venv/bin/activate'
alias adb='HOME="$XDG_DATA_HOME"/android adb'

### Prompt
## Functions
prompt_get_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

prompt_set_window_title() {
    local cmd=$(basename $(echo "$BASH_COMMAND" | cut -d' ' -f1))
    printf "\033]0;%s — %s\007" "$cmd" "$TERM"
}

## Colors & Colors with Bold
C_BLACK='\[\e[0;30m\]'  CB_BLACK='\[\e[1;30m\]'
C_RED='\[\e[0;31m\]'    CB_RED='\[\e[1;31m\]'
C_GREEN='\[\e[0;32m\]'  CB_GREEN='\[\e[1;32m\]'
C_YELLOW='\[\e[0;33m\]' CB_YELLOW='\[\e[1;33m\]'
C_BLUE='\[\e[0;34m\]'   CB_BLUE='\[\e[1;34m\]'
C_PURPLE='\[\e[0;35m\]' CB_PURPLE='\[\e[1;35m\]'
C_CYAN='\[\e[0;36m\]'   CB_CYAN='\[\e[1;36m\]'
C_WHITE='\[\e[0;37m\]'  CB_WHITE='\[\e[1;37m\]'
C_RESET='\[\e[0m\]'

PROMPT_COMMAND='LAST_STATUS=$?'
PROMPT_DIRTRIM=2

if [ "$(tput colors)" -ge 8 ]; then
    PS1="${CB_RED}[${CB_BLUE}\u${CB_YELLOW}@${CB_CYAN}\h${CB_RED}]-[${CB_GREEN}\w${CB_RED}]"
    PS1+="\$(prompt_get_git_branch)\$([ \$LAST_STATUS -ne 0 ] && echo \" (\$LAST_STATUS)\") \$ "
    PS1+="${C_RESET}\[\033]0;(\w) — $TERM\007"
    trap 'prompt_set_window_title' DEBUG
else
    PS1="[\u@\h]-[\w] \$ "
fi

## unset colors as we don't want them
unset -v C_BLACK CB_BLACK C_RED CB_RED C_GREEN CB_GREEN C_YELLOW CB_YELLOW \
    C_BLUE CB_BLUE C_PURPLE CB_PURPLE C_CYAN CB_CYAN  C_WHITE CB_WHITE C_RESET

### Others
## If LS colors available use them
[[ -f $XDG_CONFIG_HOME/ls/colors ]] && export LS_COLORS="$(cat $XDG_CONFIG_HOME/ls/colors)"

## Use bash-completion, if available
# [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
#     . /usr/share/bash-completion/bash_completion

## Use zig bash-completion, if available
[[ -f ~/.local/bin/_zig.bash ]] && . ~/.local/bin/_zig.bash

[[ -f $XDG_CONFIG_HOME/ls/colors ]] && export LS_COLORS="$(cat $XDG_CONFIG_HOME/ls/colors)"
