# similar to vorburger-dotfiles-bin.sh
# see https://golang.org/doc/manage-install
# set -x

if ! [[ -x "$(command -v "go")" ]]; then
  GOROOT_BIN=$(go1.15.8 env GOROOT)/bin
  PATH="$GOROOT_BIN:$PATH"
fi
export PATH
