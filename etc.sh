#!/usr/bin/env bash
set -euxo pipefail

sudo cp etc/udev/rules.d/50-uhk60.rules /etc/udev/rules.d/50-uhk60.rules
sudo udevadm trigger
sudo udevadm settle
