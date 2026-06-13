[[ $- != *i* ]] && return # If not interactive do nothing

set -o vi

### Alias
## start WM
alias start-dwl='dwl-status | dwl -s dwl-startup'
alias start-gnome='XDG_SESSION_TYPE=wayland dbus-run-session gnome-session'
alias start-kde='XDG_SESSION_TYPE=wayland dbus-run-session startplasma-wayland'
alias start-river='river -log-level error 2>&1 | tee "$XDG_STATE_HOME"/river.log'
alias start-sway='dbus-run-session sway'

## cd
alias ..='cd ..;pwd'
alias ...='cd ../..;pwd'
alias ....='cd ../../..;pwd'
alias cf='cd $(fzf --walker=dir --height=30% --layout=reverse \
	--walker-root="$HOME" --border-label="Search dirs" --border=rounded)'

## Color output
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias pstree='pstree -Cage'
alias ls='ls --color=auto'

## ls
alias la='ls -A'
alias ll='ls -Alh'

## interactive
alias cp='cp -iv'
alias mv='mv -iv'
alias remove='/bin/rm -iv'
alias rm='trash-put -iv'

## shortcut commands
alias mpv-yt='mpv --cache=yes \
    --ytdl-format="bestvideo[height<=1080][vcodec!=vp9]+bestaudio/best"'
alias servehugo='hugo server -D --disableFastRender --noHTTPCache'
alias livereload='livereload --host localhost -p 1919'
alias zigw='zig build --watch -fincremental --prominent-compile-errors'
alias nmake='make -j$(nproc)'
alias venv='source venv/bin/activate'

## Others
# alias gdb='gdb -n -x "$XDG_CONFIG_HOME"/gdb/init'
alias wget='wget --hsts-file="$XDG_DATA_HOME"/wget-hsts'
alias adb='HOME="$XDG_DATA_HOME"/android adb'

### Prompt
## Colors
C_BLACK='\[\e[0;30m\]'	CB_BLACK='\[\e[1;30m\]'
C_RED='\[\e[0;31m\]'	CB_RED='\[\e[1;31m\]'
C_GREEN='\[\e[0;32m\]'	CB_GREEN='\[\e[1;32m\]'
C_YELLOW='\[\e[0;33m\]'	CB_YELLOW='\[\e[1;33m\]'
C_BLUE='\[\e[0;34m\]'	CB_BLUE='\[\e[1;34m\]'
C_PURPLE='\[\e[0;35m\]'	CB_PURPLE='\[\e[1;35m\]'
C_CYAN='\[\e[0;36m\]'	CB_CYAN='\[\e[1;36m\]'
C_WHITE='\[\e[0;37m\]'	CB_WHITE='\[\e[1;37m\]'
C_RESET='\[\e[0m\]'

## Functions
__prompt_get_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

__prompt_set_window_title() {
	local CMD=$(basename $(echo "$BASH_COMMAND" | cut -d' ' -f1))
	printf "\033]0;%s — %s\007" "$CMD" "$TERM"
}

## Prompt
PROMPT_COMMAND='LAST_STATUS=$?'
PROMPT_DIRTRIM=2

if [ "$(tput colors)" -ge 8 ]; then
	PS1="${CB_RED}[${CB_BLUE}\u${CB_YELLOW}@${CB_CYAN}\h${CB_RED}]-[${CB_GREEN}\w${CB_RED}]"
	PS1+="\$(__prompt_get_git_branch)\$([ \$LAST_STATUS -ne 0 ] && echo \" (\$LAST_STATUS)\") \$ "
	PS1+="${C_RESET}\[\033]0;(\w) — $TERM\007"
	trap '__prompt_set_window_title' DEBUG
else
	PS1="[\u@\h]-[\w] \$ "
fi

## Unset Colors
unset -v C_BLACK CB_BLACK C_RED CB_RED C_GREEN CB_GREEN C_YELLOW CB_YELLOW \
	C_BLUE CB_BLUE C_PURPLE CB_PURPLE C_CYAN CB_CYAN C_WHITE CB_WHITE C_RESET

### Others
[[ -f $XDG_CONFIG_HOME/ls/colors ]] &&
	export LS_COLORS="$(cat $XDG_CONFIG_HOME/ls/colors)"

## Use bash-completion, if available
# [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
# 	. /usr/share/bash-completion/bash_completion

## Use zig bash-completion, if available
[[ -f ~/.local/bin/_zig.bash ]] && . ~/.local/bin/_zig.bash
