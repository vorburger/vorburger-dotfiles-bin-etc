# These aliases are Fish specific
# Common ones are in dotfiles/alias (bash specific in dotfiles/bash.d/alias.bash)

test -f /usr/bin/lsd && alias l="lsd "
test -f /usr/bin/lsd && alias ll="lsd -l "
test -f /usr/bin/bat && alias c="bat "

complete --command g --wraps git
complete --command kubecolor --wraps kubectl
complete --command k --wraps kubecolor
complete --command m --wraps mvn
