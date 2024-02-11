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
