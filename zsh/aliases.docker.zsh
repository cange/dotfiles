# calls docker-compose from within the services folder without specifying the
# service name
function _docker_compose() {
  local cmd=$1
  local dirname=$(basename $(pwd))
  shift 1
  docker-compose "$cmd" $dirname "$@"
}

# aliases
#
# --- docker compose
# see https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker-compose
alias dco="_docker_compose "     # Docker-compose main command
alias dce="dco exec"             # Execute command inside a container
alias dcdn="dco down"            # Stop and remove container
alias dcrb="dco up --detach --build --force-recreate" # Rebuild
alias dcbl="dco exec bundle"     # Execute Rails bundle command
alias dcy="dco exec yarn"        # Execute yarn command
alias dcrs="dco restart"         # Restart container
alias dcup="dco up --detach"     # Start container and its dependencies
alias dcl="dco logs --follow --tail=100" # Show container logs
# docker compose ---

# --- docker
# see #https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
# docker remove/prune unused docker images and volumes
alias dcprune="time docker container prune" # Remove all stopped containers
alias diprune="time docker image prune"     # Remove unused images
alias dvprune="time docker volume prune"    # Remove all unused local volumes
# docker ---