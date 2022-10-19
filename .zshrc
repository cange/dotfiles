# ZSH custom config (without oh-my-zsh)
# inspired by https://github.com/ChristianChiarulli/Machfiles/tree/master/zsh

# Path to custom zsh config
export ZDOTDIR=$HOME/.config/zsh

# Useful Functions
source "$ZDOTDIR/functions.zsh"

# Normal files to source
zsh_add_file "exports.zsh"
zsh_add_file "oh-my-zsh.zsh"
zsh_add_file "prompt.zsh"
zsh_add_file 'aliases.zsh'

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# start: Spaceship prompt config
zsh_add_plugin "spaceship-prompt/spaceship-prompt"
# end: Spaceship prompt config

# start: z navigation config
zsh_add_plugin "agkozak/zsh-z"
autoload -U compinit && compinit
# prettify z menu
zstyle ':completion:*' menu select
# end: z navigation config

#
###############################################################################
#
# start: Docker plugin
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker#settings
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
# end: Docker plugin

# ZSH https://github.com/zsh-users/zsh-completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

if [[ -n $HOME/.ssh/id_dsa ]]; then
  export SSH_KEY_PATH="~/.ssh/id_dsa"

  # add my ssh information
  ssh-add
fi

# homebrew
source $(brew --prefix nvm)/nvm.sh

# node version manager
# https://github.com/nvm-sh/nvm#install--update-script
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# enable asdf package managersa
# https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
. /usr/local/opt/asdf/libexec/asdf.sh

# active wlw-devtools/ docker environment
# https://github.com/visable-dev/wlw-devtools#working-with-your-vm-through-docker
[ -s "${HOME}/.iterm2_shell_integration.zsh" ] && source "${HOME}/.iterm2_shell_integration.zsh"

# bun completions
export BUN_INSTALL="${HOME}/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"

# Secrets token etc.
[ -s "${HOME}/.config/secrets" ] && source "${HOME}/.config/secrets"

