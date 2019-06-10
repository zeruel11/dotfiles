
alias gf="git fetch"
alias gc="git checkout"
alias gm="git commit -am"
alias gl="git log -1"

alias cpg="cpg -g"
alias mvg="mvg -g"

alias ll='ls -alF'

# launch Windows side browser
set -x BROWSER (wslpath -w '/c/Program Files (x86)/Vivaldi/Application/vivaldi.exe')

# dircolors
eval (dircolors -c ~/.dircolors/dircolors.256dark)

# fnm
fnm env --multi | source

# pyenv
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
status --is-interactive; and . (pyenv init -|psub)
status --is-interactive; and . (pyenv virtualenv-init -|psub)
