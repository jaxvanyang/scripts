#!/usr/bin/env bash

# shellcheck disable=2086

season=01
eposides=10

rename() {
	for i in $(seq -f "%02g" $eposides); do
		id="S${season}E${i}"
		video="$(ls -- *${id}*.mkv)"
		sub="$(ls -- *${id}*.ass)"

		newname="${video//.mkv/.Chinese-English.ass}"

		mv "${sub}" "${newname}"
	done
}

main() {
	if [ $# -ge 1 ]; then
		season="$(printf '%02d' ${1})"
	fi

	if [ $# -ge 2 ]; then
		eposides="${2}"
	fi

	rename
}

main "$@"
