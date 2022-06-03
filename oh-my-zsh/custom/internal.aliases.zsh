#!/usr/bin/env bash

# CLI tools
# https://github.com/sharkdp/bat
alias cat="bat --paging=never --style=changes --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo OneHalfDark || echo OneHalfLight)"

# git
alias gl="git pull -p"
alias gm="git rebase "
alias yt="yarn test"
alias ytw="yarn test:watch"
alias yb="yarn build"
alias ybd="yarn build:dev"

# wlw/visbale docker
alias dc='time wlw-dc'
alias dce='time wlw-exec'
alias dcy='time wlw-exec yarn'
alias dcb='time wlw-exec bundle'
alias dcrs'=time wlw-restart'
alias dcrb='time wlw-rebuild'
alias q='exit'
alias k='clear'

# bundle
alias be='bundle exec'
alias bi='bundle install'
alias server="sudo python -m SimpleHTTPServer 80"

alias cr='cd ~/workspace/wlw/customer-report-frontend'
alias lyc='cd ~/workspace/wlw/lyc'
alias sf='cd ~/workspace/wlw/supplier-frontend'
alias sfe='cd ~/workspace/wlw/supplier-facts-frontend'
alias sg='cd ~/workspace/wlw/wlw_styleguide'
alias statistics='cd ~/workspace/wlw/statistics'
alias user='cd ~/workspace/wlw/user'
alias work='cd ~/workspace'

# rebase from either master or main branch required
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh
alias grbm='git rebase $(git_main_branch)'

if [ $(uname) = "Linux" ]; then
  # system
  alias vim='gvim'
  alias gitx='gitg'
else
  # mac os specifc
  alias vim='vim'
  alias gitg='fork'
fi
