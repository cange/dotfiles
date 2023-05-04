# To source any files if it exist
function add_file() {
  [[ -f "$1" ]] && source "$1"
}

# To source files if it exist
function zsh_add_file() {
  [[ -f "$ZDOTDIR/$1" ]] && source "$ZDOTDIR/$1"
}

function zsh_add_plugin() {
  local name=$(echo $1 | cut -d "/" -f 2)
  if [[ -d "$ZDOTDIR/plugins/$name" ]]; then
    zsh_add_file "plugins/$name/$name.plugin.zsh" || \
    zsh_add_file "plugins/$name/$name.zsh-theme" || \
    zsh_add_file "plugins/$name/$name.zsh"
   else
    git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$name"
  fi
}
