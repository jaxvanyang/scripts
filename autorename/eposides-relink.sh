#!/usr/bin/env bash
#
# Rename indexed eposides using standard TV naming,
# but hard link to a specific directory.
#
# Usage:
# 	eposides-relink [-d target_dir] [season] [eposides] [tv_name]
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
eposides=101
tv_name="灌篮高手"
target_dir="${PWD}"

relink() {
	for i in $(seq "$eposides"); do
		id="$(printf 'S%02dE%02d' "${season}" "${i}")"
		index="$(printf '%02d' "$i")"
		video="$(find . -name "*E${index}.*.mkv")"

		newname="${target_dir}/${tv_name} ${id}.mkv"

		ln -T "${video}" "${newname}"
	done
}

main() {
	local TEMP

	if ! TEMP=$(getopt -o 'd:' -n 'exposides-relink' -- "$@"); then
		echo 'getopt error. Terminating...' >&2
		exit 1
	fi

	eval set -- "${TEMP}"
	unset TEMP

	while true; do
		case "$1" in
		'-d')
			target_dir="$2"
			shift 2
			continue
			;;
		'--')
			shift
			break
			;;
		*)
			echo 'Internal error!' >&2
			exit 1
			;;
		esac
	done

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

	if [ ! -d "${target_dir}" ]; then
		echo "Target directory -- ${target_dir} not found. Terminating..." >&2
		exit 1
	fi

	relink
}

main "$@"
