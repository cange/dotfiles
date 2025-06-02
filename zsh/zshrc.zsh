# Enable profiling - needs to be at start of file
# zmodload zsh/zprof

# =============================================================================
# ZSH custom config (without oh-my-zsh)
# credits to:
# - https://github.com/ChristianChiarulli/Machfiles/tree/master/zsh
# - https://github.com/andrew8088/dotfiles/tree/main/zsh

# === Order is important ===

# --- config
export ZDOTDIR=$HOME/
export Z_CONFIG_DIR="$HOME/.config/zsh" # non-standard variable
export DOTFILES=$HOME/dotfiles/
# config ---

# --- caching
export ZSH_COMPDUMP="$HOME/.cache"
mkdir -p $ZSH_COMPDUMP
# caching ---

source "$Z_CONFIG_DIR/helpers.zsh"

# --- secrets
# Source secrets first since other services could depend on it
_source_if_exists "$HOME/.config/secrets/zsh"
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
  autoload -Uz compinit && compinit -C                 # `-C` skip recompiling dump file if it hasn't changed
fi
# Homebrew Setup ---

# === Order #2 Plugins

# Lazy load plugins
autoload -Uz add-zsh-hook

# Load zsh-autosuggestions only when typing
add-zsh-hook precmd zsh-autosuggestions-load
zsh-autosuggestions-load() {
  source "$Z_CONFIG_DIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
}

# Load zsh-syntax-highlighting only when typing
add-zsh-hook precmd zsh-syntax-highlighting-load
zsh-syntax-highlighting-load() {
  source "$Z_CONFIG_DIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
}

# --- ssh
if [[ -n "$HOME/.ssh/id_dsa" ]]; then
  export SSH_KEY_PATH="~/.ssh/id_dsa"

  # add my ssh information
  ssh-add
fi
# ssh ---
#
_source_if_exists "$Z_CONFIG_DIR/aliases.docker.zsh"

# --- prompt theme
# disable Apples for terminal app (ANSI characters)
eval "$(starship init zsh)"
# prompt theme ---

# === Order #3 Asynchronous initialization

# init zsh-async
_source_if_exists "$Z_CONFIG_DIR/plugins/zsh-async/async.zsh"
_add_plugin "mafredri/zsh-async"

autoload -Uz async
async_init
async_start_worker init_worker -n

async_register_callback init_worker init_plugins
# Load non-critical plugins and configurations asynchronously
init_plugins() {
  _add_plugin "zsh-users/zsh-completions"
  fpath=("$Z_CONFIG_DIR/plugins/zsh-completions/src" $fpath)

  # --- z navigation config
  eval "$(zoxide init zsh)"
  zstyle ":completion:*" menu select # prettify z menu
  # z navigation config ---

  _source_if_exists "$Z_CONFIG_DIR/aliases.zsh"
  _source_if_exists "$Z_CONFIG_DIR/secondary.zsh"

  # --- Docker plugin
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker#settings
  # prettify docker menu
  zstyle ":completion:*:*:docker:*" option-stacking yes
  zstyle ":completion:*:*:docker-*:*" option-stacking yes
  # Docker plugin ---
}

async_job init_worker
# Order #3 Asynchronous initialization ===

# precmd() { # --- refresh on touch
# }
#

# =============================================================================
# profiling results - needs to be at end of file
# zprof
