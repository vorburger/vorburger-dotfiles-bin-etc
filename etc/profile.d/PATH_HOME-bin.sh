# TODO This doesn't actually seem to work, because
# bash started in a container does not seem to read /etc/profile.
# https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html
PATH="$PATH:$HOME/bin"

echo "hello, world from /etc/profile.d/PATH_HOME-bin.sh"
