#!/bin/sh

# CLI tools
# https://github.com/sharkdp/bat
alias cat="bat --paging=never --style=changes --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo base16-256 || echo GitHub)"

# editor config
alias nvimrc='nvim ~/.config/nvim/'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Convenient helper to search history
alias h='history'
alias hg='history | grep'
alias hgi='history | grep -i'

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
alias server="sudo python -m http.server 80"

alias cr='cd ~/workspace/wlw/customer-report-frontend'
alias lyc='cd ~/workspace/wlw/lyc'
alias sf='cd ~/workspace/wlw/supplier-frontend'
alias sff='cd ~/workspace/wlw/supplier-facts-frontend'
alias sg='cd ~/workspace/wlw/wlw_styleguide'
alias statistics='cd ~/workspace/wlw/statistics'
alias user='cd ~/workspace/wlw/user'
alias work='cd ~/workspace'

# rebase from either master or main branch required
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh
alias grbm='git rebase $(git_main_branch)'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

## CPU monitoring
# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'
# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# OS
if [[ $(uname) = "Linux" ]]; then
  alias ls='ls --color=auto'
  alias vim='gvim'
  alias gui='gitg'
else
  alias ls='ls -G'
  alias vim='nvim'
  alias gui='fork'
fi
