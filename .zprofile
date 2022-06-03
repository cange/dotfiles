# Load rupa’s z if installed
if [[ -f $(brew --prefix)/etc/profile.d/z.sh ]]; then
  source $(brew --prefix)/etc/profile.d/z.sh
fi
#
# To make Homebrew’s completions available
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi
