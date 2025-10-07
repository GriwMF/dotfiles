#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# PS1='\[\e[32m\]\w\[\e[0m\]$(git branch 2>/dev/null | grep "*" | sed "s/*/ 🛠 /") \$ '
get_git_branch() {
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        case "$branch" in
            main|master) echo -e "\001\e[31m\002($branch)\001\e[0m\002 " ;;    # Red for main
            staging) echo -e "\001\e[33m\002(staging)\001\e[0m\002 " ;; # Yellow for staging
            *) echo -e "\001\e[01;32m\002($branch)\001\e[0m\002 " ;;    # Blue for other branches
        esac
    fi
}

PS1='\[\e[01;34m\]\w\[\e[0m\] $(get_git_branch)\[\e[01;34m\]❯\[\e[0m\] '
export EDITOR=nvim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# sudo subsystemctl start

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.npm-global/bin:$PATH"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
# disabled due to slow startup time https://github.com/github/gh-copilot/issues/88
# eval "$(gh copilot alias -- bash)"

# disable Ctrl+S and Ctrl+Q
stty -ixon

# load .bash_copilot_aliases if it exists
if [ -f ~/.bash_copilot_aliases ]; then
    . ~/.bash_copilot_aliases
fi

[ -f ~/.profile ] && . ~/.profile
