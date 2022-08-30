# ~/.bashrc: executed on non-login shell

# Only run for interactive shell
case $- in
    *i*) ;;
      *) return;;
esac

# -- History
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Set history length
HISTFILESIZE=2000
HISTSIZE=2000

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
    #xterm|xterm-color|*-256color) color_prompt=yes;;
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias grep='grep --color=auto'
    alias ls='ls --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# more ls aliases
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion

  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# --------------
# -- Shortcuts
# --------------
alias ....='cd ../../../'
alias ...='cd ../../'
alias ..1='cd ../'
alias ..2='cd ../../'
alias ..3='cd ../../../'
alias ..4='cd ../../../../'
alias ..5='cd ../../../../../'
alias ..='cd ../'
alias bc='bc -ql'
alias cd..='cd ..'
alias files-by-size='find . -printf "%s\t\t%p\n" | sort -nr'
alias gadd='git add'
alias gaddall='git add .'
alias gbr='git branch'
alias gbranch='git branch'
alias gch='git checkout'
alias gcheckout='git checkout'
alias gco='git checkout'
alias gcom='git commit'
alias gcomm='git commit'
alias gcommi='git commit'
alias gcommit='git commit'
alias gdf='git diff'
alias gdiff='git diff'
alias git-repos='cd $HOME/git-repos'
alias glog='git log'
alias glol='git log --graph --color --decorate --pretty --oneline --abbrev-commit'
alias glola='git log --graph --color --decorate --pretty --oneline --abbrev-commit --all';
alias gpul='git pull'
alias gpull='git pull'
alias gpush='git push'
alias gst='git status'
alias gsta='git status'
alias gstat='git status'
alias gstatu='git status'
alias gstatus='git status'
alias restart='sudo shutdown -r now'
alias today='date +%Y-%m-%d'
alias ymd='date +%Y-%m-%d'
alias ymdhms='date +%Y-%m-%d.%H:%M:%S'

# remove if invasive
alias d='date'
alias f='find'
alias h='history'

# Expose ~/bin
PATH="$PATH:$HOME/bin";

# Expose "go install"ed binaries
PATH="$PATH:$(go env GOPATH)/bin";


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
