# https://spaceship-prompt.sh/getting-started/#installing
source "$ZDOTDIR/plugins/spaceship-prompt/spaceship.zsh"

# Display time
SPACESHIP_TIME_SHOW=true

# Display username always
# SPACESHIP_USER_SHOW=always

# Do not truncate path in repos
SPACESHIP_DIR_TRUNC_REPO=false

# https://spaceship-prompt.sh/config/prompt/
# Prompt - left
SPACESHIP_PROMPT_ORDER=(
  dir
  git
  package
  node
  ruby
  lua
  rust
  docker
  aws
  python
  terraform
  exec_time
  async
  line_sep
  battery
  jobs
  exit_code
  char
)

# Rprompt - right
SPACESHIP_RPROMPT_ORDER=(
  user
  time
)

# Lang/service icons
SPACESHIP_AWS_SYMBOL="  "
SPACESHIP_CHAR_SYMBOL=" "
SPACESHIP_DOCKER_SYMBOL="  "
SPACESHIP_ELIXIR_SYMBOL="  "
SPACESHIP_LUA_SYMBOL="  "
SPACESHIP_NODE_SYMBOL="  "
SPACESHIP_PACKAGE_SYMBOL="  "
SPACESHIP_PYTHON_SYMBOL="  "
SPACESHIP_RUBY_SYMBOL="  "
SPACESHIP_RUST_SYMBOL="  "
# Git icons
SPACESHIP_GIT_SYMBOL="  "
SPACESHIP_GIT_STATUS_PREFIX="  "
SPACESHIP_GIT_STATUS_SUFFIX=""
SPACESHIP_GIT_STATUS_ADDED=" "
SPACESHIP_GIT_STATUS_MODIFIED=" "
SPACESHIP_GIT_STATUS_RENAMED=" "
SPACESHIP_GIT_STATUS_DELETED=" "
SPACESHIP_GIT_STATUS_STASHED=" "
SPACESHIP_GIT_STATUS_UNMERGED="ﱵ "
SPACESHIP_GIT_STATUS_AHEAD=" "
SPACESHIP_GIT_STATUS_BEHIND=" "
SPACESHIP_GIT_STATUS_DIVERGED=" "
