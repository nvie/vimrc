#!/bin/sh
set -e

if [ $# -lt 1 ]; then
    echo "Choices are:"
    ls vim/pack/nvie/start
    echo
    echo "Bundle name? \c"
    read name
else
    name="$1"
fi

name=$(basename "$name")
path="vim/pack/nvie/start/${name%/}"
rm -rf "$path"
git submodule deinit --force "$path"
git rm -rf "$path"
