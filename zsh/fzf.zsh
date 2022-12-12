# see https://github.com/mrnugget/dotfiles/blob/master/zshrc#L496
set_fzf_default_opts() {
  if [[ $KITTY_COLORS == "light" ]]; then
    export FZF_DEFAULT_OPTS=''
    # --color=bg+:#DEECF9,bg:#FFFFFF,spinner:#3f5fff,hl:#586e75
    # --color=fg:#839496,header:#586e75,info:#cb4b16,pointer:#3f5fff
    # --color=marker:#3f5fff,fg+:#839496,prompt:#3f5fff,hl+:#3f5fff'
  else
    export FZF_DEFAULT_OPTS=''
  fi
}

if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

if type fzf &> /dev/null && type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!vendor/*"'
  export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!vendor/*"'
  # export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
  set_fzf_default_opts
fi
