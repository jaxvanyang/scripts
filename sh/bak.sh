#!/usr/bin/env bash

set -e

while [ "$#" -ne 0 ]; do
	echo "mv $1 $1.bak"
	mv "$1" "$1.bak"
	shift
done
