# ZSH custom config (without oh-my-zsh)
#
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
# changing ---

source "$Z_CONFIG_DIR/helpers.zsh"

# --- secrets
# Source secrets first since other servcies could depend on it
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
	autoload -Uz compinit && compinit
fi
# Homebrew Setup ---

# === Order #2 Plugins

_add_plugin "zsh-users/zsh-autosuggestions"
_add_plugin "zsh-users/zsh-syntax-highlighting"

# --- completions
_add_plugin "zsh-users/zsh-completions"
# ZSH https://github.com/zsh-users/zsh-completions
fpath=("$Z_CONFIG_DIR/plugins/zsh-completions/src" $fpath)
# completions ---

# --- prompt theme
# disable Apples for terminal app (ANSI characters)
eval "$(starship init zsh)"
# prompt theme ---

# --- z navigation config
autoload -U compinit && compinit
eval "$(zoxide init zsh)"
zstyle ":completion:*" menu select # prettify z menu
# z navigation config ---

# === Order #3 additional files

_source_if_exists "$Z_CONFIG_DIR/aliases.git.zsh"
_source_if_exists "$Z_CONFIG_DIR/aliases.yarn.zsh"
_source_if_exists "$Z_CONFIG_DIR/aliases.docker.zsh"
_source_if_exists "$Z_CONFIG_DIR/aliases.npm.zsh"
_source_if_exists "$Z_CONFIG_DIR/aliases.pnpm.zsh"
_source_if_exists "$Z_CONFIG_DIR/aliases.zsh"
_source_if_exists "$Z_CONFIG_DIR/exports.zsh"
_source_if_exists "$Z_CONFIG_DIR/fzf.zsh"
_source_if_exists "$Z_CONFIG_DIR/history.zsh"

# https://iterm2.com/documentation-shell-integration.html
_source_if_exists "$Z_CONFIG_DIR/.iterm2_shell_integration.zsh"

# precmd() { # --- refresh on touch
# }

# --- Docker plugin
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker#settings
# prettify docker menu
zstyle ":completion:*:*:docker:*" option-stacking yes
zstyle ":completion:*:*:docker-*:*" option-stacking yes
# Docker plugin ---
