#!/usr/bin/env bash
#
# Run script lines in parallel.
#
# Usage:
# 	parallel <script.sh>

parallel-run() {
	sed "s/^.*$/\'\0\'/" "${1}" | xargs -L 1 -P 4 sh -c
}

main() {
	if [ $# -ne 1 ]; then
		echo "You must specify one and only one argument!" >&2
		exit 1
	fi

	parallel-run "${1}"
}

main "$@"
