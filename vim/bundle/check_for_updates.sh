#!/bin/sh
oldcwd=$(pwd)

cd "$(dirname "$0")"
for submodule in *; do
	if [ -d "$submodule/.git" ]; then
		cd "$submodule"
		echo "--- $submodule:"
		if [ "$submodule" = "pyunit" ]; then
			git co develop
		else
			git co master
		fi
		git pull
		cd ..
	fi
done

cd "$oldcwd"
