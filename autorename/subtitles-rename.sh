#!/usr/bin/env bash

season=01
eposides=10
postfix=".Chinese(中英双语).default"

rename() {
	for i in $(seq -f "%02g" "$eposides"); do
		id="S${season}E${i}"
		video="$(find . -name "*${id}*.mkv")"
		sub="$(find . -name "*${id}*.ass")"

		newname="${video//.mkv/${postfix}.ass}"

		mv "${sub}" "${newname}"
	done
}

main() {
	if [ $# -ne 0 ]; then
		season="$(printf '%02d' "${1}")"
		shift
	fi

	if [ $# -ne 0 ]; then
		eposides="${1}"
		shift
	fi

	if [ $# -ne 0 ]; then
		postfix="${1}"
		shift
	fi

	rename
}

main "$@"
