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

source "$ZDOTDIR/helpers.zsh"

# --- secrets
# Source secrets first since other servcies could depend on it
source_if_exists "$HOME/.config/secrets/zsh"
# secrets ---

# === Order #1

# --- Homebrew Setup
if [[ $(uname -p) == "arm" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)" # M1+ Mac
else
  eval "$(/usr/local/bin/brew shellenv)" # Intel Mac
fi

# To make Homebrew’s completions available
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if type brew &>/dev/null; then
  fpath+=("$(brew --prefix)/share/zsh/site-functions") # append completions
  autoload -Uz compinit && compinit
fi
# Homebrew Setup ---

# === Order #2 Plugins

add_plugin "zsh-users/zsh-autosuggestions"
add_plugin "zsh-users/zsh-syntax-highlighting"

# --- completions
add_plugin "zsh-users/zsh-completions"
# ZSH https://github.com/zsh-users/zsh-completions
fpath+="$ZDOTDIR/plugins/zsh-completions/src"
# completions ---

# --- prompt theme
source_if_exists "$ZDOTDIR/.zshrc" # required by p10k prompt
add_plugin "romkatv/powerlevel10k"
# prompt theme ---

# --- z navigation config
# Tracks most-used directories to make cd smarter
source_if_exists "$(brew --prefix)/etc/profile.d/z.sh" # https://formulae.brew.sh/formula/z
add_plugin "agkozak/zsh-z"
autoload -U compinit && compinit
zstyle ":completion:*" menu select # prettify z menu
# z navigation config ---

# === Order #3 additional files

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
# prettify docker menu
zstyle ":completion:*:*:docker:*" option-stacking yes
zstyle ":completion:*:*:docker-*:*" option-stacking yes
# Docker plugin ---
