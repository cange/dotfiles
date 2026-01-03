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

# --- Local binaries (cursor-agent, etc.)
_add_to_path "$HOME/.local/bin"

# To make Homebrew's completions available
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
# Note: brew shellenv is slow (~100-300ms), so we manually set the essentials
_setup_homebrew() {
  local homebrew_root=0

  if [[ $(uname -s) == 'Darwin' ]]; then
    homebrew_root='/opt/homebrew'
  elif [[ $(uname -s) == 'Linux' ]]; then
    homebrew_root='/home/linuxbrew/.linuxbrew'
  fi

  if [[ -d $homebrew_root ]]; then
    # --- Homebrew Setup (ARM/M1+ only)
    # Add Homebrew paths first (needed for macOS, no-op on Linux if paths don't exist)
    _add_to_path "$homebrew_root/bin"
    _add_to_path "$homebrew_root/sbin"

    export HOMEBREW_PREFIX="$homebrew_root"
    export HOMEBREW_CELLAR="$homebrew_root/Cellar"
    export HOMEBREW_REPOSITORY="$homebrew_root"
    # HOMEBREW_SHELLENV_PREFIX is set for compatibility
    export HOMEBREW_SHELLENV_PREFIX="$homebrew_root"

    fpath+=("$homebrew_root/share/zsh/site-functions")

    eval "$($homebrew_root/bin/brew shellenv)"
  fi
}
_setup_homebrew
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
  _source_if_exists "$Z_CONFIG_DIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec zsh-syntax-highlighting-lazy-load

# --- Essential startup only
# prompt theme - needed early for prompt
eval "$(starship init zsh)"
# ---

# === Order #3 - Critical tools (needed immediately)

# --- mise - enable package managers (must load before aliases/commands)
# https://mise.jdx.dev/
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi
# mise ---

# --- pnpm
export PNPM_HOME="$HOME/Library/pnpm"
_add_to_path "$PNPM_HOME"
# pnpm ---

# --- z navigation config (needed by cd alias)
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi
# z navigation config ---

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

# === Order #6 - Load secondary configuration synchronously

# Load secondary.zsh - contains:
# - fzf setup with key bindings (CTRL+R, CTRL+T)
# - bat configuration
# - bun setup
# - history configuration
# Note: mise is loaded above since it needs to be in PATH before secondary runs
_source_if_exists "$Z_CONFIG_DIR/secondary.zsh"

# === Order #7 - Asynchronous initialization (Defer heavy tools)

# Load heavy tools in background
{
  # Angular CLI completions (slow)
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

# Added by Antigravity
export PATH="/Users/Angermann/.antigravity/antigravity/bin:$PATH"
