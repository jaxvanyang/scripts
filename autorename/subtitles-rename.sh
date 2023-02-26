#!/usr/bin/env bash
#
# Rename indexed subtitles with corresponding eposides.
# Subtitle files and video files must in the same directory.
#
# Usage:
# 	subtitles-rename [season] [eposides] [postfix]
#
# Naming example:
# 	"${S01E01_name}.mkv" + "${foo}S01E01${bar}.ass" -> "${S01E01_name}.${postfix}.ass"
# 	...
# 	"${S01E10_name}.mkv" + "${foo}S01E10${bar}.ass" -> "${S01E10_name}.${postfix}.ass"
#
# References:
# - https://support.emby.media/support/solutions/articles/44001159160-subtitles

set -ex

# Here are the variables for naming, don't forget that
# their values can be changed using command line arguments.
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
