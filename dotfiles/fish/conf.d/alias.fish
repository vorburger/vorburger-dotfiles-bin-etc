# These aliases are Fish specific
# Common ones are in dotfiles/alias (bash specific in dotfiles/bash.d/alias.bash)

status is-interactive || exit

# see also bash.d/alias.bash
if type -q code
    set -Ux EDITOR "code --wait"
    alias e="code "
else
    alias e="nano "
    set -Ux EDITOR nano
end

test -f /usr/bin/lsd && alias l="lsd "
test -f /usr/bin/lsd && alias ll="lsd -l "
test -f /usr/bin/bat && alias c="bat "

complete --command b --wraps bazelisk --wraps bazel
complete --command g --wraps git
complete --command kubecolor --wraps kubectl
complete --command k --wraps kubecolor
complete --command m --wraps mvn

# see docs/podman.md
test -f /usr/bin/podman-remote && \
  complete --command podman --wraps podman-remote && \
  complete --command docker --wraps podman-remote
