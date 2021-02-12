# similar in newer-GOROOT.sh

DOTFILES_BIN="$HOME/dev/vorburger-dotfiles-bin-etc/bin"

if ! [[ "$PATH" =~ "$DOTFILES_BIN" ]]
then
  PATH="$DOTFILES_BIN:$PATH"
fi
export PATH
