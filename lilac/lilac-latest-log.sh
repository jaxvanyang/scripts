#!/usr/bin/env bash

set -e

logdir="$HOME/.lilac/log"
latest_logdir=$(find "$logdir" -maxdepth 1 -type d | sort | tail -n 1)

cat "$latest_logdir/lilac-main.log"

for i in "$latest_logdir"/*.log; do
	name=$(basename "$i" .log)
	if [ "$name" = lilac-main ]; then
		continue;
	fi

	cat "$i"
done
