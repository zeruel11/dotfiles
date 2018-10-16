# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/zeruel/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
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

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  sudo
  pj
  extract
  cp
  zsh-syntax-highlighting
  zsh-autosuggestions
  grails
  pyenv
  redis-cli
  rails
  npm
  ng
  ssh-agent
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
alias docker="docker.exe"
alias jupyter-notebook="~/.pyenv/shims/jupyter-notebook --no-browser"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# launch Windows side browser
export BROWSER=$(wslpath -w '/c/Program Files/Firefox Developer Edition/firefox.exe')

#set default user for agnostic theme
DEFAULT_USER=zeruel
PROJECT_PATHS=(~/"[iseng]" ~/Git)

# set PATH so it includes user's private exec and global composer
# export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
# export PATH="$HOME/.composer/vendor/bin:$PATH"
# PROJECT_PATHS=(/mnt/d/Datum /mnt/d/Datum/\[iseng\])

#set zsh color path
eval `dircolors /home/zeruel/dircolors.256dark`

# Change ls colours
#LS_COLORS="ow=01;36;40" && export LS_COLORS

# make cd use the ls colors
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit


unsetopt BG_NICE

# setup nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"
# setup yarn global
export PATH="$HOME/.yarn/bin:$PATH"

# setup rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# setup pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
eval "$(pyenv virtualenv-init -)"

# added by pipsi (https://github.com/mitsuhiko/pipsi)
export PATH="/home/zeruel/.local/bin:$PATH"

eval $(thefuck --alias)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# setup display
export DISPLAY=:0.0
export LIBGL_ALWAYS_INDIRECT=1

