#!/usr/bin/env bash
set -euxo pipefail

# See README.md#Fonts
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip -d FiraCode/ FiraCode.zip

# https://docs.fedoraproject.org/en-US/quick-docs/fonts/#user-fonts--command-line
mkdir -vp ~/.local/share/fonts/FiraCode-Nerd/
mv FiraCode/*.ttf ~/.local/share/fonts/FiraCode-Nerd/
fc-cache -f -v

rm FiraCode/README.md FiraCode/LICENSE
rmdir FiraCode
rm FiraCode.zip

# https://github.com/ryanoasis/nerd-fonts/tree/master/bin/scripts/lib
wget https://raw.githubusercontent.com/ryanoasis/nerd-fonts/b16e67d6257eafed2d9a4250c640f3982f84bd8c/bin/scripts/lib/i_logos.sh -P ~/.local/share/fonts/
# shellcheck source=/dev/null.
source ~/.local/share/fonts/i_logos.sh
echo "${i_linux_fedora:?}"
