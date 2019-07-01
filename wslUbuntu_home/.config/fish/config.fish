alias gf="git fetch"
alias gc="git checkout"
alias gm="git commit -am"
alias gl="git log -1"

alias cpg="cpg -g"
alias mvg="mvg -g"

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias my='mycli -u root -p zeruel13'

# launch Windows side browser
set -x BROWSER (wslpath -w '/c/Program Files (x86)/Vivaldi/Application/vivaldi.exe')

# dircolors
eval (dircolors -c ~/.dircolors/dircolors.256dark)

# fnm
fnm env --multi | source

# pyenv
status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (pyenv virtualenv-init -|psub)

# rbenv
status --is-interactive; and source (rbenv init -|psub)

# goenv
status --is-interactive; and source (goenv init -|psub)
