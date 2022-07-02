#!/usr/bin/env bash
set -euox pipefail

ssh -At -p 2222 -o "StrictHostKeyChecking=no" -o UserKnownHostsFile=/dev/null vorburger@localhost -- fish
