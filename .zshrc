# ZSH custom config (without oh-my-zsh)
# inspired by https://github.com/ChristianChiarulli/Machfiles/tree/master/zsh

### Order is important
# Source secrets first since other servcies could depend on it
# Secrets token etc.
if [[ -s "${HOME}/.config/secrets" ]]; then
  source "${HOME}/.config/secrets"
else
  echo '  zshrc: no secrets file found'
fi

###
export ZDOTDIR=$HOME/.config/zsh

# Helper functions
source "$ZDOTDIR/functions.zsh"

# Order #1: Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "romkatv/powerlevel10k"

export LS_COLORS="rs=0:no=00:mi=00:mh=00:ln=01;36:or=01;31:di=01;34:ow=04;01;34:st=34:tw=04;34:pi=01;33:so=01;33:do=01;33:bd=01;33:cd=01;33:su=01;35:sg=01;35:ca=01;35:ex=01;32:"
# z navigation config
zsh_add_plugin "agkozak/zsh-z"
autoload -U compinit && compinit
# prettify z menu
zstyle ':completion:*' menu select
# z navigation config end

# Order #2: additional files
zsh_add_file "aliases.git.zsh"
zsh_add_file "aliases.yarn.zsh"
zsh_add_file "aliases.zsh"
zsh_add_file "exports.zsh"
zsh_add_file "fzf.zsh"
zsh_add_file "history.zsh"
zsh_add_file "prompt.zsh"

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

# enable asdf package managersa
# https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
. /usr/local/opt/asdf/libexec/asdf.sh

# https://iterm2.com/documentation-shell-integration.html
test -e "${ZDOTDIR}/.iterm2_shell_integration.zsh" && source "${ZDOTDIR}/.iterm2_shell_integration.zsh"
