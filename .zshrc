export ZSH=$HOME/.oh-my-zsh

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="cange"
echo "Now using zsh theme: \"$ZSH_THEME\""

# Load RVM, if you are using it (RubyVersionManager)
if [[ -s $HOME/.rvm/scripts/rvm ]]; then
  source $HOME/.rvm/scripts/rvm
  # Add RVM to PATH for scripting Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
  PATH=$PATH:$HOME/.rvm/bin
fi
## Path to your oh-my-zsh configuration.
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew git git-extra git-flow history node npm rvm)

bindkey '^r' history-incremental-pattern-search-backward
bindkey '^f' history-incremental-pattern-search-forward

source $ZSH/oh-my-zsh.sh

# Load NVM, if you are using it (NodeVersionManager)
if [[ -s $HOME/.nvm/nvm.sh ]]; then
  source $HOME/.nvm/nvm.sh
  source $(brew --prefix nvm)/nvm.sh
  export NVM_DIR=~/.nvm
  nvm use default
fi
source $(brew --prefix nvm)/nvm.sh


# Add rvm gems and nginx to the path
#export PATH=$PATH:/var/lib/gems/1.8/bin
#export PATH=$PATH:~/.gem/ruby/1.8/bin:/opt/nginx/sbin
# required by homebrew
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# add my ssh information
ssh-add

# Set the path nginx
#export NGINX_PATH='/opt/nginx'
sleep 1
clear
