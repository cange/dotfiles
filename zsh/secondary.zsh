# User configuration
export PATH="/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/bin:/sbin:$PATH"

# --- Homebrew - must come after general $PATH setup
export PATH="/opt/homebrew/bin:$PATH"
# Homebrew ---

# One may need to manually set your language environment
export LANG=en_US.UTF-8

# To link Rubies to Homebrew's OpenSSL 1.1
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

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

# Environment variables set everywhere
# https://manpages.debian.org/bullseye-backports/man-db/man.1.en.html#ENVIRONMENT
export EDITOR="nvim"
export VISIUAL="nvim"
export TERMINAL="wezterm"
export BROWSER="firefox-developer-edition"

# --- pnpm
if [[ -s "$HOME/Library/pnpm" ]]; then
  export PNPM_HOME="$HOME/Library/pnpm"
  export PATH="$PNPM_HOME:$PATH"
fi
# pnpm ---

# --- bun
if [[ -s "$HOME/.bun" ]]; then
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
  source "$HOME/.bun/_bun"
fi
# bun ---

# --- asdf
# enable asdf package managers
# https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit -C # `-C` skip recompiling dump file if it hasn't changed
export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY=latest_installed
# asdf ---

#
# --- fzf
# see https://github.com/mrnugget/dotfiles/blob/master/zshrc#L496
_source_if_exists "$(brew --prefix)/opt/fzf/shell/completion.zsh"
_source_if_exists "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
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
    else
      echo "bat is not installed, skipping FZF_CTRL_T_OPTS"
    fi
  else
    echo "fd is not installed, skipping FZF_DEFAULT_COMMAND"
  fi
fi
# fzf ---
#

#
# --- History Configuration - https://www.soberkoder.com/better-zsh-history/
export HISTDUP=erase             # Erase duplicates in the history file
export HISTFILE=~/.zsh_history   # path/location of the history file
export HISTSIZE=1000000000       # number of commands that are loaded into memory
export SAVEHIST=1000000000       # number of commands that are stored
export HISTTIMEFORMAT="[%F %T] " # Timestamp format for history
export HISTCONTROL=ignoreboth    # Ignore duplicates and commands starting with a space

setopt APPEND_HISTORY       # Append history to the history file
setopt INC_APPEND_HISTORY   # Immediately append to the history file, not just when the shell exits
setopt SHARE_HISTORY        # Share history across terminals
setopt EXTENDED_HISTORY     # Save timestamp of command
setopt HIST_FIND_NO_DUPS    # Do not display duplicates in the history list
setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate
# History Configuration ---
