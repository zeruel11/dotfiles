# common alias
alias ll='ls -ltra'
alias la='ls -la'
alias pwdw='cygpath -ml `pwd`'
alias docs='cd $HOMEDRIVE/Documents'

# git
alias gf='git fetch --all'
alias gs='git status'
alias ga='git add'
alias gb='git branch -vv'
alias gba='git branch -a'
alias gbc='git checkout -b'
alias gbd='git branch -d'
alias gc='git checkout'
alias gm='git commit -am'
alias gma='git commit --amend -m'
alias gl='git log --oneline --all --graph --decorate'
alias g1='git log -1'
alias gt='git tag'
alias gta='git tag -a'
alias gcp='git cherry-pick -e'
alias gcx='git cherry-pick -e --strategy=recursive -X theirs'
alias gd1='git diff HEAD^ HEAD'
alias gd='git diff --'
alias gpu='git push --all'
alias gpt='git push -f --tags'
alias gpa='git pull --all'
alias gpd='git push --delete'

# ikti server
alias ikti.srv='ssh bambang_ebis@10.126.12.212 -i $(cygpath $USERPROFILE)/.ssh/iktisrv_rsa'
