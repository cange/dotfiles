# --- helpers
function _cange_source_if_exists() {
  [[ -f "$1" ]] && source "$1"
}

function _cange_add_plugin() {
  local name=$(echo $1 | cut -d "/" -f 2)
  local target="$Z_CONFIG_DIR/plugins/$name"
  if [[ -d $target ]]; then
    _cange_source_if_exists "$target/$name.plugin.zsh" || \
    _cange_source_if_exists "$target/$name.zsh-theme" || \
    _cange_source_if_exists "$target/$name.zsh"
  else
    git clone "https://github.com/$1.git" "$target"
  fi
}

# Example: "$(_cange_chalk "blue" "msg")"
function _cange_chalk() {
  local color=$1
  local text=$2

  case $color in
    blue)    printf "\033[34m%s\033[0m" "$text" ;;
    bold)    printf "\033[1m%s\033[0m" "$text" ;;
    cyan)    printf "\033[36m%s\033[0m" "$text" ;;
    green)   printf "\033[32m%s\033[0m" "$text" ;;
    magenta) printf "\033[35m%s\033[0m" "$text" ;;
    red)     printf "\033[31m%s\033[0m" "$text" ;;
    white)   printf "\033[38m%s\033[0m" "$text" ;;
    yellow)  printf "\033[33m%s\033[0m" "$text" ;;
    *)       printf "\033[30m%s\033[0m" "$text" ;;
  esac
}
# helpers ---
