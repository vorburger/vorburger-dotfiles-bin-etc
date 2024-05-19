#!/usr/bin/env bash

# https://docs.fedoraproject.org/en-US/quick-docs/upgrading-fedora-offline/#sect-clean-up-old-kernels

old_kernels=($(dnf repoquery --installonly --latest-limit=-1 -q))
if [ "${#old_kernels[@]}" -eq 0 ]; then
    echo "No old kernels found"
    exit 0
fi

if ! dnf remove "${old_kernels[@]}"; then
    echo "Failed to remove old kernels"
    exit 1
fi

echo "Removed old kernels"
exit 0
