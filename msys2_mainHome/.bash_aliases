# common alias
alias pwdw='cygpath -ml `pwd`'
alias docs='cd $HOMEDRIVE/Documents'

# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
#
# Default to human readable figures
alias df='df -h'
alias du='du -h'
#
# Misc :)
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
alias ls='ls --color=auto'
alias ll='ls -la'
alias l.='ls -d .* --color=auto'
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'

# git
alias gf='git fetch --all'
alias gs='git status'
alias ga='git add'
alias g.='git add .'
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
alias gdt='git difftool --'
alias gdg='git difftool --gui --'
alias gpu='git push --all'
alias gpt='git push -f --tags'
alias gpa='git pull --all'
alias gpd='git push --delete'

# ikti server
alias ikti.srv='ssh bambang_ebis@10.126.12.212 -i $(cygpath $USERPROFILE)/.ssh/iktisrv_rsa'
