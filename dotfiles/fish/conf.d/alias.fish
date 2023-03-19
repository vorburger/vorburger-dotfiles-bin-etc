# These aliases are Fish specific
# Common ones are in dotfiles/alias (bash specific in dotfiles/bash.d/alias.bash)

status is-interactive || exit

# see also bash.d/alias.bash
if type -q code && test -z "$SSH_CONNECTION"; or string match -q "$TERM_PROGRAM" "vscode"
    set -Ux EDITOR "code --wait"
    alias e="code "
else
    alias e="nano "
    set -Ux EDITOR nano
end

command -sq lsd && alias l="lsd "
command -sq lsd && alias ll="lsd -l "
command -sq lsd && alias lt="lsd --tree "
command -sq bat && alias c="bat "
command -sq rg  && alias f="rg "
# Note dotfiles/ripgreprc.properties!

complete --command b --wraps bazelisk --wraps bazel
complete --command g --wraps git
complete --command kubecolor --wraps kubectl
complete --command k --wraps kubecolor
complete --command m --wraps mvn

# see docs/podman.md
test -f /usr/bin/podman-remote && \
  complete --command podman --wraps podman-remote && \
  complete --command docker --wraps podman-remote
