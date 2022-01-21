# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/rodrigo/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf zsh-autosuggestions asdf)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

(cat ~/.cache/wal/sequences &)
eval "$(starship init zsh)"

alias myip="curl -fSsL 'https://api.ipify.org?format=json' | jq \".ip\""
alias add-ssh-horus='eval $(ssh-agent) && ssh-add $HOME/.ssh/id_rsa_casa'
alias ssh='TERM=xterm-256color ssh'
alias hossh='ssh -o ServerAliveInterval=60 -i $HOME/.ssh/horus-platform-kp.pem '
alias cowalert='xcowsay --monitor 1 comando: " $(history | tail -n1 | grep -oP '\''(?<=  )[^;]++'\'' | head -n1) " acabou '
alias restart-audio='pulseaudio -k && sudo alsa force-reload'
alias toclip='xclip -selection clipboard'
alias change-brightness='/home/rodrigo/.config/polybar/scripts/change-brightness.sh '
alias camadb='droidcam-cli adb 4747'

export EDITOR=nvim

export PATH=$PATH:/usr/local/go/bin
GOPATH=$(go env GOPATH) 

export ANDROID_HOME=$HOME/Android/Sdk

export PATH=$PATH:${GOPATH}/bin:$GOPATH
export PATH=$PATH:$HOME/.yarn/bin
export PATH=$PATH:$HOME/.npm/bin
export PATH=$PATH:$HOME/.local/share/godot
export PATH=$PATH:$HOME/.local/share/godot
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.gem/ruby/2.7.0/bin
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$HOME/.poetry/bin

eval $(ssh-agent) > /dev/null 2>&1 
ssh-add $HOME/.ssh/id_rsa_casa > /dev/null 2>&1 

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

complete -F _ssh_configfile get-ssh-hostname

# >>>> Vagrant command completion (start)
fpath=(/opt/vagrant/embedded/gems/2.2.18/gems/vagrant-2.2.18/contrib/zsh $fpath)
compinit
# <<<<  Vagrant command completion (end)

export PATH="$HOME/.poetry/bin:$PATH"
