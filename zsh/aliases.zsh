setopt pushdminus

# --- tools
alias vim='nvim'
alias gui='open -a fork .' # allow to run executables within fork
# tools ---
#
# --- confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# --- grep output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
# grep output ---
#
# --- cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd  ../../../..'
alias ......='cd ../../../../..'
alias -- -='cd -'
# cd ---
#
# --- lists
alias l='exa  --long --all --icons' # 'ls -lah'
alias la='exa --long --all --icons --git' # 'ls -Alh'
alias lt='exa --long --all --icons --git --tree --level=1' # list tree
alias ll='exa --long --icons' # 'ls -lh'
alias ls='ls -G'
# lists ---
#
# --- search history
alias h='history'
alias hg='history | grep'
# search history ---
#
# --- work docker
alias dc='time wlw-dc'
alias dce='time wlw-exec'
alias dcy='time wlw-exec yarn'
alias dcb='time wlw-exec bundle'
alias dcrs='time wlw-restart'
alias dcrb='time wlw-rebuild'
alias q='exit'
alias k='clear'
# work docker ---
#
# ruby bundle
alias be='bundle exec'
alias bi='bundle install'
alias server="sudo python -m http.server 80"

# --- work
alias cr='cd ~/workspace/wlw/customer-report-frontend'
alias lyc='cd ~/workspace/wlw/lyc'
alias sf='cd ~/workspace/wlw/supplier-frontend'
alias sff='cd ~/workspace/wlw/supplier-facts-frontend'
alias sg='cd ~/workspace/wlw/wlw_styleguide'
alias statistics='cd ~/workspace/wlw/statistics'
alias user='cd ~/workspace/wlw/user'
alias work='cd ~/workspace'
# work ---
#
# --- disk reader
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB
## CPU monitoring
# get top process eating memory
alias psmem='ps aux | sort -nr -k 4 | head -5'
# get top process eating cpu ##
alias pscpu='ps aux | sort -nr -k 3 | head -5'
# disk reader ---
