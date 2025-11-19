#!/bin/bash
#
# Sends a desktop notification about a failed systemd unit.
#
# This script is designed to be called by a systemd OnFailure= hook.
# It can be run by either a system or user service.
#
# Argument: The name of the failed unit (e.g., "cups.service")

set -euo pipefail

FAILED_UNIT="${1:-"Unknown Service"}"
SUMMARY="Systemd Service Failure"
BODY="The service '$FAILED_UNIT' has failed."

# --- Send Notification ---
# For user services, we can directly try to send the notification.
# The environment should be mostly correct.

# We need to set the DBUS_SESSION_BUS_ADDRESS for notify-send to work.
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

/usr/bin/notify-send \
    --urgency=critical \
    --icon=dialog-error \
    "$SUMMARY" \
    "$BODY"

logger "systemd-failure-notify: Attempted to send notification about failure of '$FAILED_UNIT'."