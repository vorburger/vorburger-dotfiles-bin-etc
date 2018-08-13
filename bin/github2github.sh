#!/bin/sh
set -euxo pipefail

git checkout master
git pull origin
git push vorburger

hub checkout $1
git rebase master
git push vorburger --force

git commit --amend --reset-author
# see https://github.com/github/hub/issues/1827
hub pull-request -h $(git rev-parse --abbrev-ref HEAD)
