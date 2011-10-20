#!/bin/sh
oldcwd=$(pwd)

cd "$(dirname "$0")"
for submodule in *; do
	if [ -d "$submodule/.git" ]; then
		cd "$submodule"
		echo "--- $submodule:"
		if [ "$submodule" = "pyunit" ]; then
			git checkout develop
		else
			git checkout master
		fi
		git pull
		cd ..
	fi
done

cd "$oldcwd"
