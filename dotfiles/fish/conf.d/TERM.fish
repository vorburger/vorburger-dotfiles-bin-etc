# This makes e.g. colours in nano look better, and e.g. fzf look (much) cooler.
#
# NOTE: Colours will only work if "tput colors" prints 256 (or 16777216) instead of 8.
# This is determined by $TERM which should 'screen-256color' (in TMUX) or 'xterm-256color' insted of xterm.
# "sudo apt install colortest && colortest-256/16b" helps to identify if the terminal is capable of 256.
#
# Moar? 24-bit color for terminals (e.g. https://wiki.archlinux.org/title/Tmux#24-bit_color) - unclear.
# $COLORTERM has something to do with that.
#
# It's technically incorrect to do it here like this,
# because "the terminal should it, not the shell" BUT
# I don't know how to do that so that it works in containers
# e.g. on Theia in Google Cloud Shell & GitHub Codespaces.
#
# It should perhaps also distinguish if it's really running
# in screen (~= TMUX) and otherwise use xterm-256color instead,
# but I always run everything in a TMUX anyway (either locally with Kitty
# or through a web terminal) so this seems fine.
#
# My .tmux.conf has: set-option -g default-terminal "screen-256color"
#
# So let's just hard-code it.

set -gx TERM screen-256color
