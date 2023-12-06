source "$Z_CONFIG_DIR/helpers.zsh"

# see https://github.com/mrnugget/dotfiles/blob/master/zshrc#L496

source_if_exists "$(brew --prefix)/opt/fzf/shell/completion.zsh"
source_if_exists "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"

if type fzf &> /dev/null; then
  # Theme: Nightfox/Style: terafox
  # https://github.com/EdenEast/nightfox.nvim/tree/main/extra/terafox
  # https://minsw.github.io/fzf-color-picker/
  export FZF_DEFAULT_OPTS='--color=fg:#e6eaea,bg:-1,hl:#d78b6c --color=fg+:#eaeeee,bg+:#293e40,hl+:#fda47f --color=info:#5a93aa,prompt:#a1cdd8,pointer:#e6eaea --color=marker:#587b7b,spinner:#1d3337,header:#5a93aa'

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
