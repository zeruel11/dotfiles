# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/zeruel/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_MODE="nerdfont-complete"

#powerlevel9k functions
function zsh_package_json () {
    local pkgjson=$(pwd)/package.json

    if [[ -f $pkgjson ]]; then
	local nodever npmver

	if [[ $POWERLEVEL9K_CUSTOM_PACKAGE_JSON_NODEVER != 'false' ]]; then
	    nodever=$(print_icon NODE_ICON)$(node --version)
	fi

	if [[ $POWERLEVEL9K_CUSTOM_PACKAGE_JSON_NPMVER != 'false' ]]; then
	    npmver=$'\uE71E '$(npm --version)
	fi

	env echo -n $nodever $npmver $pkgver
    fi
}
POWERLEVEL9K_CUSTOM_PACKAGE_JSON="zsh_package_json"
POWERLEVEL9K_CUSTOM_PACKAGE_JSON_BACKGROUND="purple"

function zsh_composer_json () {
    local comjson=$(pwd)/composer.json
    local indexp=$(pwd)/index.php
    if [[ -f $comjson ]] || [[ -f $indexp ]]; then
	local phpver

	if [[ $POWERLEVEL9K_CUSTOM_COMPOSER_JSON_PHPVER != 'false' ]]; then
	    phpver=$(php -v 2>&1 | grep -oe "^PHP\s*[0-9.]*")
	fi

	env echo -n $phpver

    fi
}
POWERLEVEL9K_CUSTOM_COMPOSER_JSON="zsh_composer_json"
POWERLEVEL9K_CUSTOM_COMPOSER_JSON_BACKGROUND="yellow"

function zsh_gem_file () {
    local gemlok=$(pwd)/Gemfile
    if [[ -f $gemlok ]]; then
	local rbver

	if [[ $POWERLEVEL9K_CUSTOM_GEM_FILE_RBVER != 'false' ]]; then
	    rbver=$(print_icon RUBY_ICON)$(rbenv version-name)
	fi

	env echo -n $rbver

    fi
}
POWERLEVEL9K_CUSTOM_GEM_FILE="zsh_gem_file"
POWERLEVEL9K_CUSTOM_GEM_FILE_BACKGROUND="red"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv root_indicator context dir pyenv custom_gem_file custom_package_json custom_composer_json vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs load history)
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true

POWERLEVEL9K_DIR_SHOW_WRITABLE=true
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_DIR_PATH_SEPARATOR_FOREGROUND="red"

POWERLEVEL9K_VCS_SHORTEN_LENGTH=4
POWERLEVEL9K_VCS_SHORTEN_MIN_LENGTH=11
POWERLEVEL9K_VCS_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_VCS_SHORTEN_DELIMITER=".."

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

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
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  extract
  zsh-syntax-highlighting
  zsh-autosuggestions
  thefuck
  z
)

#zstyle :omz:plugins:ssh-agent agent-forwarding on
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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
alias wslinit="sudo sh ~/init"
alias emacs="emacs -nw"
# alias jupyter-notebook="~/.pyenv/shims/jupyter-notebook --no-browser"

#set default user
DEFAULT_USER=zeruel

#set zsh color path
eval `dircolors $HOME/.dircolors/dircolors.256dark`

# make cd use the ls colors
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit

unsetopt BG_NICE

# paths
export PATH="$HOME/.local/bin:$PATH"

# fnm
export PATH="$HOME/.fnm:$PATH"
eval "`fnm env --multi`"

# linuxbrew
umask 002
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# thefuck
eval $(thefuck --alias)

# rbenv
eval "$(rbenv init -)"

# pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# yarn
export PATH="$HOME/.yarn/bin:$PATH"

# setup display
export DISPLAY=:0.0
export LIBGL_ALWAYS_INDIRECT=1
