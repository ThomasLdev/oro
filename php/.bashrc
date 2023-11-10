# Aliases
alias sc="symfony console"
alias exd="mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini.dis /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini ; echo xdebug enabled"
alias dxd="mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini.dis ; echo xdebug disabled"

# Symfony console autocomplete
if ! shopt -oq posix; then
  if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

eval "$(/app/bin/console completion bash)"
