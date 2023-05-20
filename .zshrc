# ZSH custom config (without oh-my-zsh)
#
# credits to:
# - https://github.com/ChristianChiarulli/Machfiles/tree/master/zsh
# - https://github.com/andrew8088/dotfiles/tree/main/zsh

# === Order is important ===

# --- config
export ZDOTDIR=$HOME/.config/zsh
export DOTFILES=$HOME/dotfiles/
# config ---

# --- helpers
function source_if_exists() {
  [[ -f "$1" ]] && source "$1"
}

function add_plugin() {
  local name=$(echo $1 | cut -d "/" -f 2)
  if [[ -d "$ZDOTDIR/plugins/$name" ]]; then
    source_if_exists "$ZDOTDIR/plugins/$name/$name.plugin.zsh" || \
    source_if_exists "$ZDOTDIR/plugins/$name/$name.zsh-theme" || \
    source_if_exists "$ZDOTDIR/plugins/$name/$name.zsh"
  else
    git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$name"
  fi
}
# helpers ---

# --- secrets
# Source secrets first since other servcies could depend on it
source_if_exists "$HOME/.config/secrets"
# secrets ---

# Order #1: Plugins
add_plugin "zsh-users/zsh-autosuggestions"
add_plugin "zsh-users/zsh-syntax-highlighting"

# --- completions
add_plugin "zsh-users/zsh-completions"
# ZSH https://github.com/zsh-users/zsh-completions
fpath+="$ZDOTDIR/plugins/zsh-completions/src"
# completions ---

# --- prompt theme
add_plugin "romkatv/powerlevel10k"
source_if_exists "$ZDOTDIR/.zshrc" # required by p10k prompt
# prompt theme ---

# --- z navigation config
add_plugin "agkozak/zsh-z"
autoload -U compinit && compinit
# prettify z menu
zstyle ":completion:*" menu select
# z navigation config ---

# Order #2: additional files
source_if_exists "/usr/share/doc/git-extras/git-extras-completion.zsh"
source_if_exists "$ZDOTDIR/aliases.git.zsh"
source_if_exists "$ZDOTDIR/aliases.yarn.zsh"
source_if_exists "$ZDOTDIR/aliases.zsh"
source_if_exists "$ZDOTDIR/exports.zsh"
source_if_exists "$ZDOTDIR/fzf.zsh"
source_if_exists "$ZDOTDIR/history.zsh"
# https://iterm2.com/documentation-shell-integration.html
source_if_exists "$ZDOTDIR/.iterm2_shell_integration.zsh"

precmd() { # --- refresh on touch
  source "$DOTFILES/zsh/aliases.zsh"
  source "$DOTFILES/zsh/aliases.git.zsh"
  source "$DOTFILES/zsh/aliases.yarn.zsh"
}

# --- Docker plugin
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker#settings
zstyle ":completion:*:*:docker:*" option-stacking yes
zstyle ":completion:*:*:docker-*:*" option-stacking yes
# Docker plugin ---

# enable asdf package managersa
# https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
source_if_exists "/usr/local/opt/asdf/libexec/asdf.sh"
