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

# PS: The font families often used in documents which originated on Microsoft Windows are a PITA.
# [_Liberation_ Fonts](https://en.wikipedia.org/wiki/Liberation_fonts) (`liberation-fonts`) have an _Arial_ "equivalent";
# the problem is that ["Font Substitution"](https://docs.fedoraproject.org/en-US/packaging-guidelines/FontsPolicy/) does not always work - e.g. in Google Sheets.

# TODO? Script manually DL & install Arial somehow from somewhere?! Nah, not worth the effort.
