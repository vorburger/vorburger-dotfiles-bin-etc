#!/bin/sh
set -euxo pipefail

git checkout master
git pull
hub checkout $1
git commit -s --amend
git review -D -t dependabot
