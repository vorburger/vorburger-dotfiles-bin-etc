# Do not stop for already installed extensions
xargs -I{} sh -c "code --install-extension {} || true" <dotfiles/code/extensions.txt

# See https://code.visualstudio.com/docs/editor/command-line#_working-with-extensions
