setopt pushdminus

# --- tools
alias vim='nvim'
alias gui='fork .'
alias lg='lazygit'
alias ld='lazydocker'
# tools ---

#--- nvim switchers
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"

function nvims() {
  items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config 󰄾" --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}
# nvim switchers ---
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
alias cd=z # use zoxide
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd  ../../../..'
alias ......='cd ../../../../..'
alias -- -='cd -'
# cd ---
#
# --- lists
alias l='eza  --long --all --icons'                        # 'ls -lah'
alias la='eza --long --all --icons --git'                  # 'ls -Alh'
alias lt='eza --long --all --icons --git --tree --level=1' # list tree
alias ll='eza --long --icons'                              # 'ls -lh'
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
