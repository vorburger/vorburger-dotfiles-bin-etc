DIR=$(dirname $(realpath "$0"))
REPO_ROOT=$(realpath "$DIR/..")
code --list-extensions --show-versions | sort > "$REPO_ROOT/dotfiles/code/extensions.txt"
git -C "$REPO_ROOT" add dotfiles/code/extensions.txt
git -C "$REPO_ROOT" commit -m "VSC: Extensions Update"
git -C "$REPO_ROOT" show HEAD
