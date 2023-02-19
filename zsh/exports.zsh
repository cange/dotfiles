# User configuration
export PATH=/usr/local/bin:/usr/local/sbin:/sbin/:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# One may need to manually set your language environment
export LANG=en_US.UTF-8

# Tell spaceship where to find prompt config
# https://spaceship-prompt.sh/config/intro/#changing-the-config-location
export SPACESHIP_CONFIG_FILE="$HOME/.config/zsh/prompt.zsh"

# yarn - node package manager
export PATH="`yarn global bin`:$PATH"

# To link Rubies to Homebrew's OpenSSL 1.1
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# Telling Git about your GPG key
# https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key
export GPG_TTY=$(tty)

# https://github.com/sharkdp/bat
# Theme is handled by ./zsh/aliases
export BAT_STYLE="changes"

# Environment variables set everywhere
export EDITOR="nvim"
export TERMINAL="iterm2"
export BROWSER="firefox"

# pnpm
if [[ -s "${HOME}/Library/pnpm" ]]; then
  export PNPM_HOME="${HOME}/Library/pnpm"
  export PATH="$PNPM_HOME:$PATH"
fi
# pnpm end

# bun completions
if [[ -s "${HOME}/.bun" ]]; then
  export BUN_INSTALL="${HOME}/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
  source "${HOME}/.bun/_bun"
fi
# bun end

# SSH
if [[ -n $HOME/.ssh/id_dsa ]]; then
  export SSH_KEY_PATH="~/.ssh/id_dsa"

  # add my ssh information
  ssh-add
fi
# SSH end
