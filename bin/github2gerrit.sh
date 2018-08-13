#!/bin/sh
set -euxo pipefail

git checkout master
git pull
git push vorburger

/home/vorburger/bin/hub-v2.2.0-13-g4cc48e1 checkout $1
# see https://github.com/github/hub/issues/1708
# hub checkout $1
git rebase master

git commit -s --amend --reset-author
git review -D -t dependabot
