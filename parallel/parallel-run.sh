#!/usr/bin/env bash
#
# Run script lines in parallel.
#
# Note: The script file must not contains single quote "'"
#
# Usage:
# 	parallel <script.sh>

parallel-run() {
	gawk '{print $0 " > " NR ".log"}' "${1}" | sed "s/^.*\$/'\0'/" | xargs -L 1 -P 4 sh -c
}

main() {
	if [ $# -ne 1 ]; then
		echo "You must specify one and only one argument!" >&2
		exit 1
	fi

	parallel-run "${1}"
}

main "$@"
