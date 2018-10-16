# Setup fzf
# ---------
if [[ ! "$PATH" == */home/zeruel/.fzf/bin* ]]; then
  export PATH="$PATH:/home/zeruel/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/zeruel/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/zeruel/.fzf/shell/key-bindings.bash"

