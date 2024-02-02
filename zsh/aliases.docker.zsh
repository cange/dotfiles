#!/bin/zsh

export CANGE_OLD_PWD=$PWD
local _cached_compose_file=$COMPOSE_FILE

# File detection mechanism to automatically detect the appropriate Docker
function _docker_compose_init_detection() {
	local dir_state=""

	function log() {
		local title="$(_chalk "blue" "󰡨") docker compose:"
		printf "%s %s %s\n" "$title" "$1" "$dir_state"
		dir_state=""
	}

	function file_level_dir_depth() {
		local file_to_find="$1"
		local current_dir="$PWD"
		local level_count=1

		while [[ "$current_dir" != "/" ]]; do
			level_count=$(($level_count + 1))
			if [[ -e "$current_dir/$file_to_find" ]]; then
				return 0
			fi
			current_dir=$(dirname "$current_dir")
		done
		echo $level_count
		level_count=0
		return 1
	}

	function _docker_compose_detect_file() {
		# continue when docker project
		if [[ ! -e "Dockerfile" ]]; then return 0; fi

		local files=("docker-compose.yml" "docker-compose.yaml" "compose.yml" "compose.yaml")
		local count=$1
		local file="${files[$count]}"

		if [[ $count -gt ${#files[@]} && -z $COMPOSE_FILE ]]; then
			export COMPOSE_FILE=$_cached_compose_file
			log "No local file detected! Reset to default $(_chalk "bold" "\$COMPOSE_FILE")"
			return 0
		fi

		local dir_level=$(printf "%d" "$(file_level_dir_depth "$file")")

		if [[ ($dir_level -eq 0 && -e $file) ]]; then
			_cached_compose_file=$([[ -z $COMPOSE_FILE ]] && print $_cached_compose_file || print $COMPOSE_FILE)
			unset COMPOSE_PROJECT_NAME
			unset COMPOSE_FILE
			log "File detected! Unset $(_chalk "bold" "\$COMPOSE_FILE, \$COMPOSE_PROJECT_NAME")"
			return 0
		elif [[ $dir_level -eq 0 && $file != $COMPOSE_FILE ]]; then
			return 0
		else
			_docker_compose_detect_file $(($count + 1))
			return 0
		fi
	}

	# initialise detection
	_docker_compose_detect_file 1

	# Hook to triggered when the current directory changes
	function _docker_compose_chpwd_hook() {
		if [[ -z $CANGE_OLD_PWD ]]; then CANGE_OLD_PWD=$PWD; fi

		if [[ $PWD != $CANGE_OLD_PWD ]]; then
			CANGE_OLD_PWD=$PWD
			dir_state="$(_chalk "yellow" "󰛨") Dir changed!"
			_docker_compose_detect_file 1
		fi
	}

	# Enable chpwd hook
	add-zsh-hook chpwd _docker_compose_chpwd_hook
}

_docker_compose_init_detection

# Execute `docker compose` from within a services directory and the dir name as
# project name.
function _docker_compose() {
	local cmd=$1
	local dirname=$([[ -z $COMPOSE_PROJECT_NAME ]] && print "" || print $(basename $(pwd)))
	shift 1
	docker-compose "$cmd" $dirname "$@"
}

# aliases
#
# --- docker compose
# see https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker-compose
alias dco="_docker_compose "                        # Docker-compose main command
alias dcbl="_docker_compose exec bundle"            # Execute Rails bundle command
alias dcdn="_docker_compose down"                   # Stop and remove container
alias dce="_docker_compose exec"                    # Execute command inside a container
alias dcl="_docker_compose logs --follow --tail=10" # Show container logs
alias dcrb="dcup --build --force-recreate"          # Rebuild
alias dcrbl="dcrb && dcl"                           # Rebuild with followup log
alias dcrs="_docker_compose restart && dcl"         # Restart container and show logs
alias dcup="_docker_compose up --detach"            # Start container and its dependencies
alias dcy="_docker_compose exec yarn"               # Execute yarn command
# docker compose ---

# --- docker
# see #https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
# docker remove/prune unused docker images and volumes
alias dcprune="time docker container prune" # Remove all stopped containers
alias diprune="time docker image prune"     # Remove unused images
alias dvprune="time docker volume prune"    # Remove all unused local volumes
# docker ---
