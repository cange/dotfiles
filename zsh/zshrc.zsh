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
export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump-${ZSH_VERSION}"
mkdir -p "${ZSH_COMPDUMP%/*}"
# caching ---

source "$Z_CONFIG_DIR/helpers.zsh"

# --- secrets
# Source secrets first since other services could depend on it
_source_if_exists "$HOME/.config/secrets/zsh"
# secrets ---

# === Order #1 - Critical Path Setup

# --- Homebrew Setup (ARM/M1+ only)
# Add Homebrew paths first (needed for macOS, no-op on Linux if paths don't exist)
_add_to_path "/opt/homebrew/bin"
_add_to_path "/opt/homebrew/sbin"

# To make Homebrew's completions available
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
# Note: brew shellenv is slow (~100-300ms), so we manually set the essentials
if [[ -d "/opt/homebrew" ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
  export HOMEBREW_REPOSITORY="/opt/homebrew"
  fpath+=("/opt/homebrew/share/zsh/site-functions")
  # HOMEBREW_SHELLENV_PREFIX is set for compatibility
  export HOMEBREW_SHELLENV_PREFIX="/opt/homebrew"
fi
# Homebrew Setup ---

# Function to check if zsh completion cache needs regeneration
# Compares modification times using stat instead of slow find operation
_needs_completion_rebuild() {
  local zsh_config_dir="$HOME/.config/zsh"
  local compdump_file="$1"

  # If compdump doesn't exist, we need to rebuild
  [[ ! -f "$compdump_file" ]] && return 0

  # Get modification times (seconds since epoch)
  if [[ $(uname -s) == 'Linux' ]]; then
    local zsh_config_mtime=$(stat -c %Y "$zsh_config_dir" 2>/dev/null || echo 0)
    local compdump_mtime=$(stat -c %Y "$compdump_file" 2>/dev/null || echo 0)
  else # MacOS
    local zsh_config_mtime=$(stat -f %m "$zsh_config_dir" 2>/dev/null || echo 0)
    local compdump_mtime=$(stat -f %m "$compdump_file" 2>/dev/null || echo 0)
  fi
  # Return 0 (true) if config is newer than cache, 1 (false) otherwise
  [[ $zsh_config_mtime -gt $compdump_mtime ]]
}

# --- Essential completions setup (consolidate all compinit calls)
# Check if we need to regenerate the completion cache
if _needs_completion_rebuild "$ZSH_COMPDUMP"; then
  autoload -Uz compinit && compinit -d "$ZSH_COMPDUMP"
else
  autoload -Uz compinit && compinit -C -d "$ZSH_COMPDUMP"
fi
# Essential completions setup ---

# === Order #2 - Essential Plugins & Prompt

# Simple plugin loading - much cleaner!
_source_if_exists "$Z_CONFIG_DIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# True lazy loading for syntax highlighting - load on first edit
zsh-syntax-highlighting-lazy-load() {
  unset -f $0
  source "$Z_CONFIG_DIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec zsh-syntax-highlighting-lazy-load

# --- Essential startup only
# prompt theme - needed early for prompt
eval "$(starship init zsh)"
# ---

# === Order #3 - Critical tools (needed immediately)

# --- asdf - enable package managers (must load before aliases/commands)
# https://asdf-vm.com/guide/getting-started.html
_add_to_path "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY=latest_installed
# asdf ---

# --- mise - enable package managers (must load before aliases/commands)
# https://mise.run/zsh
if command -v mise &> /dev/null; then
  eval "$($HOME/.local/bin/mise activate zsh)"
fi
# mise ---

# --- z navigation config (needed by cd alias)
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi
# z navigation config ---

# --- fzf setup (needed for key bindings CTRL+R, CTRL+T)
if command -v fzf &>/dev/null; then
  # Theme: Nightfox/Style: terafox
  export FZF_DEFAULT_OPTS='--color=fg:#e6eaea,bg:-1,hl:#d78b6c --color=fg+:#eaeeee,bg+:#293e40,hl+:#fda47f --color=info:#5a93aa,prompt:#a1cdd8,pointer:#e6eaea --color=marker:#587b7b,spinner:#1d3337,header:#5a93aa'

  if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
    export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden --exclude=.git'
    export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --exclude=.git"

    if command -v bat &>/dev/null; then
      export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
    fi
  fi

  # key-bindings for CTRL+R and CTRL+T (avoid slow brew --prefix)
  local fzf_share="/usr/share/fzf" # Linux default
  if [[ $(uname -s) == 'Darwin' ]]; then
    fzf_share="/opt/homebrew/opt/fzf/shell" # MacOS - use hardcoded path to avoid brew --prefix
  fi

  _source_if_exists "$fzf_share/completion.zsh"
  _source_if_exists "$fzf_share/key-bindings.zsh"
fi
# fzf setup ---

# === Order #4 - Load aliases immediately (needed for user interaction)
_source_if_exists "$Z_CONFIG_DIR/aliases.zsh"
_source_if_exists "$Z_CONFIG_DIR/aliases.docker.zsh"

# === Order #5 - Immediate setup (needed for basic functionality)

# --- ssh (keep synchronous as it may be needed immediately)
if [[ -f "$HOME/.ssh/id_ed25519" ]]; then
  export SSH_KEY_PATH="~/.ssh/id_ed25519"
  # add my ssh information
  ssh-add &>/dev/null
fi
# ssh ---

# --- Flutter
# https://docs.flutter.dev/install/manual
_add_to_path "$HOME/.config/flutter/bin"
# Flutter ---

# === Order #6 - Asynchronous initialization (Defer non-critical secondary.zsh parts)

# Defer loading of secondary.zsh - contains operations that can wait:
# - bat configuration
# - bun setup
# - history configuration
# Note: asdf/mise/fzf are loaded synchronously above since they're critical for immediate use
{
  _source_if_exists "$Z_CONFIG_DIR/secondary.zsh"
  
  # After secondary loads, set up heavy tools
  if command -v ng &>/dev/null; then
    source <(ng completion script)
  fi
  
  # Docker completion styles
  zstyle ":completion:*:*:docker:*" option-stacking yes
  zstyle ":completion:*:*:docker-*:*" option-stacking yes
} &!

# =============================================================================
# profiling results - needs to be at end of file
# zprof
