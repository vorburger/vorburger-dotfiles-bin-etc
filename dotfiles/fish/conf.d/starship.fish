# /etc/starship.toml is created in symlink-homefree.sh

test -f /etc/starship.toml && set -Ux STARSHIP_CONFIG /etc/starship.toml
