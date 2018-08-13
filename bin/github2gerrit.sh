#!/bin/sh
set -euxo pipefail

git checkout master
git pull
git push vorburger

hub checkout $1
git rebase master

git commit -s --amend --reset-author
git review -D -t dependabot
