#/usr/bin/env bash

_servInit_completions() {
    local cur prev

    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD - 1]}

    if [ $COMP_CWORD -eq 1 ]; then
        COMPREPLY=($(compgen -W "start stop status" -- $cur))
    elif [ $COMP_CWORD -gt 1 ]; then
        COMPREPLY=($(compgen -W "rsync" -- $cur))
    fi

    return 0
} &&
    complete -F _servInit_completions servInit
