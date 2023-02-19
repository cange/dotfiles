setopt pushdminus
# --- tools

alias vim='nvim'
alias gui='fork'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd  ../../../..'
alias ......='cd ../../../../..'
alias -- -='cd -'

# lists
alias l='ls -lah'
alias la='ls -Alh'
alias ll='ls -lh'
alias ls='ls -G'

# Convenient helper to search history
alias h='history'
alias hg='history | grep'

# wlw/visbale docker
alias dc='time wlw-dc'
alias dce='time wlw-exec'
alias dcy='time wlw-exec yarn'
alias dcb='time wlw-exec bundle'
alias dcrs='time wlw-restart'
alias dcrb='time wlw-rebuild'
alias q='exit'
alias k='clear'

# ruby bundle
alias be='bundle exec'
alias bi='bundle install'
alias server="sudo python -m http.server 80"

# work
alias cr='cd ~/workspace/wlw/customer-report-frontend'
alias lyc='cd ~/workspace/wlw/lyc'
alias sf='cd ~/workspace/wlw/supplier-frontend'
alias sff='cd ~/workspace/wlw/supplier-facts-frontend'
alias sg='cd ~/workspace/wlw/wlw_styleguide'
alias statistics='cd ~/workspace/wlw/statistics'
alias user='cd ~/workspace/wlw/user'
alias work='cd ~/workspace'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB
## CPU monitoring
# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'
# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'
