#!/bin/bash
set -euxo pipefail
shellcheck "$0"

# TODO Fetch all open PRs from author:app/dependabot-preview and do the following in a loop
# UNLESS there's already a PR - and the latter is tricky part.

if [ "$#" -ne 1 ]; then
  echo "Parameter must be URL to Pull Request in a Fork on GitHub"
  exit 0
fi

git checkout develop
git pull origin
git fetch vorburger
git rebase vorburger/develop
git push vorburger

hub checkout "$1"
git rebase develop
git push vorburger --force

git commit --amend --reset-author
# see https://github.com/github/hub/issues/1827
hub pull-request -h "$(git rev-parse --abbrev-ref HEAD)"
