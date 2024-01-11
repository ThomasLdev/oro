# Aliases
alias sc="symfony console"

# Symfony console autocomplete
if ! shopt -oq posix; then
  if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
