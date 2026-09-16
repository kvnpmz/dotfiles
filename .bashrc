# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n \$ '

export SUDO_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim

alias podcast='mpv --no-video'

export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$HOME/bin:$HOME/.local/bin:$DOTNET_ROOT:$HOME/.cargo/bin:/usr/lib/dotnet:$PATH"

export HISTFILE=~/.bash_history
export HISTSIZE=100000
export HISTFILESIZE=200000
shopt -s histappend

prompt_on_top() {
    if [[ "$CLEAR_TO_TOP" == 1 ]]; then
        CLEAR_TO_TOP=0
        tput clear
        tput cup 0 0
    else
        local lines=$(tput lines)
        printf '\n%.0s' $(seq 1 $((lines - 4)))
        tput cup 3 0
    fi
}

clear_to_top() {
    CLEAR_TO_TOP=1
}

alias clear='clear_to_top'
bind '"\C-l":"clear\C-m"'

PROMPT_COMMAND='history -a; history -n; prompt_on_top; if [[ "$PWD" == "$HOME"* ]]; then echo -ne "\033]0;kevin@void: ~${PWD#$HOME}\007"; else echo -ne "\033]0;kevin@void: $PWD\007"; fi'

alias ffstat='echo "=== RAM Profile Size ===" && du -sh /dev/shm/firefox-kevin && echo "=== Last Disk Sync ===" && ls -ld /home/kevin/.mozilla/firefox/*.disk'

clear_to_top

printf '\033]P7FFA500\033\\'

source "$HOME/bin/mtp"
source "$HOME/bin/mtp-off"

