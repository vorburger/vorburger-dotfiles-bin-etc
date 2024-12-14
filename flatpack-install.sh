#!/usr/bin/env bash
set -euxo pipefail

cp systemd/flatpak-update.service systemd/flatpak-update.timer ~/.config/systemd/user/
systemctl --user enable flatpak-update.timer
systemctl --user start flatpak-update.timer
