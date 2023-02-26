#!/usr/bin/env bash

# shellcheck disable=2086

season=01
eposides=10

rename() {
	for i in $(seq -f "%02g" $eposides); do
		id="S${season}E${i}"
		video="$(find . -name "*${id}*.mkv")"
		sub="$(find . -name "*${id}*.ass")"

		newname="${video//.mkv/.Chinese(中英双语).default.ass}"

		mv "${sub}" "${newname}"
	done
}

main() {
	if [ $# -ne 0 ]; then
		season="$(printf '%02d' ${1})"
		shift
	fi

	if [ $# -ne 0 ]; then
		eposides="${1}"
		shift
	fi

	rename
}

main "$@"
