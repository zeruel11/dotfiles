set -x PATH $HOME/.linuxbrew/bin $PATH
set -x MANPATH $HOME/.linuxbrew/share/man $MANPATH
set -x INFOPATH $HOME/.linuxbrew/share/info $INFOPATH

alias gf="git fetch"
alias gc="git checkout"
alias gm="git commit -am"
alias gl="git log -1"
alias cpg="cpg -g"
alias mvg="mvg -g"

#setup n
set -x N_PREFIX "$HOME/n"    # equivalent of export N_PREFIX="$HOME/n";

if not contains -- $N_PREFIX/bin $PATH
  set PATH $PATH $N_PREFIX/bin
end
