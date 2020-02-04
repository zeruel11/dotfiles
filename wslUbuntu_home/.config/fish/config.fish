
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

# check fish universal variable
if set -q fish_user_paths; and set -q fish_user_paths[1]
	for testxt in (cat fish_user_paths.txt)
		set tespath (string replace "~" /home/(whoami) $testxt)
		if not contains $tespath $fish_user_paths
			echo "$tespath not in path, appending..."
			set -U fish_user_paths $fish_user_paths $tespath
		end
	end
else
	echo '$fish_user_paths is empty, populating...'
	for line in (cat ~/fish_user_paths.txt); set -U fish_user_paths $fish_user_paths (string replace "~" /home/(whoami) $line); end
end
if test (count $fish_user_paths) -gt (grep "" -c ~/fish_user_paths.txt)
	set_color yellow; echo '$fish_user_paths contains more path than fish_user_paths.txt, please update or remove as necessary'
	set_color normal
end

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
