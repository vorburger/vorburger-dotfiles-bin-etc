# Do not stop for already installed extensions
DIR=$(dirname $(realpath "$0"))
REPO_ROOT=$(realpath "$DIR/..")
xargs -I{} sh -c "code --install-extension {} || true" <"$REPO_ROOT/dotfiles/code/extensions.txt"

# See https://code.visualstudio.com/docs/editor/command-line#_working-with-extensions
