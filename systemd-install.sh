#!/usr/bin/env bash
set -euo pipefail

# This script has two modes:
# 1. Run as a regular user to install user-level systemd services.
# 2. Run with 'sudo' to install system-level failure notifications.

# Ensure paths are resolved relative to the script's location
cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null

# Function to run a one-shot user service, wait for it, and verify it succeeded.
start_and_verify_oneshot_service() {
  local service_name="$1"
  echo
  echo "Running initial ${service_name} and waiting for it to complete..."
  systemctl --user start --wait "${service_name}"

  echo "Verifying execution of ${service_name}..."
  if systemctl --user is-failed --quiet "${service_name}"; then
    echo "ERROR: ${service_name} execution failed!" >&2
    echo "Displaying logs:" >&2
    journalctl --user --no-pager -u "${service_name}"
    exit 1
  else
    echo "${service_name} completed successfully."
  fi
}

if [ "$EUID" -ne 0 ]; then
  # --- User Mode ---
  echo "Running in User Mode to install user services."
  INSTALL_DIR=$(pwd)

  echo "Installing systemd user units (recursively)..."
  mkdir -p ~/.config/systemd/user/
  # Copy everything except the template service that needs path replacement
  find systemd -mindepth 1 -maxdepth 1 ! -name 'failure-notification@.service' -exec cp -r '{}' ~/.config/systemd/user/ \; 

  # Process and install the notification service with the correct path
  sed "s|__DOTFILES_PATH__|${INSTALL_DIR}|g" systemd/failure-notification@.service > ~/.config/systemd/user/failure-notification@.service

  systemctl --user daemon-reload

  echo
  echo "Enabling and starting timers..."
  systemctl --user enable --now flatpak-update.timer
  systemctl --user enable --now gh-triage.timer

  start_and_verify_oneshot_service "gh-triage.service"
  start_and_verify_oneshot_service "flatpak-update.service"

  echo
  echo "---"
  echo "User-level failure monitoring is now active."
  echo "To enable system-wide failure notifications, please re-run this script with sudo:"
  echo "  sudo $0"

else
  # --- Sudo/Root Mode ---
  echo "Running with sudo. Installing ONLY the system-level failure notification service..."

  INSTALL_DIR=$(pwd)

  # Process and install the systemd service unit with the correct absolute path
  sed "s|__DOTFILES_PATH__|${INSTALL_DIR}|g" systemd/failure-notification@.service > /etc/systemd/system/failure-notification@.service

  # Install the global OnFailure drop-in from the static file
  mkdir -p /etc/systemd/system/service.d
  cp systemd/service.d/10-on-failure.conf /etc/systemd/system/service.d/

  systemctl daemon-reload
  echo "System-level failure monitoring is now active."
fi
