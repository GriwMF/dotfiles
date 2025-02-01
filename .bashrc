#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u \W]\$ '

 # see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
 # for examples

 # If not running interactively, don't do anything
 case $- in
	     *i*) ;;
	           *) return;;
	   esac

	   # don't put duplicate lines or lines starting with space in the history.
	   # See bash(1) for more options
	   HISTCONTROL=ignoreboth

	   # append to the history file, don't overwrite it
	   shopt -s histappend

	   # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
	   HISTSIZE=1000
	   HISTFILESIZE=2000

	   # check the window size after each command and, if necessary,
	   # update the values of LINES and COLUMNS.
	   shopt -s checkwinsize

	   # If set, the pattern "**" used in a pathname expansion context will
	   # match all files and zero or more directories and subdirectories.
	   #shopt -s globstar

	   # make less more friendly for non-text input files, see lesspipe(1)
	   [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

	   # set variable identifying the chroot you work in (used in the prompt below)
	   if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
		       debian_chroot=$(cat /etc/debian_chroot)
	   fi

	   # set a fancy prompt (non-color, unless we know we "want" color)
	   case "$TERM" in
		       xterm-color|*-256color) color_prompt=yes;;
	       esac

	       # uncomment for a colored prompt, if the terminal has the capability; turned
	       # off by default to not distract the user: the focus in a terminal window
	       # should be on the output of commands, not on the prompt
	       #force_color_prompt=yes

	       if [ -n "$force_color_prompt" ]; then
		           if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
				           # We have color support; assume it's compliant with Ecma-48
					           # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
						           # a case would tend to support setf rather than setaf.)
							           color_prompt=yes
								       else
									               color_prompt=
										           fi
	       fi

	       if [ "$color_prompt" = yes ]; then
		           PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
		   else
			       PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
	       fi
	       unset color_prompt force_color_prompt

	       # If this is an xterm set the title to user@host:dir
	       case "$TERM" in
		       xterm*|rxvt*)
			           PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
				       ;;
			       *)
				           ;;
			   esac

# PS1='\[\e[32m\]\w\[\e[0m\]$(git branch 2>/dev/null | grep "*" | sed "s/*/ 🛠 /") \$ '
get_git_branch() {
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        case "$branch" in
            main) echo -e "\001\e[31m\002(main)\001\e[0m\002 " ;;    # Red for main
            staging) echo -e "\001\e[33m\002(staging)\001\e[0m\002 " ;; # Yellow for staging
            *) echo -e "\001\e[01;32m\002($branch)\001\e[0m\002 " ;;    # Blue for other branches
        esac
    fi
}

PS1='\[\e[01;34m\]\w\[\e[0m\] $(get_git_branch)\$ '

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# sudo subsystemctl start

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
. "$HOME/.cargo/env"
# disabled due to slow startup time https://github.com/github/gh-copilot/issues/88
# eval "$(gh copilot alias -- bash)"

# load .bash_copilot_aliases if it exists
if [ -f ~/.bash_copilot_aliases ]; then
    . ~/.bash_copilot_aliases
fi
