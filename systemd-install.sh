#!/usr/bin/env bash
set -euxo pipefail

echo "Installing systemd user units..."
mkdir -p ~/.config/systemd/user/
cp systemd/*.service systemd/*.timer ~/.config/systemd/user/
systemctl --user daemon-reload

echo "Enabling and starting timers..."
systemctl --user enable --now flatpak-update.timer
systemctl --user enable --now gh-triage.timer

echo
echo "Running initial gh-triage.service and waiting for it to complete..."
systemctl --user start --wait gh-triage.service

echo
echo "Verifying execution of gh-triage.service..."
# 'is-failed' returns exit code 0 if the unit IS failed.
if systemctl --user is-failed --quiet gh-triage.service; then
  echo "ERROR: gh-triage.service execution failed!" >&2
  echo "Displaying logs:" >&2
  journalctl --user --no-pager -u gh-triage.service
  exit 1
else
  echo "gh-triage.service completed successfully."
fi