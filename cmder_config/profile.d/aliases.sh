# common alias
alias ll='ls -ltra'
alias la='ls -la'
alias pwdw='cygpath -ml `pwd`'
alias docs='cd $HOMEDRIVE/Documents'

# git
alias gf='git fetch --all'
alias gs='git status'
alias gc='git checkout'
alias gb='git checkout -b'
alias gm='git commit -am'
alias gl='git log --oneline --all --graph --decorate'
alias g1='git log -1'
alias gt='git tag -a'
alias gcp='git cherry-pick -e'
alias gcx='git cherry-pick -e --strategy=recursive -X theirs'
alias gd1='git diff HEAD^ HEAD'

# ikti server
alias ikti.srv='ssh bambang_ebis@10.126.12.212 -i $(cygpath $USERPROFILE)/.ssh/iktisrv_rsa'
