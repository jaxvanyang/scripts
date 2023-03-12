#!/usr/bin/env bash
#
# Create directories for different files with the same suffix.
# And move them into the corresponding directories.
#
# Usage:
# 	automkdir <suffix>
#
# Examples:
# 	automkdir .pdf

automkdir() {
	for file in *"${1}"; do
		echo "Found ${file} end with ${1}"

		folder="$(basename "${file}" "${1}")/"
		mkdir -p "${folder}"
		echo "${folder} created"

		mv "${file}" "${folder}"
		echo "${file} has been moved into ${folder}"
	done
}

main() {
	if [ $# -ne 1 ]; then
		echo "You should specify one and only one suffix argument!" >&2
		exit 1
	fi

	automkdir "${1}"
}

main "$@"
