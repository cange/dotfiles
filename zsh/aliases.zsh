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

# --- Aliases ---
# (sorted alphabetically)

alias g='git'
# --- add
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
# --- branch
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
# --- bisect
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'
#
alias gcl='git clone --recurse-submodules'
alias gclean='git clean --interactive -d'
alias gcp='git cherry-pick'
alias gd='git diff'
alias grm='git rm'
# --- checkout
alias gcb='git checkout -b'
alias gcm='git checkout $(git_main_branch)'
alias gco='git checkout'
# --- commits
alias gc='git commit --verbose'
alias gcmsg='git commit --message'
alias gcs='git commit --gpg-sign'
alias gcss='git commit --gpg-sign --signoff'
alias gcssm='git commit --gpg-sign --signoff --message'
# --- fetching
alias gf='git fetch'
alias gl='git pull --prune'
alias glr='git pull --rebase'
# --- merge/rebase
alias grb='git rebase'
alias grbm='git rebase $(git_main_branch)'
# --- logging
alias glg="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"
alias glgg='git log --graph --decorate --all'
alias glgm='glg --max-count=10'
# ---- push
alias gp='git push'
alias gpfl='git push --force-with-lease' # safer than --force
# --- status
alias gss='git status --short'
alias gst='git status'
# --- stash
alias gsta='git stash save'
alias gstl='git stash list'
alias gstp='git stash pop'
# --- switch
alias gsw='git switch'
alias gswm='git switch $(git_main_branch)'
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
alias npmb="npm run build"
alias npmd="npm run dev"
alias npmds="npm run docs:serve"
alias npmf="npm run format"
alias npmln="npm run lint"
alias npmt="npm test"
alias npmtc="npm run typecheck"
alias npmtw="npm run test:watch"

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
alias pnid="pnpm add --dev"
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
