setopt pushdminus

# --- Programms
alias e="$EDITOR"
alias E="sudo -e"
alias gui='fork .'
alias lg='lazygit'
alias ld='lazydocker'
# Programms ---

# --- network
# List all listening network ports for current user
alias ports='lsof -i -P | grep LISTEN'
# List all listening network ports system-wide (requires sudo)
alias portsall='sudo lsof -i -P | grep LISTEN'
# network ---

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
alias l='eza  --long --all --group-directories-first --icons' # 'ls -lah'
alias la='eza --long --all --group-directories-first --git'   # 'ls -Alh'
alias ll='eza --long'                                         # 'ls -lh'
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
#

#
# --- git
# see: https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/git.plugin.zsh
# --- Functions ---
# Check if main exists and use instead of master
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return
    fi
  done
  echo master
}

# use fzf prompt to switch to a branch (including remote branches)
function git_switch_branch() {
  local branch=$(git branch --all | fzf --prompt=" switch 󰄾 " --height=~50% --layout=reverse --border --exit-0)
  if [[ -n $branch ]]; then
    git switch $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
  fi
}

#  git log browser with fzf
function git_log_browse() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(green)%C(blue)%cr" "$@" |
    fzf --ansi --no-sort --layout=reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# --- Aliases ---
# (sorted alphabetically)

alias g='git'
# --- add
alias ga='git add'
# --- branch
alias gb='git branch'
alias gba='git_switch_branch'
#
alias gcl='git clone --recurse-submodules'
alias gcp='git cherry-pick'
alias gd='git diff'
# --- checkout
alias gcb='git checkout -b'
alias gcm='git checkout $(git_main_branch)'
alias gco='git checkout'
# --- commits
alias gc='git commit --verbose'
# --- fetching
alias gf='git fetch'
alias gl='git pull'
# --- merge/rebase
alias grb='git rebase'
alias grbm='git rebase $(git_main_branch)'
# --- logging
alias glg="git_log_browse"
alias glgg='git log --graph --decorate --all'
# ---- push
alias gp='git push'
alias gpf='git push --force-with-lease' # safer than --force
# --- status
alias gs='git status --short'
# --- stash
alias gsta='git stash save'
alias gstl='git stash list'
alias gstp='git stash pop'
# git ---
#

#
# --- node package managers ---------------------------------------------------
#

#
# --- npm
if command -v npm &>/dev/null; then
  command rm -f "${ZSH_CACHE_DIR:-$ZSH/cache}/npm_completion"

  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT - 1)) \
      COMP_LINE=$BUFFER \
      COMP_POINT=0 \
      npm completion -- "${words[@]}" \
      2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
fi

# Check which npm modules are outdated

# generic commands
alias npmi="npm install"             # equivalent to yarn add
alias npmid="npm install --save-dev" # equivalent to yarn add --dev
alias npmrm="npm uninstall"
alias npmr="npm run"
alias npmup="npm update"

# individual commands
alias nb="npm run build"
alias nd="npm run dev"
alias nds="npm run docs:serve"
alias nf="npm run format"
alias nln="npm run lint"
alias nt="npm test"
alias ntc="npm run typecheck"
alias ntw="npm run test:watch"

npm_toggle_install_uninstall() {
  # Look up to the previous 2 history commands
  local line
  for line in "$BUFFER" \
    "${history[$((HISTCMD - 1))]}" \
    "${history[$((HISTCMD - 2))]}"; do
    case "$line" in
    "npm uninstall"*)
      BUFFER="${line/npm uninstall/npm install}"
      ((CURSOR = CURSOR + 2)) # uninstall -> install: 2 chars removed
      ;;
    "npm install"*)
      BUFFER="${line/npm install/npm uninstall}"
      ((CURSOR = CURSOR + 2)) # install -> uninstall: 2 chars added
      ;;
    "npm un "*)
      BUFFER="${line/npm un/npm install}"
      ((CURSOR = CURSOR + 5)) # un -> install: 5 chars added
      ;;
    "npm i "*)
      BUFFER="${line/npm i/npm uninstall}"
      ((CURSOR = CURSOR + 8)) # i -> uninstall: 8 chars added
      ;;
    *) continue ;;
    esac
    return 0
  done

  BUFFER="npm install"
  CURSOR=${#BUFFER}
}

zle -N npm_toggle_install_uninstall
# npm ---
#

#
# --- yarn
# see: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/yarn/yarn.plugin.zsh
alias y="yarn"
alias ya="yarn add"
alias yad="yarn add --dev"
alias yap="yarn add --peer"
alias yb="yarn build"
alias ybd="yarn build:dev"
alias ycc="yarn cache clean"
alias yd="yarn dev"
alias yf="yarn format"
alias yln="yarn lint"
alias ylnf="yarn lint --fix"
alias yls="yarn list"
alias yrm="yarn remove"
alias ys="yarn serve"
alias ysd="yarn serve:docs"
alias yst="yarn start"
alias yt="yarn test"
alias ytc="yarn typecheck"
alias ytw="yarn test:watch"
alias yuc="yarn global upgrade && yarn cache clean"
alias yui="yarn upgrade-interactive"
alias yuil="yarn upgrade-interactive --latest"
alias yup="yarn upgrade"
# --- global
alias yga="yarn global add"
alias ygls="yarn global list"
alias ygrm="yarn global remove"
alias ygu="yarn global upgrade"
# yarn ---
#

#
# --- pnpm
# see: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/yarn/yarn.plugin.zsh
alias pn="pnpm"
alias pni="pnpm install"
alias pnid="pnpm add -D"
alias pnb="pnpm build"
alias pnbd="pnpm build:dev"
alias pncc="pnpm cache clean"
alias pnd="pnpm dev"
alias pnf="pnpm format"
alias pnln="pnpm lint"
alias pnlnf="pnpm lint --fix"
alias pns="pnpm serve"
alias pnsd="pnpm serve:docs"
alias pnst="pnpm start"
alias pnt="pnpm test"
alias pntw="pnpm test:watch"
alias pnui="pnpm update --interactive"
alias pnuil="pnpm update --interactive --latest"
# pnpm ---
#

#
# --------------------------------------------------- node package managers ---
#
