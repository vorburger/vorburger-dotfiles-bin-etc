code --list-extensions --show-versions | sort > dotfiles/code/extensions.txt
git add dotfiles/code/extensions.txt
git commit -m "VSC: Extensions Update"
