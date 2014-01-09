#!/bin/sh
set -e
(
	cd vim/bundle
	for submodule in *; do
		if [ -e "$submodule/.git" ]; then
			(
				cd "$submodule"
				echo "===> $submodule"

				if git local-branches | grep -q develop; then
					git checkout --quiet develop
				else
					git checkout --quiet master
				fi
				git pull --quiet
			)
		fi
	done
)
