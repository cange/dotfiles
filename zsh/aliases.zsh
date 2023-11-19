setopt pushdminus

# --- tools
alias vim='nvim'
alias gui='fork .'
# tools ---
#
# --- confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# --- handy helpers
alias q='exit'
alias k='clear'

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
alias l='eza  --long --all --icons' # 'ls -lah'
alias la='eza --long --all --icons --git' # 'ls -Alh'
alias lt='eza --long --all --icons --git --tree --level=1' # list tree
alias ll='eza --long --icons' # 'ls -lh'
alias ls='ls -G'
# lists ---
#
# --- search history
alias h='history'
alias hg='history | grep'
# search history ---
#
# ruby bundle
alias be='bundle exec'
alias bi='bundle install'
alias server="sudo python3 -m http.server 80"

# --- work
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
