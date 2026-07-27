#!/bin/zsh
source "$(dirname "$0")/_shared.sh"

is_uninstall=0

if [[ $# -eq 0 || "$1" == "--help" || "$1" == "-h" ]]; then
  help
  exit 0
fi

perform_install "$@" || {
  help
  exit 1
}
