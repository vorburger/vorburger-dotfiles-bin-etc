#!/usr/bin/env bash
set -euox pipefail

systemctl --user daemon-reload
systemctl --user restart dotfiles-fedora.service
journalctl --user -f -u dotfiles-fedora
