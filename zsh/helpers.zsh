# --- helpers
function source_if_exists() {
  [[ -f "$1" ]] && source "$1"
}

function add_plugin() {
  local name=$(echo $1 | cut -d "/" -f 2)
  local target="$ZDOTDIR/plugins/$name"
  if [[ -d $target ]]; then
    source_if_exists "$target/$name.plugin.zsh" || \
      source_if_exists "$target/$name.zsh-theme" || \
      source_if_exists "$target/$name.zsh"
  else
    git clone "https://github.com/$1.git" "$target"
  fi
}
# helpers ---
