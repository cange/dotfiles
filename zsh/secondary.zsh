# User configuration
# Add system paths if not already present (homebrew should come first)
_add_to_path "/usr/local/bin"
_add_to_path "/usr/local/sbin"
_add_to_path "/usr/sbin"

# One may need to manually set your language environment
export LANG=en_US.UTF-8

# To link Rubies to Homebrew's OpenSSL 3 / ruby neeed to be installed/compiled with the exact version
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"

# --- Git GPG key setup
# https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key
export GPG_TTY="$(tty)"
# Git GPG key setup ---

# --- bat file previewer
if [[ -e $(which bat) ]]; then
  # https://github.com/sharkdp/bat
  export BAT_STYLE="changes"
  alias cat="bat --paging=never --style=changes --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo base16 || echo GitHub)"
fi
# bat ---

# --- bun
if [[ -d "$HOME/.bun" ]]; then
  export BUN_INSTALL="$HOME/.bun"
  _add_to_path "$BUN_INSTALL/bin"
  # Add bun completions to fpath if directory exists
  [[ -d "$HOME/.zfunc" ]] && fpath=("$HOME/.zfunc" $fpath)
fi
# --- bun

# --- asdf
# enable asdf package managers
# https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
_add_to_path "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"

# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
# Note: compinit is handled centrally in zshrc.zsh
export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY=latest_installed
# asdf ---

# --- fzf (lazy load key bindings)
# Set up fzf environment and theme immediately (lightweight)
if type fzf &>/dev/null; then
  # Theme: Nightfox/Style: terafox
  # https://github.com/EdenEast/nightfox.nvim/tree/main/extra/terafox
  # https://minsw.github.io/fzf-color-picker/
  export FZF_DEFAULT_OPTS='--color=fg:#e6eaea,bg:-1,hl:#d78b6c --color=fg+:#eaeeee,bg+:#293e40,hl+:#fda47f --color=info:#5a93aa,prompt:#a1cdd8,pointer:#e6eaea --color=marker:#587b7b,spinner:#1d3337,header:#5a93aa'

  if type fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
    export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden --exclude=.git'
    export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --exclude=.git"

    if type bat &>/dev/null; then
      export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
    fi
  fi

  # Function to properly load fzf bindings when needed
  _load_fzf_bindings() {
    # Remove this temporary function
    unfunction _load_fzf_bindings
    
    # Source the real fzf files
    local brew_prefix="$(brew --prefix)"
    _source_if_exists "$brew_prefix/opt/fzf/shell/completion.zsh"
    _source_if_exists "$brew_prefix/opt/fzf/shell/key-bindings.zsh"
    
    # Execute the widget that was originally requested
    case $KEYS in
      $'\C-t') zle fzf-file-widget ;;
      $'\C-r') zle fzf-history-widget ;;
    esac
  }
  
  # Create temporary widget and bind keys
  zle -N _load_fzf_bindings
  bindkey '^T' _load_fzf_bindings  # fzf-file-widget
  bindkey '^R' _load_fzf_bindings  # fzf-history-widget
fi
# fzf ---
#

#
# --- History Configuration - https://www.soberkoder.com/better-zsh-history/
export HISTFILE="$HOME/.zsh_history" # Path/location of the history file
export HISTSIZE=1000000000           # Number of commands loaded into memory
export SAVEHIST="$HISTSIZE"          # Number of commands stored in the history file

# Timestamp format for history (for extended_history)
export HISTTIMEFORMAT="[%F %T] "

# History Options
setopt EXTENDED_HISTORY        # Save timestamp and duration of command
setopt SHARE_HISTORY           # Share history across multiple zsh sessions
setopt APPEND_HISTORY          # Append to history file
setopt INC_APPEND_HISTORY_TIME # Add commands as they are typed, not at shell exit with timestamp
setopt HIST_EXPIRE_DUPS_FIRST  # Expire duplicate entries first
setopt HIST_IGNORE_DUPS        # Don't record if same as previous command
setopt HIST_IGNORE_ALL_DUPS    # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS       # Do not display duplicates when searching
setopt HIST_IGNORE_SPACE       # Don't record commands starting with a space
setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks before recording
setopt HIST_VERIFY             # Show command with history expansion before running it
setopt HIST_SAVE_NO_DUPS       # Don't write duplicate entries in the history file
# History Configuration ---
