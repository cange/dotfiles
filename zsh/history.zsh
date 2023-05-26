##############################################################################
# History Configuration
# https://www.soberkoder.com/better-zsh-history/
##############################################################################
HISTDUP=erase               # Erase duplicates in the history file
HISTFILE=~/.zsh_history     # path/location of the history file
HISTSIZE=100000             # number of commands that are loaded into memory
SAVEHIST=100000             # number of commands that are stored

setopt APPEND_HISTORY       # Append history to the history file (no overwriting)
setopt HIST_FIND_NO_DUPS    # Do not display duplicates in the history list
setopt INC_APPEND_HISTORY   # Immediately append to the history file, not just when a term is killed
setopt SHARE_HISTORY        # Share history across terminals

export HISTTIMEFORMAT="[%F %T] " #
