# User configuration
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# One may need to manually set your language environment
export LANG=en_US.UTF-8

# Tell spaceship where to find prompt config
# https://spaceship-prompt.sh/config/intro/#changing-the-config-location
export SPACESHIP_CONFIG_FILE="$HOME/.config/zsh/prompt.zsh"

# yarn - node package manager
export PATH="$PATH:`yarn global bin`"

# To link Rubies to Homebrew's OpenSSL 1.1
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# Telling Git about your GPG key
# https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key
export GPG_TTY=$(tty)

# https://github.com/sharkdp/bat
export BAT_THEME="OneHalfDark"
export BAT_STYLE="changes"

# Environment variables set everywhere
export EDITOR="nvim"
export TERMINAL="iterm2"
export BROWSER="firefox"