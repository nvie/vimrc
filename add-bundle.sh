#!/bin/sh
if [ $# -lt 1 ]; then
    echo "Bundle URL? \c"
    read url
else
    url="$1"
fi
git submodules add "$url" vim/bundle/$(basename "$url" | sed 's/\.git$//')
