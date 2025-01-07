export _USER_OLD_PWD=$PWD

function _docker_compose_init_detection() {
  local init_compose_file=$COMPOSE_FILE
  local log_dir_state=""

  function log() {
    local title="$(_chalk "blue" "󰡨") docker compose:"
    printf "%s %s %s %s\n" "$title" "$1" "$(_chalk "bold" "\$COMPOSE_FILE")" "$log_dir_state"
    log_dir_state=""
  }

  function _docker_compose_detect_file() {
    if [[ ! -e "Dockerfile" ]]; then return 0; fi

    local files=("docker-compose.yml" "docker-compose.yaml" "compose.yml" "compose.yaml")
    local count=$1

    if [[ $count -gt ${#files[@]} && -z $COMPOSE_FILE ]]; then
      export COMPOSE_FILE=$init_compose_file
      log "No local file detected! Reset to default"
      return 0
    fi

    if [[ -e "${files[$count]}" ]]; then
      unset COMPOSE_FILE
      log "File detected! Unset"
      return 0
    else
      _docker_compose_detect_file $((count + 1))
      return 0
    fi
  }

  _docker_compose_detect_file 0

  function _docker_compose_chpwd_hook() {
    if [[ -z $_USER_OLD_PWD ]]; then _USER_OLD_PWD=$PWD; fi

    if [[ $PWD != $_USER_OLD_PWD ]]; then
      _USER_OLD_PWD=$PWD
      _docker_compose_detect_file 0
    fi
  }

  add-zsh-hook chpwd _docker_compose_chpwd_hook
}

_docker_compose_init_detection

function _docker_compose() {
  local cmd=$1
  local dirname=$([[ -z $COMPOSE_PROJECT_NAME ]] && echo "" || basename "$PWD")
  shift
  docker-compose "$cmd" $dirname "$@"
}

#
# --- docker compose
alias dco="_docker_compose"
alias dcbl="_docker_compose exec bundle"
alias dcdn="_docker_compose down"
alias dce="_docker_compose exec"
alias dcl="_docker_compose logs --follow --tail=10"
alias dcrb="dcup --build --force-recreate"
alias dcrbl="dcrb && dcl"
alias dcrs="_docker_compose restart && dcl"
alias dcrsh="dco down && dcup && dcl app"
alias dcup="_docker_compose up --detach"
alias dcy="_docker_compose exec yarn"
# docker compose ---
#

#
# --- docker
# see #https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
# docker remove/prune unused docker images and volumes
alias dcprune="time docker container prune" # Remove all stopped containers
alias diprune="time docker image prune"     # Remove unused images
alias dvprune="time docker volume prune"    # Remove all unused local volumes
# docker ---
#
