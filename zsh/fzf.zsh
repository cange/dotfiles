source "$ZDOTDIR/helpers.zsh"

# see https://github.com/mrnugget/dotfiles/blob/master/zshrc#L496

source_if_exists "$(brew --prefix)/opt/fzf/shell/completion.zsh"
source_if_exists "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"

if type fzf &> /dev/null; then
  # Theme: Nightfox/Style: terafox
  # https://github.com/EdenEast/nightfox.nvim/tree/main/extra/terafox
  export FZF_DEFAULT_OPTS="--no-height --color=bg+:#293e40,gutter:-1,pointer:#e6eaea,info:#7aa4a1,hl:#ff8349,hl+:#ff8349"

  if type fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
    export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden --exclude=.git'
    export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --exclude=.git"

    if type bat &> /dev/null; then
      export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
    else
      echo "bat is not installed, skipping FZF_CTRL_T_OPTS"
    fi
  else
    echo "fd is not installed, skipping FZF_DEFAULT_COMMAND"
  fi
fi
