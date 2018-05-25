#!/bin/sh
set -euxo pipefail

DIR="$(realpath $(dirname $0))"

# TODO make this a function
rm ~/bin/github2gerrit.sh
ln -s $DIR/bin/github2gerrit.sh ~/bin/github2gerrit.sh
