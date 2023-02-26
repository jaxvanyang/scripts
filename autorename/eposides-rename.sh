#!/usr/bin/env bash
#
# Rename indexed eposides using standard TV naming.
#
# Usage:
# 	eposides-rename [season] [eposides] [tv_name]
#
# Naming example:
# 	"${foo}1${bar}.mp4" -> "${tv_name} S${season}E01${bar}.mp4"
# 	...
# 	"${foo}12${bar}.mp4" -> "${tv_name} S${season}E12${bar}.mp4"
#
# References:
# - https://support.emby.media/support/solutions/articles/44001159110-tv-naming

set -ex

# Here are the variables for naming, don't forget their values
# can be changed using command line arguments.
season=01
eposides=12
tv_name="灵能百分百"

rename() {
	for i in $(seq "$eposides"); do
		id="$(printf 'S%02dE%02d' "${season}" "${i}")"
		video="$(find . -name "*第${i}话*.mp4")"

		newname=${video//*第${i}话/${tv_name} ${id}}

		mv "${video}" "${newname}"
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
		tv_name="${1}"
		shift
	fi

	rename
}

main "$@"
