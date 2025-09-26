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
_add_to_path "/opt/homebrew/bin"
_add_to_path "/opt/homebrew/sbin"
eval "$(/opt/homebrew/bin/brew shellenv)" # M1+ Mac

# To make Homebrew's completions available
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if type brew &>/dev/null; then
  fpath+=("$(brew --prefix)/share/zsh/site-functions") # append completions
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
  local zsh_config_mtime=$(stat -f %m "$zsh_config_dir" 2>/dev/null || echo 0)
  local compdump_mtime=$(stat -f %m "$compdump_file" 2>/dev/null || echo 0)

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

# === Order #2 - Essential Plugins

# Simple plugin loading - much cleaner!
_source_if_exists "$Z_CONFIG_DIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# True lazy loading for syntax highlighting - load on first edit
zsh-syntax-highlighting-lazy-load() {
  unset -f $0
  source "$Z_CONFIG_DIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
}
add-zsh-hook preexec zsh-syntax-highlighting-lazy-load

# --- Essential startup only
# prompt theme - needed early for prompt
eval "$(starship init zsh)"
# ---

# === Order #3 - Asynchronous initialization (Defer everything else)

# init zsh-async
_source_if_exists "$Z_CONFIG_DIR/plugins/zsh-async/async.zsh"
_add_plugin "mafredri/zsh-async"
_add_plugin "zsh-users/zsh-syntax-highlighting"

autoload -Uz async
async_init

# Create separate workers for different types of tasks
async_start_worker heavy_tools -n
async_start_worker aliases_worker -n
async_start_worker completions_worker -n

# Callback for heavy tools
async_register_callback heavy_tools load_heavy_tools
load_heavy_tools() {
  # Load tools that are expensive but not immediately needed

  # --- z navigation config (defer zoxide)
  eval "$(zoxide init zsh)"
  zstyle ":completion:*" menu select # prettify z menu
  # z navigation config ---

  # --- Angular (defer CLI completion)
  if command -v ng &>/dev/null; then
    source <(ng completion script) # CLI autocompletion.
  fi
  # Angular ---

  # Load secondary config (asdf, fzf, bun, etc.)
  _source_if_exists "$Z_CONFIG_DIR/secondary.zsh"

  # --- Docker plugin (defer docker completions)
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker#settings
  # prettify docker menu
  zstyle ":completion:*:*:docker:*" option-stacking yes
  zstyle ":completion:*:*:docker-*:*" option-stacking yes
  # Docker plugin ---
}

# Callback for aliases
async_register_callback aliases_worker load_aliases
load_aliases() {
  _source_if_exists "$Z_CONFIG_DIR/aliases.zsh"
  _source_if_exists "$Z_CONFIG_DIR/aliases.docker.zsh"
}

# Callback for additional completions
async_register_callback completions_worker load_completions
load_completions() {
  _add_plugin "zsh-users/zsh-completions"
  _add_plugin "zsh-users/zsh-autosuggestions"
  fpath=("$Z_CONFIG_DIR/plugins/zsh-completions/src" $fpath)
  # Rebuild completions cache after adding new completions
  autoload -Uz compinit && compinit -d "$ZSH_COMPDUMP"
}

# Start async jobs
async_job heavy_tools
async_job aliases_worker
async_job completions_worker

# --- ssh (keep synchronous as it may be needed immediately)
if [[ -f "$HOME/.ssh/id_ed25519" ]]; then
  export SSH_KEY_PATH="~/.ssh/id_ed25519"
  # add my ssh information
  ssh-add &>/dev/null
fi
# ssh ---

# =============================================================================
# profiling results - needs to be at end of file
# zprof
