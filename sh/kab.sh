#!/usr/bin/env bash

set -e

while [ "$#" -ne 0 ]; do
	target="$(dirname "$1")/$(basename "$1" .bak)"
	echo "mv $1 $target"
	mv "$1" "$target"
	shift
done
