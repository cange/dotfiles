(($ + commands[npm])) && {
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
}

# Check which npm modules are outdated

# generic commands
alias npmi="npm install"        # equivalent to yarn add
alias npmid="npm install --dev" # equivalent to yarn add --dev
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
