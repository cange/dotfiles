#!/bin/bash
# Initialize Bash It

# Reload Library
alias reload='source ~/.bashrc'

export USR_BASH="${HOME}/.bash_it"
# Load the framework

# Load colors first so they can be use in base theme
source "${USR_BASH}/themes/colors.theme.bash"
source "${USR_BASH}/themes/base.theme.bash"

# Library
LIB="${USR_BASH}/lib/*.bash"
for config_file in $LIB
do
  source $config_file
done

# Tab Completion
COMPLETION="${USR_BASH}/completion/*.bash"
for config_file in $COMPLETION
do
  source $config_file
done

# Plugins
PLUGINS="${USR_BASH}/plugins/*.bash"
for config_file in $PLUGINS
do
  source $config_file
done

# Aliases
FUNCTIONS="${USR_BASH}/aliases/*.bash"
for config_file in $FUNCTIONS
do
  source $config_file
done

# Custom
CUSTOM="${USR_BASH}/custom/*.bash"
for config_file in $CUSTOM
do
  source $config_file
done


unset config_file
if [[ $PROMPT ]]; then
    export PS1=$PROMPT
fi

# Adding Support for other OSes
PREVIEW="less"
[ -s /usr/bin/gloobus-preview ] && PREVIEW="gloobus-preview"
[ -s /Applications/Preview.app ] && PREVIEW="/Applications/Preview.app"


#
# Custom Help

function bash-it() {
  echo "Welcome to Bash It!"
  echo
  echo "Here is a list of commands you can use to get help screens for specific pieces of Bash it:"
  echo
  echo "  rails-help                  This will list out all the aliases you can use with rails."
  echo "  git-help                    This will list out all the aliases you can use with git."
  echo "  todo-help                   This will list out all the aliases you can use with todo.txt-cli"
  echo "  aliases-help                Generic list of aliases."
  echo "  plugins-help                This will list out all the plugins and functions you can use with bash-it"
  echo
}