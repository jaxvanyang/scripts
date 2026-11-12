#!/usr/bin/env bash

set -e

while [ "$#" -ne 0 ]; do
	echo "cp $1 $1.bak"
	cp "$1" "$1.bak"
	shift
done
