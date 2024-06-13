##############################################################################
# History Configuration
# https://www.soberkoder.com/better-zsh-history/
##############################################################################
export HISTDUP=erase             # Erase duplicates in the history file
export HISTFILE=~/.zsh_history   # path/location of the history file
export HISTSIZE=1000000000       # number of commands that are loaded into memory
export SAVEHIST=1000000000       # number of commands that are stored
export HISTTIMEFORMAT="[%F %T] " # Timestamp format for history

setopt APPEND_HISTORY       # Append history to the history file
setopt INC_APPEND_HISTORY   # Immediately append to the history file, not just when the shell exits
setopt SHARE_HISTORY        # Share history across terminals
setopt EXTENDED_HISTORY     # Save timestamp of command
setopt HIST_FIND_NO_DUPS    # Do not display duplicates in the history list
setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate
