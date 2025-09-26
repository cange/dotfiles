# --- helpers
function _source_if_exists() {
  [[ -r "$1" ]] && source "$1"
}

# Example: "$(_chalk "blue" "msg")"
function _chalk() {
  local color=$1
  local text=$2

  case $color in
  blue) printf "\033[34m%s\033[0m" "$text" ;;
  bold) printf "\033[1m%s\033[0m" "$text" ;;
  cyan) printf "\033[36m%s\033[0m" "$text" ;;
  green) printf "\033[32m%s\033[0m" "$text" ;;
  magenta) printf "\033[35m%s\033[0m" "$text" ;;
  red) printf "\033[31m%s\033[0m" "$text" ;;
  white) printf "\033[38m%s\033[0m" "$text" ;;
  yellow) printf "\033[33m%s\033[0m" "$text" ;;
  *) printf "\033[30m%s\033[0m" "$text" ;;
  esac
}

function _warn() {     printf "%s %s\n" "$(_chalk "yellow" "▲")" "$1" }
function _error () {   printf "%s %s\n" "$(_chalk "red"    "✕")" "$1" }
function _info() {     printf "%s %s\n" "$(_chalk "blue"   "ℹ︎")" "$1" }
function _log() {      printf "%s %s\n" "$(_chalk "bold"   "⇒")" "$1" }
function _success () { printf "%s %s\n" "$(_chalk "green"  "✓")" "$1" }

# Safely prepend to PATH only if directory exists and isn't already in PATH
function _add_to_path() {
  local dir="$1"
  [[ -d "$dir" && ":$PATH:" != *":$dir:"* ]] && export PATH="$dir:$PATH"
}

function _add_plugin() {
  local name=$(echo $1 | cut -d "/" -f 2)
  local target="$Z_CONFIG_DIR/plugins/$name"
  if [[ -d $target ]]; then
    local plugin_file
    for plugin_file in "$target/$name.plugin.zsh" "$target/$name.zsh-theme" "$target/$name.zsh"; do
      if [[ -r "$plugin_file" ]]; then
        source "$plugin_file"
        break
      fi
    done
  else
    # Validate repo format (user/repo)
    if [[ ! "$1" =~ ^[a-zA-Z0-9._-]+/[a-zA-Z0-9._-]+$ ]]; then
      _warn "Invalid repository format: $1"
      return 1
    fi

    # Clone with error handling
    if ! git clone "https://github.com/$1.git" "$target" 2>/dev/null; then
      _error "Failed to clone plugin: $1"
      return 1
    fi

    _success "Successfully cloned plugin: $1"

    # Immediately source the newly cloned plugin
    local plugin_file
    for plugin_file in "$target/$name.plugin.zsh" "$target/$name.zsh-theme" "$target/$name.zsh"; do
      if [[ -r "$plugin_file" ]]; then
        source "$plugin_file"
        break
      fi
    done
  fi
}
# helpers ---
