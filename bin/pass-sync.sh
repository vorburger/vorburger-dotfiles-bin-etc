#!/usr/bin/env bash
SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
pushd .
cd ~/.password-store/
git pull --rebase
git push
popd
