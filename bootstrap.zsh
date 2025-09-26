#!/bin/zsh

# --- config ---
cd "$(dirname "$0")/.."
local dotfiles="$(pwd -P)/dotfiles"
local script_name=$(basename "$0")
local errors=()
local logs=()
local is_verbose=0
local is_uninstall=0
declare -A tool_colors

# --- helpers ---
source "${dotfiles}/zsh/helpers.zsh"

# Generate a unique color for each tool name
function define_tool_color() {
  local name=$1
  if [[ -z ${tool_colors[$name]} ]]; then
    local colors=("blue" "cyan" "green" "yellow" "magenta" "red")
    local color_index=$(((${#tool_colors[@]} % ${#colors[@]}) + 1))
    tool_colors[$name]=${colors[$color_index]}
  fi
}

# realpath polyfil for macos M1+
function realpath_polyfill() {
  local path="$1"
  local dir base
  if [[ "$path" == */* ]]; then
    dir="${path%/*}"
    base="${path##*/}"
    cd -P "$dir" >/dev/null 2>&1 || return
    path="$PWD/$base"
  fi
  echo "$path"
}
# helpers ---

# --- homebrew/brewfile ---
#
function execute_brewfile() {
  local brewfile=$1

  if [[ $is_uninstall == 1 ]]; then
    _info "Uninstall packages of $(_chalk "cyan" "$brewfile")"
  else
    _info "Install packages for $(_chalk "cyan" "$brewfile")"
  fi

  if [[ ! -f $brewfile ]]; then
    _warn "Brewfile not found at the specified path: $brewfile"
    echo ""
    return 1
  fi

  local opts=$([[ $is_verbose == 1 ]] && echo " --verbose" || echo " --quiet")
  if [[ $is_uninstall == 1 ]]; then
    cat "$brewfile" | while read line; do
      if [[ $line =~ ^(brew|cask|tap)\ * ]]; then
        local package brew_cmd
        local cmd="uninstall"

        if [[ $line == cask\ * ]]; then
          opts+=" --cask"
        elif [[ $line == tap\ * ]]; then
          cmd="untap"
        fi
        package=$(echo $line | cut -d ' ' -f 2 | cut -d "," -f 1)
        brew_cmd="brew ${cmd}${opts} ${package}"

        _log "$brew_cmd"
        $(eval echo "$brew_cmd")
      fi
    done
  else
    local brew_cmd="brew bundle${opts} --file=$brewfile"
    _log "$brew_cmd"
    $(eval echo "$brew_cmd")
  fi
  echo ""
}

function find_brewfiles() {
  if ! command -v brew >/dev/null 2>&1; then
    _warn "Homebrew is not installed. Check out https://docs.brew.sh/Installation"
    return 1
  fi

  find -H "$dotfiles" -maxdepth 2 -name 'Brewfile' | while read brewfile; do
    execute_brewfile $brewfile
  done
}

# --- Symlinks ---
#
function execute_symlink() {
  local src=$1
  local dest=$2
  local tool_name=$3
  local dest_dir=$(dirname $dest)
  define_tool_color "$tool_name"
  local color=${tool_colors[$tool_name]}

  if [[ $is_uninstall == 1 ]]; then
    if [[ -e $dest ]]; then
      command rm "$dest"
      logs+=("remove $(_chalk "$color" "$tool_name") symlink $(_chalk "cyan" "$dest") ✂︎-> ")
    else
      errors+=("$(_chalk "bold" "unlink:") No such file or directory $(_chalk "cyan" "$dest")")
    fi
  else
    if [[ ! -d "$dest_dir" ]]; then
      command mkdir -p "$dest_dir"
    fi
    command ln -nsf "$src" "$dest"
    logs+=("create $(_chalk "$color" "$tool_name") symlink $(_chalk "cyan" "$dest") -> $(_chalk "cyan" "$src")")
  fi
}

function find_symlinks() {
  find -H "$dotfiles" -maxdepth 2 -name 'links.prop' | while read file; do
    local tool_name=$(basename $(dirname "$file"))
    cat "$file" | while read line; do
      local src=$(eval echo "$line" | cut -d '=' -f 1)
      local dest=$(eval echo "$line" | cut -d '=' -f 2)
      execute_symlink "$(realpath_polyfill "$src")" "$dest" "$tool_name"
    done
  done
}

function log_summary() {
  _info "A total of $(_chalk "bold" "${#logs[@]}") symlinks have been updated:"
  for msg in "${logs[@]}"; do
    _log $msg
  done
  echo ""
  _success "Successfully completed."
  logs=() # reset
}

function error_summary() {
  _info "Errors occurred during installation:"
  for msg in "${errors[@]}"; do
    _log $msg
  done
  echo ""
  _error "Completed with $(_chalk "bold" "${#errors[@]}") errors!" >&2
  errors=() # reset
  exit 1
}

# --- main ---
#
function summary_report() {
  if [[ ${#errors[@]} -gt 0 ]]; then
    error_summary
  elif [[ ${#logs[@]} -gt 0 ]]; then
    log_summary
  fi
}

function perform_install() {
  local all_selected=1
  local brew_selected=0
  local link_selected=0

  while (($# > 0)); do
    case "$1" in
    --brew)
      brew_selected=1
      all_selected=0
      shift
      ;;
    --link)
      link_selected=1
      all_selected=0
      shift
      ;;
    --verbose)
      is_verbose=1
      shift
      ;;
    *)
      all_selected=0
      info "Unknown option: $(_chalk "yellow" $1)"
      echo ""
      help
      exit 1
      ;;
    esac
  done
  [[ $brew_selected == 1 ]] || [[ $all_selected == 1 ]] && find_brewfiles
  [[ $link_selected == 1 ]] || [[ $all_selected == 1 ]] && find_symlinks
  summary_report
}

# --- interface ---
#
function help {
  echo "$(_chalk "bold" "Usage:") $script_name <command> [options]
Handles the setup of the dotfile configuration.

$(_chalk "bold" "Commands:")
\tinstall   \tInstalls package dependencies via Homebrew
\tuninstall \tUninstalls package dependencies via Homebrew

$(_chalk "bold" "Options:")
\t--brew    \tRuns Homebrew un-/install processes
\t--link    \tRuns file symlinking processes
\t--verbose \tMake some output more verbose
\t--help    \tPrint help
"
}
# Main script logic
case "$1" in
install)
  shift
  is_uninstall=0
  perform_install "$@"
  ;;
uninstall)
  shift
  is_uninstall=1
  perform_install "$@"
  ;;
*)
  info "Unknown command: $(_chalk "yellow" $1)"
  echo ""
  help
  exit 1
  ;;
esac
