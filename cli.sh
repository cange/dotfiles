#!/bin/bash
#
# This CLI automates un/-linking of all required dotfile sources.

# --- config ---
dotfiles_dir="$HOME/dotfiles/"
is_uninstall=false
errors=()

# --- locations ---
config_includes=(nvim snippets zsh)
config_target_dir="$HOME/.config/"
root_includes=(.ackrc .gitconfig .tool-versions .zshrc .zprofile)
root_target_dir="$HOME/"

# --- helpers ---
function chalk() {
  local color=$1
  local text=$2

  case $color in
  red) printf "\033[31m%s\033[0m" "$text" ;;
  green) printf "\033[32m%s\033[0m" "$text" ;;
  yellow) printf "\033[33m%s\033[0m" "$text" ;;
  white) printf "\033[1;38m%s\033[0m" "$text" ;;
  *) printf "\033[30m%s\033[0m" "$text" ;;
  esac
}

function log() {
  printf "    → %s\n" "$1"
}

function toggle_link() {
  local target_dir=$1
  local filename=$2
  local file=$3
  local target_path=$target_dir$filename
  if [[ $is_uninstall == true ]]; then
    if [[ -e $target_path ]]; then
      rm "$target_path"
      log "unlink -x $(chalk "white" "$filename")"
    else
      errors+=("unlink: No such file or directory $(chalk "white" "$target_path")")
    fi
  else
    if [[ -e $target_dir ]]; then
      ln -nsf "$file" "$target_path"
      log "symlink -> $(chalk "white" "$filename")"
    else
      errors+=("symlink: No such file or directory $(chalk "white" "$target_dir")")
    fi
  fi
}

function update() {
  local target_dir=$1
  local includes=("$@")
  printf "  %s %s\n" "$(chalk "yellow" "ℹ︎")" "Initiate dotfiles linking for $(chalk "white" "$target_dir")"
  shopt -s dotglob
  for file in "$dotfiles_dir"*; do
    filename=$(basename "$file")
    for include in "${includes[@]}"; do
      if [[ "$filename" == "$include" ]]; then
        toggle_link "$target_dir" "$filename" "$file"
      fi
    done
  done
  shopt -u dotglob
}

function run() {
  update "$root_target_dir" "${root_includes[@]}"
  update "$config_target_dir" "${config_includes[@]}"
  if [[ ${#errors[@]} -gt 0 ]]; then
    printf "  %s %s\n" "$(chalk "red" "✕")" "Completed with errors!" >&2
    for err in "${errors[@]}"; do
      log "$err"
    done
    exit 1
  else
    printf "  %s %s\n" "$(chalk "green" "✓")" "Successfully completed."
  fi
}

# --- interface ---
if [[ $1 == "--install" ]]; then
  run
elif [[ $1 == "--uninstall" ]]; then
  is_uninstall=true
  run
elif [[ "--help" == "$1" || -z "$1" ]]; then
  printf "%s <command>\n\n" "$HOME/dotfiles/bin/$(basename "$0")"
  printf "Handles the linking of configuration files.\n\n"
  printf "Options:\n"
  printf "  --help \tGet this help\n"
  printf "  --install \tWrites all symlinks for the corresponding files\n"
  printf "  --uninstall \tRemoves all symlinks for the corresponding files\n\n"
  exit 0
else
  printf "Unknown command: \"%s\"\n\n" "$1"
  printf "To see the list of supported commands, run:\n"
  printf "  %s --help\n\n" "$HOME/dotfiles/bin/$(basename "$0")"
  exit 0
fi
