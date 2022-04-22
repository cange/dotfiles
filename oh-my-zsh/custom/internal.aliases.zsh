#!/usr/bin/env bash

# git
alias gl="git pull -p"
alias gm="git rebase "
alias yt="yarn test"
alias ytw="yarn test:watch"
alias yb="yarn build"
alias yl="yarn lint"
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
alias rwst="bundle exec rake web_service:test:all"
alias server="sudo python -m SimpleHTTPServer 80"

alias accounts='cd ~/workspace/wlw/accounts'
alias cr='cd ~/workspace/wlw/customer_report'
alias lyc='cd ~/workspace/wlw/lyc'
alias orders='cd ~/workspace/wlw/orders'
alias products='cd ~/workspace/wlw/products'
alias sg='cd ~/workspace/wlw/wlw_styleguide'
alias statistics='cd ~/workspace/wlw/statistics'
alias user='cd ~/workspace/wlw/user'
alias wlw='cd ~/workspace/wlw/wlw'
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
