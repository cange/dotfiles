#!/bin/zsh

export CANGE_OLD_PWD=$PWD
local _cange_cached_compose_file=$COMPOSE_FILE

# Execute `docker compose` from within a services directory and the the dir name as project name.
function _cange_docker_compose() {
	local cmd=$1
	local dirname=$([[ -z $COMPOSE_PROJECT_NAME ]] && print "" || print $(basename $(pwd)))
	shift 1
	docker-compose "$cmd" $dirname "$@"
}

function _cange_docker_compose_init() {
	local file_match=''
	local dir_state=""

	function log() {
		local title="$(_cange_chalk "blue" "󰡨") docker compose:"
		print "$title$dir_state $1"
	}

	function find_file_upwards() {
		local file_to_find="$1"
		local current_dir="$PWD"

		while [[ "$current_dir" != "/" ]]; do
			if [[ -e "$current_dir/$file_to_find" ]]; then
				file_match=$file_to_find
				return 0 # Success, file found
			fi
			current_dir=$(dirname "$current_dir")
		done
		return 1 # Failure, file not found
	}

	function _cange_docker_compose_detect_file() {
		local files=("docker-compose.yml" "docker-compose.yaml" "compose.yml" "compose.yaml")
		local count=$1
		local file="${files[$count]}"

		if [[ $count -gt ${#files[@]} ]]; then
			export COMPOSE_FILE=$_cange_cached_compose_file
			log "No local file detected! Restore defaults $(_cange_chalk "bold" "\$COMPOSE_FILE, \$COMPOSE_PROJECT_NAME")"
			return 0
		fi

		find_file_upwards "$file"

		if [[ (${#file_match} -gt 0 && $file != $COMPOSE_FILE) ]]; then
			_cange_cached_compose_file=$([[ -z $COMPOSE_FILE ]] && print $_cange_cached_compose_file || print $COMPOSE_FILE)
			unset COMPOSE_PROJECT_NAME
			unset COMPOSE_FILE
			log "File detected! Unset $(_cange_chalk "bold" "\$COMPOSE_FILE, \$COMPOSE_PROJECT_NAME")"
			return 0
		else _cange_docker_compose_detect_file $(($count + 1)); fi

		return 1 # no file found
	}

	# initialise detection
	_cange_docker_compose_detect_file 1

	function _cange_docker_compose_chpwd() {
		if [[ -z $CANGE_OLD_PWD ]]; then CANGE_OLD_PWD=$PWD; fi

		if [[ $PWD != $CANGE_OLD_PWD ]]; then
			CANGE_OLD_PWD=$PWD
			dir_state=" 󰁔 directory changed!"
			_cange_docker_compose_detect_file 1
		fi
	}

	# Enable the chpwd hook
	add-zsh-hook chpwd _cange_docker_compose_chpwd
	dir_state=""
}

_cange_docker_compose_init

# aliases
#
# --- docker compose
# see https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker-compose
alias dco="_cange_docker_compose "                        # Docker-compose main command
alias dcbl="_cange_docker_compose exec bundle"            # Execute Rails bundle command
alias dcdn="_cange_docker_compose down"                   # Stop and remove container
alias dce="_cange_docker_compose exec"                    # Execute command inside a container
alias dcl="_cange_docker_compose logs --follow --tail=10" # Show container logs
alias dcrb="dcup --build --force-recreate"                # Rebuild
alias dcrbl="dcrb && dcl"                                 # Rebuild with followup log
alias dcrs="_cange_docker_compose restart && dcl"         # Restart container and show logs
alias dcup="_cange_docker_compose up --detach"            # Start container and its dependencies
alias dcy="_cange_docker_compose exec yarn"               # Execute yarn command
# docker compose ---

# --- docker
# see #https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
# docker remove/prune unused docker images and volumes
alias dcprune="time docker container prune" # Remove all stopped containers
alias diprune="time docker image prune"     # Remove unused images
alias dvprune="time docker volume prune"    # Remove all unused local volumes
# docker ---
