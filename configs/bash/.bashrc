# ~/.bashrc: executed by bash(1) for non-login shells.
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

parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
if [ "$color_prompt" = yes ]; then
 PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\] $(parse_git_branch)\[\033[00m\]\$ '
else
 PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w $(parse_git_branch)\$ '
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
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

# pywal init
(cat ~/.cache/wal/sequences &)

PATH=$PATH:$HOME/.yarn/bin
PATH=$PATH:$HOME/.npm/bin
PATH=$PATH:$HOME/.local/share/godot
PATH=$PATH:$HOME/.local/share/godot
PATH=$PATH:$HOME/.cargo/bin
PATH=$PATH:$HOME/.local/bin


alias myip='curl -fSsL 'https://api.ipify.org?format=json' | jq '\''.ip'\'''
alias add-ssh-horus='eval $(ssh-agent) && ssh-add $HOME/.ssh/id_rsa_casa'
alias ssh='TERM=xterm-256color ssh'
alias hossh='ssh -o ServerAliveInterval=60 -i $HOME/.ssh/horus-platform-kp.pem '
alias cowalert='xcowsay --monitor 1 comando: " $(history | tail -n1 | grep -oP '\''(?<=  )[^;]++'\'' | head -n1) " acabou '
alias restart-audio='pulseaudio -k && sudo alsa force-reload'
alias toclip='xclip -selection clipboard'
alias change-brightness='/home/rodrigo/.config/polybar/scripts/change-brightness.sh '

devf() {
    cd $HOME/programations/$1
}

jwt-decode() {
    echo "{$1}" | awk -F'.' '{print $2}' | base64 --decode | jq
}


get-ssh-hostname() {
    ssh -G $1 | grep hostname | head -n1 | awk {'print $2'}
}


_ssh_configfile()
{
    set -- "${words[@]}"
    while [[ $# -gt 0 ]]; do
        if [[ $1 == -F* ]]; then
            if [[ ${#1} -gt 2 ]]; then
                configfile="$(dequote "${1:2}")"
            else
                shift
                [[ $1 ]] && configfile="$(dequote "$1")"
            fi
            break
        fi
        shift
    done
}

eval "$(starship init bash)"

complete -F _ssh_configfile get-ssh-hostname

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source /home/rodrigo/programations/misc/alacritty/extra/completions/alacritty.bash

export PATH=$PATH:/usr/local/go/bin

echo ".______      ___      .__   __.      ___       ______     ___      ";
echo "|   _  \    /   \     |  \ |  |     /   \     /      |   /   \     ";
echo "|  |_)  |  /  ^  \    |   \|  |    /  ^  \   |  ,----'  /  ^  \    ";
echo "|   ___/  /  /_\  \   |  . \`  |   /  /_\  \  |  |      /  /_\  \   ";
echo "|  |     /  _____  \  |  |\   |  /  _____  \ |  \`----./  _____  \  ";
echo "| _|    /__/     \__\ |__| \__| /__/     \__\ \______/__/     \__\ ";
echo "                                                                   ";
