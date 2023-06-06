# User configuration
export PATH="/usr/local/bin:/usr/local/sbin:/usr/sbin:/sbin/:$PATH"

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
export EDITOR="nvim"
export TERMINAL="iterm2"
export BROWSER="firefox"

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

# --- ssh
if [[ -n "$HOME/.ssh/id_dsa" ]]; then
  export SSH_KEY_PATH="~/.ssh/id_dsa"

  # add my ssh information
  ssh-add
fi
# ssh ---

# --- asdf
# enable asdf package managers
# https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
if [[ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]]; then
  source "$(brew --prefix asdf)/libexec/asdf.sh"
  # append completions
  fpath=("$ASDF_DIR/completions" $fpath)
  # reinitialise completions with ZSH's compinit
  autoload -Uz compinit && compinit
fi
# asdf ---

# --- yarn
# https://classic.yarnpkg.com/lang/en/docs/cli/global/
if [[ -f "$HOME/.asdf/shims/npm" ]]; then
  # echo "----$(yarn global bin)"
  export PATH="$(yarn global bin):$PATH"
else
  print "yarn not found"
fi
# yarn ---
