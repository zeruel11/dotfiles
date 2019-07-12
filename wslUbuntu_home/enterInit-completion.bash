#/usr/bin/env bash

_enterInit_completions() {
	local cur prev

	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}
	prev=${COMP_WORDS[COMP_CWORD - 1]}

	if [ $COMP_CWORD -eq 1 ]; then
		COMPREPLY=($(compgen -W "start stop status" -- $cur))
	elif [ $COMP_CWORD -eq 2 ]; then
		COMPREPLY=($(compgen -W "deluge jackett sonarr radarr lidarr" -- $cur))
	fi

	return 0
} &&
	complete -F _enterInit_completions enterInit
