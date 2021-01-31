# grep history
ghi() {
  history | cut -c8- | grep "$@" | uniq
}

# http://linuxg.net/ignore-duplicate-entries-in-the-bash-history/
# ignore the duplicates and the command starting with space and remove the previous line matching with the line of the current command.
export HISTCONTROL=ignoreboth:erasedups

# append to the history file rather than overwrite it
shopt -s histappend

# Annotate the history lines with timestamps in .bash_history
export HISTTIMEFORMAT=""

# Alt+up and Alt+down complete the last appearance of an argument
# bind '"\e[1;3A": dabbrev-expand' '"\e[1;3B": "\e-\e[1;3A"'
