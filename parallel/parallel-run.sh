#!/usr/bin/env bash
#
# Run script lines in parallel.
#
# Note: The script file must not contains single quote "'"
#
# Usage:
# 	parallel <script.sh> [n_process]

parallel-run() {
	gawk '{print $0 " &> " NR ".log"}' "${1}" | sed "s/^.*\$/'\0'/" | xargs -L 1 -P "${n_process}" sh -c
}

main() {
	n_process="$(nproc)"

	if [ $# -lt 1 ] || [ $# -gt 2 ]; then
		echo "You must specify one or two arguments!" >&2
		exit 1
	fi

	if [ $# -eq 2 ]; then
		n_process="${2}"
	fi

	parallel-run "${1}" "${n_process}"
}

main "$@"
