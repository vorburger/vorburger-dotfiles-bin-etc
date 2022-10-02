#!/usr/bin/env bash
set -eox pipefail

# NOT SSH_COMMAND="${1:-fish}"
if [ -z "$1" ]; then
  SSH_COMMAND="fish"
else
  SSH_COMMAND="$@"
fi

ssh -At -p 2222 -o "StrictHostKeyChecking=no" -o UserKnownHostsFile=/dev/null vorburger@localhost -- "$SSH_COMMAND"
